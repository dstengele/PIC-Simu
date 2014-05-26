//
//  PSSourceFile.m
//  PIC-Simu
//
//  Created by Dennis Stengele on 31/03/14.
//  Copyright (c) 2014 Dennis Stengele. All rights reserved.
//

#import "PSVirtualPIC.h"
#import "PSLineOfCode.h"
#import "PSInstruction.h"
#import "PSAppDelegate.h"

@implementation PSVirtualPIC

@synthesize fileContents;
@synthesize storage;
@synthesize locArrayController;
@synthesize wdt;
@synthesize callStack;
@synthesize codeView;
@synthesize stackView;
@synthesize runtimeCounter;
@synthesize cycleDuration;		// bis zu 10 MHz real (10MHz == cycleDuration=0.0000001)

	// Init-Methode. Initialisiert Array für Dateiinhalt und setzt Quarzgeschwindigkeit auf 50 MHz
- (id)init {
	self = [super init];
	if (self) {
		fileContents = [[NSMutableArray alloc] init];
		self.cycleDurationSlider = 50;
	}
	return self;
}

	// Initialisieren mit einer geöffneten Textdatei
- (void)initWithTextFile:(NSURL *)sourceFile {
		// Datei laden und -inhalt in NSString konvertieren (Datei muss UTF-8-kodiert sein)
	NSStringEncoding usedEnc;
	NSString* fileString = [NSString stringWithContentsOfURL:sourceFile
												usedEncoding:&usedEnc
													   error:nil];
	NSLog(@"Opened File %@ using Encoding:%lu", sourceFile, usedEnc);

		// Trennen am Zeilenumbruch
	NSString* delimiter = @"\n";

		// Dateiinhalt als Array in Instanzvariable speichern

	NSArray *fileArray = [fileString componentsSeparatedByString:delimiter];

		// Alle vielleicht bereits vorhandenen Codezeilen aus dem Array entfernen (falls bereits eine Datei geladen ist.
	[[self.locArrayController content] removeAllObjects];

		// Datei Zeile für Zeile einlesen
	for (NSString *loc in fileArray) {
		PSLineOfCode *new_loc = [[PSLineOfCode alloc] init];
		new_loc.loc = loc;
			// Exception abfangen, wenn leere Codezeile eingelesen wird.
		@try {
			new_loc.instruction = [loc substringWithRange:NSMakeRange(5, 4)];
			new_loc.programCounter = [loc substringWithRange:NSMakeRange(0, 4)];
		}
		@catch (NSException *exception) {
			NSLog(@"Fehler beim Lesen der Zeile %@: %@", loc, exception);
		}
		[self.locArrayController addObject:new_loc];
	}
	
		// Erste Zeile highlighten und hinscrollen
	NSIndexSet *rows = [NSIndexSet indexSetWithIndex:0];
	[self.codeView selectRowIndexes:rows byExtendingSelection:FALSE];
	
	[codeView scrollRowToVisible:0];
	
		// Call Stack vorbereiten
	if (self.callStack == nil) {
		self.callStack = [[PSCallStack alloc] init];
	} else {
		[self.callStack clear];
	}
}

	// Prohibits selection in TableView showing Code
- (NSIndexSet *)tableView:(NSTableView *)tableView selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes {
	return NO;
}

