//
//  PSSourceFile.m
//  PIC-Simu
//
//  Created by Dennis Stengele on 31/03/14.
//  Copyright (c) 2014 Dennis Stengele. All rights reserved.
//

#import "PSVirtualPIC.h"
#import "PSLineOfCode.h"

@implementation PSVirtualPIC

@synthesize fileContents;

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

	for (NSString *loc in fileArray) {
		PSLineOfCode *new_loc = [[PSLineOfCode alloc] init];
		new_loc.loc = loc;
		new_loc.instruction = [loc substringWithRange:NSMakeRange(5, 4)];
		new_loc.programCounter = [loc substringWithRange:NSMakeRange(0, 4)];
		[_locArrayController addObject:new_loc];
	}
}

- (NSIndexSet *)tableView:(NSTableView *)tableView selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes {
	return NO;
}

- (void)executeNextIntruction {
	NSUInteger nextInstructionRow = [fileContents indexOfObjectPassingTest:
									 ^BOOL(id obj, NSUInteger idx, BOOL *stop){
										 PSLineOfCode *l = obj;
										 NSString *pcString = [NSString stringWithFormat:@"%ld", (long)self.pc];
										 if ([l.programCounter isEqualTo:pcString]) {
											 return TRUE;
										 }
										 return FALSE;
									 }
									];
	NSString *instruction = [[fileContents objectAtIndex:nextInstructionRow] instruction];

	int16_t instructionBinary = [instruction intValue];
		// TODO: Unterscheiden der Opcodes einbauen
	NSString *instructionString = [self decodeBinaryInstruction:instructionBinary];



		// Unterscheidung der einzelnen Befehle

}

- (NSString *)decodeBinaryInstruction:(int16_t)instructionBinary {
		//Neues Instruction-Objekt könnte Befehle ausführen

		// 14 Bits definiert
	if (instructionBinary & 0b0000000001100100) {
		return @"CLRWDT";
	}
	if (instructionBinary & 0b0000000000001001) {
		return @"RETFIE	";
	}
	if (instructionBinary & 0b0000000000001000) {
		return @"RETURN";
	}
	if (instructionBinary & 0b0000000001100011) {
		return @"SLEEP";
	}

		// Nur Don't-Care-Bits
	if ((instructionBinary & 0b1111111110011111) & 0b0000000000000000) {
		return @"NOP";
	}
	if ((instructionBinary & 0b1111111110000000) & 0b0000000110000000) {
		return @"CLRW";
	}

		// 7 Bits definiert
	if ((instructionBinary & 0b1111111110000000) & 0b0000000010000000) {
		return @"MOVWF";
	}
	if ((instructionBinary & 0b1111111110000000) & 0b0000000110000000) {
		return @"CLRF";
	}

		// 6 Bits definiert
	if ((instructionBinary & 0b1111111100000000) & 0b0000011100000000) {
		return @"ADDWF";
	}
	if ((instructionBinary & 0b1111111100000000) & 0b0000010100000000) {
		return @"ANDWF";
	}
	if ((instructionBinary & 0b1111111100000000) & 0b0000100100000000) {
		return @"COMF";
	}
	if ((instructionBinary & 0b1111111100000000) & 0b0000001100000000) {
		return @"DECF";
	}
	if ((instructionBinary & 0b1111111100000000) & 0b0000101100000000) {
		return @"DECFSZ";
	}
	if ((instructionBinary & 0b1111111100000000) & 0b0000101000000000) {
		return @"INCF";
	}
	if ((instructionBinary & 0b1111111100000000) & 0b0000111100000000) {
		return @"INCFSZ";
	}
	if ((instructionBinary & 0b1111111100000000) & 0b0000010000000000) {
		return @"IORWF";
	}
	if ((instructionBinary & 0b1111111100000000) & 0b0000100000000000) {
		return @"MOVF";
	}
	if ((instructionBinary & 0b1111111100000000) & 0b0000110100000000) {
		return @"RLF";
	}
	if ((instructionBinary & 0b1111111100000000) & 0b0000110000000000) {
		return @"RRF";
	}
	if ((instructionBinary & 0b1111111100000000) & 0b0000001000000000) {
		return @"SUBWF";
	}
	if ((instructionBinary & 0b1111111100000000) & 0b0000111000000000) {
		return @"SWAPF";
	}
	if ((instructionBinary & 0b1111111100000000) & 0b0000011000000000) {
		return @"XORWF";
	}
	if ((instructionBinary & 0b1111111000000000) & 0b0011111100000000) {
		return @"ADDLW";
	}
	if ((instructionBinary & 0b1111111100000000) & 0b0011100100000000) {
		return @"ANDLW";
	}
	if ((instructionBinary & 0b1111111100000000) & 0b0011100000000000) {
		return @"IORLW";
	}
	if ((instructionBinary & 0b1111111100000000) & 0b0011101000000000) {
		return @"XORLW";
	}
	if ((instructionBinary & 0b1111111000000000) & 0b0011110000000000) {
		return @"SUBLW";
	}

		// 4 Bits definiert
	if ((instructionBinary & 0b1111110000000000) & 0b0000010000000000) {
		return @"BCF";
	}
	if ((instructionBinary & 0b1111110000000000) & 0b0000010100000000) {
		return @"BSF";
	}
	if ((instructionBinary & 0b1111110000000000) & 0b0000011000000000) {
		return @"BTFSC";
	}
	if ((instructionBinary & 0b1111110000000000) & 0b0000011100000000) {
		return @"BTFSS";
	}
	if ((instructionBinary & 0b1111110000000000) & 0b0000110000000000) {
		return @"MOVLW";
	}
	if ((instructionBinary & 0b1111110000000000) & 0b0000110100000000) {
		return @"RETLW";
	}

		// 3 Bits definiert
	if ((instructionBinary & 0b1111100000000000) & 0b0000100000000000) {
		return @"CALL";
	}
	if ((instructionBinary & 0b1111100000000000) & 0b0000101000000000) {
		return @"GOTO";
	}
	return [NSString stringWithFormat:@"No known instruction for %d.", instructionBinary];
}

@end
