//
//  PSInstruction.m
//  PIC-Simu
//
//  Created by Dennis Stengele on 28/04/14.
//  Copyright (c) 2014 Dennis Stengele. All rights reserved.
//

#import "PSInstruction.h"

@implementation PSInstruction

@synthesize instruction;
@synthesize bitAddress;
@synthesize literal;
@synthesize registerAddress;
@synthesize storeInF;

- (PSInstruction *)initWithBits:(int16_t)instructionBinary {
	self = [super init];
	if (self) {
		if (instructionBinary == 0b0000000001100100) { //CLRWDT
			self.instruction = @"CLRWDT";
			
			return self;
		}
		if (instructionBinary == 0b0000000000001001) {
			self.instruction = @"RETFIE";
			
			return self;
		}
		if (instructionBinary == 0b0000000000001000) {
			self.instruction = @"RETURN";
			
			return self;
		}
		if (instructionBinary == 0b0000000001100011) {
			self.instruction = @"SLEEP";
			
			return self;
		}
		
			// Nur Don't-Care-Bits
		if ((instructionBinary & 0b1111111110011111) == 0b0000000000000000) {
			self.instruction = @"NOP";
			
			return self;
		}
		if ((instructionBinary & 0b1111111110000000) == 0b0000000100000000) {
			self.instruction = @"CLRW";
			
			return self;
		}
		
			// 7 Bits definiert
		if ((instructionBinary & 0b1111111110000000) == 0b0000000010000000) {
			self.instruction = @"MOVWF";
			
			self.registerAddress = instructionBinary == 0b0000000001111111;
			
			return self;
		}
		if ((instructionBinary & 0b1111111110000000) == 0b0000000110000000) {
			self.instruction = @"CLRF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			return self;
		}
		
			// 6 Bits definiert
		if ((instructionBinary & 0b1111111100000000) == 0b0000011100000000) {
			self.instruction = @"ADDWF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000001000000;
			
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000010100000000) {
			self.instruction = @"ANDWF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000001000000;
			
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000100100000000) {
			self.instruction = @"COMF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000001000000;
			
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000001100000000) {
			self.instruction = @"DECF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000001000000;
			
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000101100000000) {
			self.instruction = @"ANDWF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000001000000;
			
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000101000000000) {
			self.instruction = @"ANDWF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000001000000;
			
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000111100000000) {
			self.instruction = @"INCFSZ";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000001000000;
			
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000010000000000) {
			self.instruction = @"IORWF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000001000000;
			
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000100000000000) {
			self.instruction = @"MOVF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000001000000;
			
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000110100000000) {
			self.instruction = @"RLF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000001000000;
			
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000110000000000) {
			self.instruction = @"RRF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000001000000;
			
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000001000000000) {
			self.instruction = @"SUBWF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000001000000;
			
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000111000000000) {
			self.instruction = @"SWAPF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000001000000;
			
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000011000000000) {
			self.instruction = @"XORWF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000001000000;
			
			return self;
		}
		if ((instructionBinary & 0b1111111000000000) == 0b0011111100000000) {
			self.instruction = @"ADDLW";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000001000000;
			
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0011100100000000) {
			self.instruction = @"ANDLW";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000001000000;
			
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0011100000000000) {
			self.instruction = @"IORLW";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000001000000;
			
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0011101000000000) {
			self.instruction = @"XORLW";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000001000000;
			
			return self;
		}
		if ((instructionBinary & 0b1111111000000000) == 0b0011110000000000) {
			self.instruction = @"SUBLW";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000001000000;
			
			return self;
		}
		
			// 4 Bits definiert
		if ((instructionBinary & 0b1111110000000000) == 0b0000010000000000) {
			self.instruction = @"BCF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.bitAddress = instructionBinary & 0b0000001110000000;
			
			return self;
		}
		if ((instructionBinary & 0b1111110000000000) == 0b0000010100000000) {
			self.instruction = @"BSF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.bitAddress = instructionBinary & 0b0000001110000000;
			
			return self;
		}
		if ((instructionBinary & 0b1111110000000000) == 0b0000011000000000) {
			self.instruction = @"BTFSC";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.bitAddress = instructionBinary & 0b0000001110000000;
			
			return self;
		}
		if ((instructionBinary & 0b1111110000000000) == 0b0000011100000000) {
			self.instruction = @"BTFSS";
			
			self.registerAddress = instructionBinary & 0b0000000011111111;
			
			self.bitAddress = instructionBinary & 0b0000001110000000;
			
			return self;
		}
		if ((instructionBinary & 0b1111110000000000) == 0b0000110000000000) {
			self.instruction = @"MOVLW";
			
			self.literal = instructionBinary & 0b0000000011111111;
			
			return self;
		}
		if ((instructionBinary & 0b1111110000000000) == 0b0000110100000000) {
			self.instruction = @"RETLW";
			
			self.literal = instructionBinary & 0b0000000011111111;
			
			return self;
		}
		
			// 3 Bits definiert
		if ((instructionBinary & 0b1111100000000000) & 0b0000100000000000) {
			self.instruction = @"CALL";
			
			self.literal = instructionBinary & 0b0000011111111111;
			
			return self;
		}
		if ((instructionBinary & 0b1111100000000000) & 0b0000101000000000) {
			self.instruction = @"GOTO";
			
			self.literal = instructionBinary & 0b0000011111111111;
			
			return self;
		}
	}
	return nil;
}

@end