- (BOOL)executeNextInstruction {
		// Nächste Instruktion auf Basis des PC ermitteln
	NSUInteger nextInstructionRow = NSNotFound;
	nextInstructionRow = [self.fileContents indexOfObjectPassingTest:
							  ^BOOL(id obj, NSUInteger idx, BOOL *stop){
								  PSLineOfCode *l = obj;
								  if ([l.programCounter  isEqual: @"    "]) {
									  return FALSE;
								  }
								  NSScanner *scanner = [NSScanner scannerWithString:l.programCounter];
								  uint parsedPc;
								  [scanner scanHexInt:&parsedPc];
								  uint16_t pc = self.storage.pc;
								  if (pc == (NSInteger)parsedPc) {
									  return TRUE;
								  }
								  return FALSE;
							  }
							  ];
		// Falls PC nicht im Source vorhanden, Exception werfen
	if (nextInstructionRow == NSNotFound) {
		[NSException raise:@"Illegal Value in PCL or PCLATH Register!" format:@"FormatError"];
	}

		// Referenz auf aktuelle Zeile
	PSLineOfCode *loc = [self.fileContents objectAtIndex:nextInstructionRow];
	
		// Bei Breakpoint Ausführung abbrechen. Return-Wert false stoppt den Timer
	if (loc.hasBreakpoint) {
		return false;
	}
	
		//Instruction als String auslesen
	NSString *instructionString = [[self.fileContents objectAtIndex:nextInstructionRow] instruction];

		// Instruction in Zahl parsen
	NSScanner *scanner = [NSScanner scannerWithString:instructionString];
	uint instructionBinary;
	[scanner scanHexInt:&instructionBinary];
		// Neues PSInstruction-Objekt erstellen, mit eingelesenem Bitmuster
	PSInstruction *instruction = [[PSInstruction alloc] initWithBits:(uint16_t)instructionBinary];
	
		// Instruktion ausführen
	[instruction executeWithVirtualPIC:self];

		// Nächste Zeile highlighten und hinscrollen
	NSIndexSet *rows = [NSIndexSet indexSetWithIndex:nextInstructionRow];
	[self.codeView selectRowIndexes:rows byExtendingSelection:FALSE];
	[self.codeView scrollRowToVisible:nextInstructionRow];
	
		// Keine Zeile ausgewählt in der StackView
	[self.stackView deselectAll:self];

		// Programmzähler erhöhen
	[self.storage incrementPc];
		// Auf TMR0-Interrupt prüfen
	if ([self.storage checkTmrInt]) {
		[self.callStack push:self.storage.pc];
		[self.storage setPc:4];
	}
		// Auf RB0-Interrupt prüfen
	if ([self.storage checkrb0Int]) {
		[self.callStack push:self.storage.pc];
		[self.storage setPc:4];
	}
		// Auf PORTB-Interrupt prüfen
	if ([self.storage checkportbInt]) {
		[self.callStack push:self.storage.pc];
		[self.storage setPc:4];
	}
		// File-Register-View updaten
	[self updateFileRegisters];

		// Laufzeitzähler erhöhen
	self.runtimeCounter++;
		// Laufzeitzähler-View updaten
	[self updateRuntimeCounterViews];
	return true;
}

	// Wird vom Timer automatisch aufgerufen
- (void)timerFireMethod:(NSTimer *)timer {
		// Wenn false zurückgegeben wird (bei einem Breakpoint) wird der Timer invalidiert und die Programmausführung stoppt.
	if (![self executeNextInstruction]) {
		PSAppDelegate *delegate = [timer userInfo];
		[delegate breakpointReached];
		[timer invalidate];
	}
	return;
}

	// File-Register updaten. Nicht schön, aber selten.
