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

@implementation PSVirtualPIC

@synthesize fileContents;
@synthesize storage;
@synthesize locArrayController;
@synthesize wdt;
@synthesize callStack;
@synthesize codeView;

- (id)init {
	self = [super init];
	if (self) {
		fileContents = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)initWithTextFile:(NSURL *)sourceFile {
		// Datei laden und -inhalt in NSString konvertieren (Datei muss UTF-8-kodiert sein)
	NSStringEncoding usedEnc;
	NSString* fileString = [NSString stringWithContentsOfURL:sourceFile
												usedEncoding:&usedEnc
													   error:nil];
	NSLog(@"Opened File %@ using Encoding:%lu", sourceFile, usedEnc);

	NSLog(@"%@", fileString);

	NSString* delimiter = @"\n";

		// Dateiinhalt als Array in Instanzvariable speichern

	NSArray *fileArray = [fileString componentsSeparatedByString:delimiter];
	
	[[self.locArrayController content] removeAllObjects];

	for (NSString *loc in fileArray) {
		PSLineOfCode *new_loc = [[PSLineOfCode alloc] init];
		new_loc.loc = loc;
		@try {
			new_loc.instruction = [loc substringWithRange:NSMakeRange(5, 4)];
			new_loc.programCounter = [loc substringWithRange:NSMakeRange(0, 4)];
		}
		@catch (NSException *exception) {
			NSLog(@"Fehler beim Lesen der Zeile %@: %@", loc, exception);
		}
		[self.locArrayController addObject:new_loc];
	}
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
	NSUInteger nextInstructionRow = NSNotFound;
	nextInstructionRow = [self.fileContents indexOfObjectPassingTest:
							  ^BOOL(id obj, NSUInteger idx, BOOL *stop){
								  PSLineOfCode *l = obj;
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
	if (nextInstructionRow == NSNotFound) {
		[NSException raise:@"Illegal Value in PCL or PCLATH Register!" format:@"FormatError"];
	}
	
	NSIndexSet *rows;
	NSLog(@"Instruction found: %ld", nextInstructionRow);
	
	PSLineOfCode *loc = [self.fileContents objectAtIndex:nextInstructionRow];
	if (loc.hasBreakpoint) {
		return false;
	}
	NSString *instructionString = [[self.fileContents objectAtIndex:nextInstructionRow] instruction];

	NSScanner *scanner = [NSScanner scannerWithString:instructionString];
	uint instructionBinary;
	[scanner scanHexInt:&instructionBinary];
	PSInstruction *instruction = [[PSInstruction alloc] initWithBits:(uint16_t)instructionBinary];

	[instruction executeWithVirtualPIC:self];
	
		// Nächste Zeile highlighten
	rows = [NSIndexSet indexSetWithIndex:nextInstructionRow];
	[self.codeView selectRowIndexes:rows byExtendingSelection:FALSE];
	
	[self.storage incrementPc];
	[self updateFileRegisters];
	return true;
}

- (void)timerFireMethod:(NSTimer *)timer {
	if (![self executeNextInstruction]) {
		[timer invalidate];
	}
	return;
}

- (void)updateFileRegisters {
	[self.textField0C setIntegerValue:self.storage.reg0C.registerValue];
	[self.textField0D setIntegerValue:self.storage.reg0D.registerValue];
	[self.textField0E setIntegerValue:self.storage.reg0E.registerValue];
	[self.textField0F setIntegerValue:self.storage.reg0F.registerValue];
	
	[self.textField10 setIntegerValue:self.storage.reg10.registerValue];
	[self.textField11 setIntegerValue:self.storage.reg11.registerValue];
	[self.textField12 setIntegerValue:self.storage.reg12.registerValue];
	[self.textField13 setIntegerValue:self.storage.reg13.registerValue];
	[self.textField14 setIntegerValue:self.storage.reg14.registerValue];
	[self.textField15 setIntegerValue:self.storage.reg15.registerValue];
	[self.textField16 setIntegerValue:self.storage.reg16.registerValue];
	[self.textField17 setIntegerValue:self.storage.reg17.registerValue];
	[self.textField18 setIntegerValue:self.storage.reg18.registerValue];
	[self.textField19 setIntegerValue:self.storage.reg19.registerValue];
	[self.textField1A setIntegerValue:self.storage.reg1A.registerValue];
	[self.textField1B setIntegerValue:self.storage.reg1B.registerValue];
	[self.textField1C setIntegerValue:self.storage.reg1C.registerValue];
	[self.textField1D setIntegerValue:self.storage.reg1D.registerValue];
	[self.textField1E setIntegerValue:self.storage.reg1E.registerValue];
	[self.textField1F setIntegerValue:self.storage.reg1F.registerValue];
	
	[self.textField20 setIntegerValue:self.storage.reg20.registerValue];
	[self.textField21 setIntegerValue:self.storage.reg21.registerValue];
	[self.textField22 setIntegerValue:self.storage.reg22.registerValue];
	[self.textField23 setIntegerValue:self.storage.reg23.registerValue];
	[self.textField24 setIntegerValue:self.storage.reg24.registerValue];
	[self.textField25 setIntegerValue:self.storage.reg25.registerValue];
	[self.textField26 setIntegerValue:self.storage.reg26.registerValue];
	[self.textField27 setIntegerValue:self.storage.reg27.registerValue];
	[self.textField28 setIntegerValue:self.storage.reg28.registerValue];
	[self.textField29 setIntegerValue:self.storage.reg29.registerValue];
	[self.textField2A setIntegerValue:self.storage.reg2A.registerValue];
	[self.textField2B setIntegerValue:self.storage.reg2B.registerValue];
	[self.textField2C setIntegerValue:self.storage.reg2C.registerValue];
	[self.textField2D setIntegerValue:self.storage.reg2D.registerValue];
	[self.textField2E setIntegerValue:self.storage.reg2E.registerValue];
	[self.textField2F setIntegerValue:self.storage.reg2F.registerValue];
	
	[self.textField30 setIntegerValue:self.storage.reg30.registerValue];
	[self.textField31 setIntegerValue:self.storage.reg31.registerValue];
	[self.textField32 setIntegerValue:self.storage.reg32.registerValue];
	[self.textField33 setIntegerValue:self.storage.reg33.registerValue];
	[self.textField34 setIntegerValue:self.storage.reg34.registerValue];
	[self.textField35 setIntegerValue:self.storage.reg35.registerValue];
	[self.textField36 setIntegerValue:self.storage.reg36.registerValue];
	[self.textField37 setIntegerValue:self.storage.reg37.registerValue];
	[self.textField38 setIntegerValue:self.storage.reg38.registerValue];
	[self.textField39 setIntegerValue:self.storage.reg39.registerValue];
	[self.textField3A setIntegerValue:self.storage.reg3A.registerValue];
	[self.textField3B setIntegerValue:self.storage.reg3B.registerValue];
	[self.textField3C setIntegerValue:self.storage.reg3C.registerValue];
	[self.textField3D setIntegerValue:self.storage.reg3D.registerValue];
	[self.textField3E setIntegerValue:self.storage.reg3E.registerValue];
	[self.textField3F setIntegerValue:self.storage.reg3F.registerValue];

	[self.textField40 setIntegerValue:self.storage.reg40.registerValue];
	[self.textField41 setIntegerValue:self.storage.reg41.registerValue];
	[self.textField42 setIntegerValue:self.storage.reg42.registerValue];
	[self.textField43 setIntegerValue:self.storage.reg43.registerValue];
	[self.textField44 setIntegerValue:self.storage.reg44.registerValue];
	[self.textField45 setIntegerValue:self.storage.reg45.registerValue];
	[self.textField46 setIntegerValue:self.storage.reg46.registerValue];
	[self.textField47 setIntegerValue:self.storage.reg47.registerValue];
	[self.textField48 setIntegerValue:self.storage.reg48.registerValue];
	[self.textField49 setIntegerValue:self.storage.reg49.registerValue];
	[self.textField4A setIntegerValue:self.storage.reg4A.registerValue];
	[self.textField4B setIntegerValue:self.storage.reg4B.registerValue];
	[self.textField4C setIntegerValue:self.storage.reg4C.registerValue];
	[self.textField4D setIntegerValue:self.storage.reg4D.registerValue];
	[self.textField4E setIntegerValue:self.storage.reg4E.registerValue];
	[self.textField4F setIntegerValue:self.storage.reg4F.registerValue];
}

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

@end