- (void)updateFileRegisters {
	[self.textField0C setStringValue:self.storage.reg0C.description];
	[self.textField0D setStringValue:self.storage.reg0D.description];
	[self.textField0E setStringValue:self.storage.reg0E.description];
	[self.textField0F setStringValue:self.storage.reg0F.description];

	[self.textField10 setStringValue:self.storage.reg10.description];
	[self.textField11 setStringValue:self.storage.reg11.description];
	[self.textField12 setStringValue:self.storage.reg12.description];
	[self.textField13 setStringValue:self.storage.reg13.description];
	[self.textField14 setStringValue:self.storage.reg14.description];
	[self.textField15 setStringValue:self.storage.reg15.description];
	[self.textField16 setStringValue:self.storage.reg16.description];
	[self.textField17 setStringValue:self.storage.reg17.description];
	[self.textField18 setStringValue:self.storage.reg18.description];
	[self.textField19 setStringValue:self.storage.reg19.description];
	[self.textField1A setStringValue:self.storage.reg1A.description];
	[self.textField1B setStringValue:self.storage.reg1B.description];
	[self.textField1C setStringValue:self.storage.reg1C.description];
	[self.textField1D setStringValue:self.storage.reg1D.description];
	[self.textField1E setStringValue:self.storage.reg1E.description];
	[self.textField1F setStringValue:self.storage.reg1F.description];

	[self.textField20 setStringValue:self.storage.reg20.description];
	[self.textField21 setStringValue:self.storage.reg21.description];
	[self.textField22 setStringValue:self.storage.reg22.description];
	[self.textField23 setStringValue:self.storage.reg23.description];
	[self.textField24 setStringValue:self.storage.reg24.description];
	[self.textField25 setStringValue:self.storage.reg25.description];
	[self.textField26 setStringValue:self.storage.reg26.description];
	[self.textField27 setStringValue:self.storage.reg27.description];
	[self.textField28 setStringValue:self.storage.reg28.description];
	[self.textField29 setStringValue:self.storage.reg29.description];
	[self.textField2A setStringValue:self.storage.reg2A.description];
	[self.textField2B setStringValue:self.storage.reg2B.description];
	[self.textField2C setStringValue:self.storage.reg2C.description];
	[self.textField2D setStringValue:self.storage.reg2D.description];
	[self.textField2E setStringValue:self.storage.reg2E.description];
	[self.textField2F setStringValue:self.storage.reg2F.description];

	[self.textField30 setStringValue:self.storage.reg30.description];
	[self.textField31 setStringValue:self.storage.reg31.description];
	[self.textField32 setStringValue:self.storage.reg32.description];
	[self.textField33 setStringValue:self.storage.reg33.description];
	[self.textField34 setStringValue:self.storage.reg34.description];
	[self.textField35 setStringValue:self.storage.reg35.description];
	[self.textField36 setStringValue:self.storage.reg36.description];
	[self.textField37 setStringValue:self.storage.reg37.description];
	[self.textField38 setStringValue:self.storage.reg38.description];
	[self.textField39 setStringValue:self.storage.reg39.description];
	[self.textField3A setStringValue:self.storage.reg3A.description];
	[self.textField3B setStringValue:self.storage.reg3B.description];
	[self.textField3C setStringValue:self.storage.reg3C.description];
	[self.textField3D setStringValue:self.storage.reg3D.description];
	[self.textField3E setStringValue:self.storage.reg3E.description];
	[self.textField3F setStringValue:self.storage.reg3F.description];

	[self.textField40 setStringValue:self.storage.reg40.description];
	[self.textField41 setStringValue:self.storage.reg41.description];
	[self.textField42 setStringValue:self.storage.reg42.description];
	[self.textField43 setStringValue:self.storage.reg43.description];
	[self.textField44 setStringValue:self.storage.reg44.description];
	[self.textField45 setStringValue:self.storage.reg45.description];
	[self.textField46 setStringValue:self.storage.reg46.description];
	[self.textField47 setStringValue:self.storage.reg47.description];
	[self.textField48 setStringValue:self.storage.reg48.description];
	[self.textField49 setStringValue:self.storage.reg49.description];
	[self.textField4A setStringValue:self.storage.reg4A.description];
	[self.textField4B setStringValue:self.storage.reg4B.description];
	[self.textField4C setStringValue:self.storage.reg4C.description];
	[self.textField4D setStringValue:self.storage.reg4D.description];
	[self.textField4E setStringValue:self.storage.reg4E.description];
	[self.textField4F setStringValue:self.storage.reg4F.description];
}

	// File-Register zurücksetzen bei Klick auf Reset-Button.
- (void)resetRegisters {
	self.storage.reg0C.registerValue = 0;
	self.storage.reg0D.registerValue = 0;
	self.storage.reg0E.registerValue = 0;
	self.storage.reg0F.registerValue = 0;

	self.storage.reg10.registerValue = 0;
	self.storage.reg11.registerValue = 0;
	self.storage.reg12.registerValue = 0;
	self.storage.reg13.registerValue = 0;
	self.storage.reg14.registerValue = 0;
	self.storage.reg15.registerValue = 0;
	self.storage.reg16.registerValue = 0;
	self.storage.reg17.registerValue = 0;
	self.storage.reg18.registerValue = 0;
	self.storage.reg19.registerValue = 0;
	self.storage.reg1A.registerValue = 0;
	self.storage.reg1B.registerValue = 0;
	self.storage.reg1C.registerValue = 0;
	self.storage.reg1D.registerValue = 0;
	self.storage.reg1E.registerValue = 0;
	self.storage.reg1F.registerValue = 0;

	self.storage.reg20.registerValue = 0;
	self.storage.reg21.registerValue = 0;
	self.storage.reg22.registerValue = 0;
	self.storage.reg23.registerValue = 0;
	self.storage.reg24.registerValue = 0;
	self.storage.reg25.registerValue = 0;
	self.storage.reg26.registerValue = 0;
	self.storage.reg27.registerValue = 0;
	self.storage.reg28.registerValue = 0;
	self.storage.reg29.registerValue = 0;
	self.storage.reg2A.registerValue = 0;
	self.storage.reg2B.registerValue = 0;
	self.storage.reg2C.registerValue = 0;
	self.storage.reg2D.registerValue = 0;
	self.storage.reg2E.registerValue = 0;
	self.storage.reg2F.registerValue = 0;

	self.storage.reg30.registerValue = 0;
	self.storage.reg31.registerValue = 0;
	self.storage.reg32.registerValue = 0;
	self.storage.reg33.registerValue = 0;
	self.storage.reg34.registerValue = 0;
	self.storage.reg35.registerValue = 0;
	self.storage.reg36.registerValue = 0;
	self.storage.reg37.registerValue = 0;
	self.storage.reg38.registerValue = 0;
	self.storage.reg39.registerValue = 0;
	self.storage.reg3A.registerValue = 0;
	self.storage.reg3B.registerValue = 0;
	self.storage.reg3C.registerValue = 0;
	self.storage.reg3D.registerValue = 0;
	self.storage.reg3E.registerValue = 0;
	self.storage.reg3F.registerValue = 0;

	self.storage.reg40.registerValue = 0;
	self.storage.reg41.registerValue = 0;
	self.storage.reg42.registerValue = 0;
	self.storage.reg43.registerValue = 0;
	self.storage.reg44.registerValue = 0;
	self.storage.reg45.registerValue = 0;
	self.storage.reg46.registerValue = 0;
	self.storage.reg47.registerValue = 0;
	self.storage.reg48.registerValue = 0;
	self.storage.reg49.registerValue = 0;
	self.storage.reg4A.registerValue = 0;
	self.storage.reg4B.registerValue = 0;
	self.storage.reg4C.registerValue = 0;
	self.storage.reg4D.registerValue = 0;
	self.storage.reg4E.registerValue = 0;
	self.storage.reg4F.registerValue = 0;

	self.storage.tmr0.registerValue   = 0b00000000;
	self.storage.pcl.registerValue    = 0b00000000;
	self.storage.status.registerValue = 0b00011000;
	self.storage.fsr.registerValue	  = 0b00000000;
	self.storage.porta.registerValue  = 0b00000000;
	self.storage.portb.registerValue  = 0b00000000;
	self.storage.eedata.registerValue = 0b00000000;
	self.storage.eeadr.registerValue  = 0b00000000;
	self.storage.pclath.registerValue = 0b00000000;
	self.storage.intcon.registerValue = 0b00000000;
	self.storage.option.registerValue = 0b11111111;
	self.storage.trisa.registerValue  = 0b00011111;
	self.storage.trisb.registerValue  = 0b11111111;
	self.storage.eecon1.registerValue = 0b00000000;
	self.storage.eecon2.registerValue = 0b00000000;
	[self updateFileRegisters];
}

	// Updaten der Laufzeitanzeigen-View
- (void)updateRuntimeCounterViews {
	[self.cycleCounter setIntegerValue:self.runtimeCounter];
	float seconds = self.runtimeCounter * cycleDuration;
	float milliseconds = seconds*1000;
	float microseconds = milliseconds*1000;
		// Ausgabe in Mikrosekunden
	NSString *timeString = [NSString stringWithFormat:@"%1.1f µs", microseconds];
	[self.timeCounter setStringValue:timeString];
}


	// Für Berechnungen, Direktzugriff auf Variable, Variable gibt Sekunden zwischen zwei Befehlen an
- (void)setCycleDuration:(float)newCycleDuration {
	cycleDuration = newCycleDuration;
}

- (float)cycleDuration {
	return cycleDuration;
}

	// Zur Anzeige, Umrechnen der Zeit zwischen zwei Befehlen in Megahertz
- (void)setCycleDurationSlider:(float)newValue {
	cycleDuration = ((101-newValue)/10000000);
}

- (float)cycleDurationSlider {
	return 101-(cycleDuration*10000000);
}

@end
