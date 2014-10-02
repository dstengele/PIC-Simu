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

typedef enum operation {
    addition,
    subtraction
} operation;

	// Auslesen des Bitfeldes der Instruktion und setzen der benötigten Felder
	// (Name des Befehls, Registeraddresse, Bit im Register, ob in F gespeichert werden soll, Literal)
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
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
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
			
			self.storeInF = instructionBinary & 0b0000000010000000;
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000010100000000) {
			self.instruction = @"ANDWF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000010000000;
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000100100000000) {
			self.instruction = @"COMF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000010000000;
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000001100000000) {
			self.instruction = @"DECF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000010000000;
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000101100000000) {
			self.instruction = @"DECFSZ";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000010000000;
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000101000000000) {
			self.instruction = @"INCF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000010000000;
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000111100000000) {
			self.instruction = @"INCFSZ";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000010000000;
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000010000000000) {
			self.instruction = @"IORWF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000010000000;
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000100000000000) {
			self.instruction = @"MOVF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000010000000;
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000110100000000) {
			self.instruction = @"RLF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000010000000;
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000110000000000) {
			self.instruction = @"RRF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000010000000;
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000001000000000) {
			self.instruction = @"SUBWF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000010000000;
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000111000000000) {
			self.instruction = @"SWAPF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000010000000;
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0000011000000000) {
			self.instruction = @"XORWF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000010000000;
			return self;
		}
		if ((instructionBinary & 0b1111111000000000) == 0b0011111000000000) {
			self.instruction = @"ADDLW";
			
			self.literal = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000010000000;
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0011100100000000) {
			self.instruction = @"ANDLW";
			
			self.literal = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000010000000;
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0011100000000000) {
			self.instruction = @"IORLW";
			
			self.literal = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000010000000;
			return self;
		}
		if ((instructionBinary & 0b1111111100000000) == 0b0011101000000000) {
			self.instruction = @"XORLW";
			
			self.literal = instructionBinary & 0b0000000011111111;
			
			self.storeInF = instructionBinary & 0b0000000010000000;
			return self;
		}
		if ((instructionBinary & 0b1111111000000000) == 0b0011110000000000) {
			self.instruction = @"SUBLW";
			
			self.literal = instructionBinary & 0b0000000001111111;
			
			self.storeInF = instructionBinary & 0b0000000010000000;
			return self;
		}
		
			// 4 Bits definiert
		if ((instructionBinary & 0b1111110000000000) == 0b0001000000000000) {
			self.instruction = @"BCF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.bitAddress = (instructionBinary & 0b0000001110000000) >> 7;
			return self;
		}
		if ((instructionBinary & 0b1111110000000000) == 0b0001010000000000) {
			self.instruction = @"BSF";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.bitAddress = (instructionBinary & 0b0000001110000000) >> 7;
			return self;
		}
		if ((instructionBinary & 0b1111110000000000) == 0b0001100000000000) {
			self.instruction = @"BTFSC";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.bitAddress = (instructionBinary & 0b0000001110000000) >> 7;
			return self;
		}
		if ((instructionBinary & 0b1111110000000000) == 0b0001110000000000) {
			self.instruction = @"BTFSS";
			
			self.registerAddress = instructionBinary & 0b0000000001111111;
			
			self.bitAddress = (instructionBinary & 0b0000001110000000) >> 7;
			return self;
		}
		if ((instructionBinary & 0b1111110000000000) == 0b0011000000000000) {
			self.instruction = @"MOVLW";
			
			self.literal = instructionBinary & 0b0000000011111111;
			return self;
		}
		if ((instructionBinary & 0b1111110000000000) == 0b0011010000000000) {
			self.instruction = @"RETLW";
			
			self.literal = instructionBinary & 0b0000000011111111;
			return self;
		}
		
			// 3 Bits definiert
		if ((instructionBinary & 0b1111100000000000) == 0b0010000000000000) {
			self.instruction = @"CALL";
			
			self.literal = instructionBinary & 0b0000011111111111;
			return self;
		}
		if ((instructionBinary & 0b1111100000000000) == 0b0010100000000000) {
			self.instruction = @"GOTO";
			
			self.literal = instructionBinary & 0b0000011111111111;
			return self;
		}
	}
	return nil;
}

- (void)executeCLRWDT:(PSVirtualPIC *)pic {
	pic.wdt = 0b00000000;
}

- (void)executeRETFIE:(PSVirtualPIC *)pic {
	pic.storage.pc = [pic.callStack pop];
}

- (void)executeRRF:(PSVirtualPIC *)pic {
	PSRegister *fileRegister = [pic.storage registerforAddress:self.registerAddress];
	PSRegister *wRegister = pic.storage.w;
	PSRegister *statusRegister = pic.storage.status;
	// Einlesen
	BOOL bit0 = fileRegister.bit0;
	BOOL bit1 = fileRegister.bit1;
	BOOL bit2 = fileRegister.bit2;
	BOOL bit3 = fileRegister.bit3;
	BOOL bit4 = fileRegister.bit4;
	BOOL bit5 = fileRegister.bit5;
	BOOL bit6 = fileRegister.bit6;
	BOOL bit7 = fileRegister.bit7;
	BOOL carry = statusRegister.bit0;
	
	if (self.storeInF) {
		fileRegister.bit0 = bit1;
		fileRegister.bit1 = bit2;
		fileRegister.bit2 = bit3;
		fileRegister.bit3 = bit4;
		fileRegister.bit4 = bit5;
		fileRegister.bit5 = bit6;
		fileRegister.bit6 = bit7;
		fileRegister.bit7 = carry;
		statusRegister.bit0 = bit0;
		
	} else {
		wRegister.bit0 = bit1;
		wRegister.bit1 = bit2;
		wRegister.bit2 = bit3;
		wRegister.bit3 = bit4;
		wRegister.bit4 = bit5;
		wRegister.bit5 = bit6;
		wRegister.bit6 = bit7;
		wRegister.bit7 = carry;
		statusRegister.bit0 = bit0;
	}
}

- (BOOL)checkCarryForValue:(uint8_t)firstValue andValue:(uint8_t) secondValue withOperation:(enum operation)op{
	switch (op) {
		case addition: {
			uint16_t temp = firstValue + secondValue;
			if (temp > 255) {
				return true;
			}
			break;
		}
		case subtraction: {
			if (firstValue < secondValue) {
				return true;
			}
			break;
		}
	}
	return false;
}

- (BOOL)checkDigitCarryForValue:(uint8_t)firstValue andValue:(uint8_t) secondValue withOperation:(enum operation)op{
	uint8_t firstNibble = firstValue & 0x01;
	uint8_t secondNibble = secondValue & 0x01;
	switch (op) {
		case addition: {
			uint8_t temp = firstNibble + secondNibble;
			if (temp > 15) {
				return true;
			}
			break;
		}
		case subtraction: {
			if (firstNibble < secondNibble) {
				return true;
			}
			break;
		}
	}
	return false;
}

- (void)executeSUBWF:(PSVirtualPIC *)pic {
	PSRegister *fileRegister = [pic.storage registerforAddress:self.registerAddress];
	PSRegister *statusRegister = pic.storage.status;
	PSRegister *wRegister = pic.storage.w;
    uint8_t firstValue = wRegister.registerValue;
    uint8_t secondValue = fileRegister.registerValue;

    uint8_t wRegisterValueTwosComp = (~(wRegister.registerValue) + 1);

    uint8_t result = fileRegister.registerValue + wRegisterValueTwosComp;
    
    BOOL carry = [self checkCarryForValue:firstValue andValue:secondValue withOperation:subtraction];
    BOOL digitCarry = [self checkDigitCarryForValue:firstValue andValue:secondValue withOperation:subtraction];
	
	if (self.storeInF) {
		[fileRegister setRegisterValue:result];
		//move to f
	} else {
        [wRegister setRegisterValue:result];
		//move to W
	}
	[statusRegister setBit1:digitCarry];
	[statusRegister setBit0:carry];
}

- (void)executeSWAPF:(PSVirtualPIC *)pic {
	PSRegister *fileRegister = [pic.storage registerforAddress:self.registerAddress];
	PSRegister *wRegister = pic.storage.w;
	// Einlesen
	BOOL bit0 = fileRegister.bit0;
	BOOL bit1 = fileRegister.bit1;
	BOOL bit2 = fileRegister.bit2;
	BOOL bit3 = fileRegister.bit3;
	BOOL bit4 = fileRegister.bit4;
	BOOL bit5 = fileRegister.bit5;
	BOOL bit6 = fileRegister.bit6;
	BOOL bit7 = fileRegister.bit7;
	
	if (self.storeInF) {
		fileRegister.bit0 = bit4;
		fileRegister.bit1 = bit5;
		fileRegister.bit2 = bit6;
		fileRegister.bit3 = bit7;
		fileRegister.bit4 = bit0;
		fileRegister.bit5 = bit1;
		fileRegister.bit6 = bit2;
		fileRegister.bit7 = bit3;
	} else {
		wRegister.bit0 = bit4;
		wRegister.bit1 = bit5;
		wRegister.bit2 = bit6;
		wRegister.bit3 = bit7;
		wRegister.bit4 = bit0;
		wRegister.bit5 = bit1;
		wRegister.bit6 = bit2;
		wRegister.bit7 = bit3;
	}
}

- (void)executeMOVF:(PSVirtualPIC *)pic {
	PSRegister *fileRegister = [pic.storage registerforAddress:self.registerAddress];
	
	if (self.storeInF) {
		[fileRegister setRegisterValue:fileRegister.registerValue];
		if (fileRegister.registerValue == 0) {
			pic.storage.status.bit2 = 1;
		} else {
			pic.storage.status.bit2 = 0;
		}
		//move to f
	} else {
		pic.storage.w.registerValue = fileRegister.registerValue;
		if (pic.storage.w.registerValue == 0) {
			pic.storage.status.bit2 = 1;
		} else {
			pic.storage.status.bit2 = 0;
		}
		//move to W
	}
}

- (void)executeRLF:(PSVirtualPIC *)pic {
	PSRegister *fileRegister = [pic.storage registerforAddress:self.registerAddress];
	PSRegister *wRegister = pic.storage.w;
	PSRegister *statusRegister = pic.storage.status;
	// Einlesen
	BOOL bit0 = fileRegister.bit0;
	BOOL bit1 = fileRegister.bit1;
	BOOL bit2 = fileRegister.bit2;
	BOOL bit3 = fileRegister.bit3;
	BOOL bit4 = fileRegister.bit4;
	BOOL bit5 = fileRegister.bit5;
	BOOL bit6 = fileRegister.bit6;
	BOOL bit7 = fileRegister.bit7;
	BOOL carry = statusRegister.bit0;
	
	if (self.storeInF) {
		fileRegister.bit0 = carry;
		fileRegister.bit1 = bit0;
		fileRegister.bit2 = bit1;
		fileRegister.bit3 = bit2;
		fileRegister.bit4 = bit3;
		fileRegister.bit5 = bit4;
		fileRegister.bit6 = bit5;
		fileRegister.bit7 = bit6;
		statusRegister.bit0 = bit7;
		
	} else {
		wRegister.bit0 = carry;
		wRegister.bit1 = bit0;
		wRegister.bit2 = bit1;
		wRegister.bit3 = bit2;
		wRegister.bit4 = bit3;
		wRegister.bit5 = bit4;
		wRegister.bit6 = bit5;
		wRegister.bit7 = bit6;
		statusRegister.bit0 = bit7;
	}
}

- (void)executeIORWF:(PSVirtualPIC *)pic {
	PSRegister *fileRegister = [pic.storage registerforAddress:self.registerAddress];
	PSRegister *wRegister = pic.storage.w;
	
	if (self.storeInF) {
		PSRegister *reg = [pic.storage registerforAddress:self.registerAddress];
		[reg setRegisterValue:(wRegister.registerValue | fileRegister.registerValue)];
		if (reg.registerValue == 0) {
			pic.storage.status.bit2 = 1;
		} else {
			pic.storage.status.bit2 = 0;
		}
		//result in f
	} else {
		pic.storage.w.registerValue = (wRegister.registerValue | fileRegister.registerValue);
		if (wRegister.registerValue == 0) {
			pic.storage.status.bit2 = 1;
		} else {
			pic.storage.status.bit2 = 0;
		}
		//result in W
	}
}

- (void)executeINCF:(PSVirtualPIC *)pic {
	PSRegister *fileRegister = [pic.storage registerforAddress:self.registerAddress];
	PSRegister *wRegister = pic.storage.w;
	PSRegister *statusRegister = pic.storage.status;
	
	uint8_t temp = fileRegister.registerValue;
	temp++;
	
	if (temp == 0) {
		statusRegister.bit2 = true;
	} else {
		statusRegister.bit2 = false;
	}
	
	if (self.storeInF) {
		fileRegister.registerValue = temp;
	} else {
		wRegister.registerValue = temp;
	}
}

- (void)executeINCFSZ:(PSVirtualPIC *)pic {
	PSRegister *fileRegister = [pic.storage registerforAddress:self.registerAddress];
	PSRegister *wRegister = pic.storage.w;
	
	uint8_t temp = fileRegister.registerValue;
	temp++;
	
	if (temp == 0) {
		pic.storage.pc++;
	}
	
	if (self.storeInF) {
		fileRegister.registerValue = temp;
	} else {
		wRegister.registerValue = temp;
	}
}

- (void)executeDECFSZ:(PSVirtualPIC *)pic {
	PSRegister *fileRegister = [pic.storage registerforAddress:self.registerAddress];
	PSRegister *wRegister = pic.storage.w;
	
	uint8_t temp = fileRegister.registerValue;
	temp--;
	
	if (temp == 0) {
		pic.storage.pc++;
	}
	
	if (self.storeInF) {
		fileRegister.registerValue = temp;
	} else {
		wRegister.registerValue = temp;
	}
}

- (void)executeDECF:(PSVirtualPIC *)pic {
	PSRegister *fileRegister = [pic.storage registerforAddress:self.registerAddress];
	PSRegister *wRegister = pic.storage.w;
	PSRegister *statusRegister = pic.storage.status;
	
	uint8_t temp = fileRegister.registerValue;
	temp--;
	
	if (temp == 0) { // Prüfung, ob Zero-Bit gesetzt werden muss
		statusRegister.bit2 = true;
	} else {
		statusRegister.bit2 = false;
	}
	
	if (self.storeInF) {
		fileRegister.registerValue = temp;
	} else {
		wRegister.registerValue = temp;
	}
}

- (void)executeCOMF:(PSVirtualPIC *)pic {
	uint8_t registerValue = [[pic.storage registerforAddress:self.registerAddress] registerValue];
	
	if (self.storeInF) {
		PSRegister *reg = [pic.storage registerforAddress:self.registerAddress];
		[reg setRegisterValue:~registerValue]; // Der Tilde-Operator bildet Komplement
		if (reg.registerValue == 0) {
			pic.storage.status.bit2 = 1;
		} else {
			pic.storage.status.bit2 = 0;
		}
		//move to f
	}
	else {
		pic.storage.w.registerValue = ~registerValue;
		if (pic.storage.w.registerValue == 0) {
			pic.storage.status.bit2 = 1;
		} else {
			pic.storage.status.bit2 = 0;
		}
		//move to W
	}
}

- (void)executeXORWF:(PSVirtualPIC *)pic {
	PSRegister *fileRegister = [pic.storage registerforAddress:self.registerAddress];
	PSRegister *wRegister = pic.storage.w;
	
	if(self.storeInF)
	{
		[fileRegister setRegisterValue:(fileRegister.registerValue ^ wRegister.registerValue)];
		if (fileRegister.registerValue == 0) {
			pic.storage.status.bit2 = 1;
		} else {
			pic.storage.status.bit2 = 0;
		}
		//move to f
	}
	else
	{
		pic.storage.w.registerValue = ((wRegister.registerValue ^ fileRegister.registerValue));
		if (wRegister.registerValue == 0) {
			pic.storage.status.bit2 = 1;
		} else {
			pic.storage.status.bit2 = 0;
		}
		//move to W
	}
}

- (void)executeADDWF:(PSVirtualPIC *)pic {
	uint8_t valueW = pic.storage.w.registerValue;
	PSRegister *fileRegister = [pic.storage registerforAddress:self.registerAddress];
	uint8_t valueF = [fileRegister registerValue];
	uint8_t sum = valueW + valueF;
	
	if (self.storeInF) {
		[fileRegister setRegisterValue:sum];
		//Sum to f
	}
	else {
		[pic.storage.w setRegisterValue:sum];
		//Sum to W
	}
}

- (void)executeANDWF:(PSVirtualPIC *)pic {
	uint8_t valueW = pic.storage.w.registerValue;
	PSRegister *fileRegister = [pic.storage registerforAddress:self.registerAddress];
	uint8_t valueF = [fileRegister registerValue];
	uint8_t and = valueW & valueF;
	
	if (self.storeInF) {
		[fileRegister setRegisterValue:and];
		if (fileRegister.registerValue == 0) {
			pic.storage.status.bit2 = 1;
		} else {
			pic.storage.status.bit2 = 0;
		}
		//AND to f
	}
	else {
		[pic.storage.w setRegisterValue:and];
		if (pic.storage.w.registerValue == 0) {
			pic.storage.status.bit2 = 1;
		} else {
			pic.storage.status.bit2 = 0;
		}
		//AND to W
	}
}

- (void)executeMOVWF:(PSVirtualPIC *)pic {
	PSRegister *reg = [pic.storage registerforAddress:self.registerAddress];
	[reg setRegisterValue:pic.storage.w.registerValue];
	if (self.registerAddress == 1) {
		[pic.storage resetTmrCounter];
	}
}

- (void)executeCLRF:(PSVirtualPIC *)pic {
	PSRegister *reg = [pic.storage registerforAddress:self.registerAddress];
	[reg setRegisterValue:0x00];
	pic.storage.status.bit2 = 1;
}

- (void)executeCLRW:(PSVirtualPIC *)pic {
	pic.storage.w.registerValue = 0x00;
	pic.storage.status.bit2 = 1;
}

- (void)executeSLEEP {
	NSLog(@"Not implemented");
}

- (void)executeADDLW:(PSVirtualPIC *)pic {
	;
	if (pic.storage.w.registerValue == 0) {
		pic.storage.status.bit2 = 1;
	} else {
		pic.storage.status.bit2 = 0;
	}
}

- (void)executeBTFSC:(PSVirtualPIC *)pic {
	PSRegister *reg = [pic.storage registerforAddress:self.registerAddress];
	if (!([reg bitValueForBit:self.bitAddress])) { // Wenn Bit nicht gesetzt ist, Programmzähler erhöhen. Dadurch wird nächste Zeile übersprungen
		pic.storage.pc++;
	}
}

- (void)executeBTFSS:(PSVirtualPIC *)pic {
	PSRegister *reg = [pic.storage registerforAddress:self.registerAddress];
	if ([reg bitValueForBit:self.bitAddress]) { // Wenn Bit gesetzt ist, Programmzähler erhöhen. Dadurch wird nächste Zeile übersprungen
		pic.storage.pc++;
	}
}

- (void)executeCALL:(PSVirtualPIC *)pic {
	[pic.callStack push:(pic.storage.pc)];
	// ACHTUNG! HACK! Oberer Teil des Programmzählers wird ignoriert.
	pic.storage.pc = self.literal - 1;
}

- (void)executeMOVLW:(PSVirtualPIC *)pic {
	pic.storage.w.registerValue = self.literal;
}

- (void)executeRETLW:(PSVirtualPIC *)pic {
	pic.storage.pc = pic.callStack.pop;
	pic.storage.w.registerValue = self.literal;
}

	// Code, der die eigenlichen Befehle dann ausführt
- (void)executeWithVirtualPIC:(PSVirtualPIC *)pic {
		// Prüfung ob mit PORTB gearbeitet wird (für PORTB-Interrupt)
	if (self.registerAddress == 0x06 || pic.storage.fsr.registerValue == 0x06) {
		[pic.storage resetOldRb0];
	}
	
		// Prüfen, welche Bank in Benutzung ist
	if (pic.storage.status.bit5 && !(self.registerAddress&0b0000100000000000)) {
			// Auf Bank 1 schreiben
		self.registerAddress = self.registerAddress + 0x80;
	}

	if ([self.instruction isEqualToString:@"CLRWDT"]) {
		[self executeCLRWDT:pic];
		return;
	}
	
	if ([self.instruction isEqualToString:@"RETFIE"]) {
		[self executeRETFIE:pic];
		return;
	}
	
	if ([self.instruction isEqualToString:@"RETURN"]) {
        [self executeRETURN:pic];
        return;
	}
	
	if ([self.instruction isEqualToString:@"SLEEP"]) {
		[self executeSLEEP];
		return;
	}
	
	if ([self.instruction isEqualToString:@"NOP"]) {
        //Nope Nope Nope Nope Nope
		return;
	}
	
	if ([self.instruction isEqualToString:@"CLRW"]) {
		[self executeCLRW:pic];
		return;
	}
	
	if ([self.instruction isEqualToString:@"MOVWF"]) {
		[self executeMOVWF:pic];
		return;
	}
	
	if ([self.instruction isEqualToString:@"CLRF"]) {
		[self executeCLRF:pic];
		return;
	}
	
	if ([self.instruction isEqualToString:@"ADDWF"]) {
		[self executeADDWF:pic];
		return;
	}
	
	if ([self.instruction isEqualToString:@"ANDWF"]) {
		[self executeANDWF:pic];
		return;
	}
	
	if ([self.instruction isEqualToString:@"COMF"]) {
		[self executeCOMF:pic];
		return;
	}
	
	if ([self.instruction isEqualToString:@"DECF"]) {
		[self executeDECF:pic];
		return;
	}
	
	if ([self.instruction isEqualToString:@"DECFSZ"]) {
		[self executeDECFSZ:pic];
		return;
	}
	
	if ([self.instruction isEqualToString:@"INCF"]) {
		[self executeINCF:pic];
		return;
	}
	
	if ([self.instruction isEqualToString:@"INCFSZ"]) {
		[self executeINCFSZ:pic];
		return;
	}
	
	if ([self.instruction isEqualToString:@"IORWF"]) {
		[self executeIORWF:pic];
		return;
	}
	
	if ([self.instruction isEqualToString:@"MOVF"]) {
		[self executeMOVF:pic];
		return;
	}
	
	if ([self.instruction isEqualToString:@"RLF"]) {
		[self executeRLF:pic];
		return;
	}
	
	if ([self.instruction isEqualToString:@"RRF"]) {
		[self executeRRF:pic];
		return;
	}
	
	if ([self.instruction isEqualToString:@"SUBWF"]) {
		[self executeSUBWF:pic];
		return;
	}
	
	if ([self.instruction isEqualToString:@"SWAPF"]) {
		[self executeSWAPF:pic];
		return;
	}
	
	if ([self.instruction isEqualToString:@"XORWF"]) {
		[self executeXORWF:pic];
		return;
	}
	
	if ([self.instruction isEqualToString:@"ADDLW"]) {
		pic.storage.w.registerValue += self.literal;
		return;
	}
	
	if ([self.instruction isEqualToString:@"ANDLW"]) {
        [self executeANDLW:pic];
        return;
	}
	
	if ([self.instruction isEqualToString:@"IORLW"]) {
        [self executeIORLW:pic];
        return;
	}
	
	if ([self.instruction isEqualToString:@"XORLW"]) {
        [self executeXORLW:pic];
        return;
	}
	
	if ([self.instruction isEqualToString:@"SUBLW"]) {
        [self executeSUBLW:pic];

        return;
	}
	
	if ([self.instruction isEqualToString:@"BCF"]) {
        [self executeBCF:pic];
        return;
	}
	
	if ([self.instruction isEqualToString:@"BSF"]) {
        [self executeBSF:pic];
        return;
	}
	
	if ([self.instruction isEqualToString:@"BTFSC"]) {
		[self executeBTFSC:pic];
		return;
	}
	
	if ([self.instruction isEqualToString:@"BTFSS"]) {
		[self executeBTFSS:pic];
		return;
	}
	
	if ([self.instruction isEqualToString:@"MOVLW"]) {
		[self executeMOVLW:pic];
		return;
	}
	
	if ([self.instruction isEqualToString:@"RETLW"]) {
		[self executeRETLW:pic];
		return;
	}
	
	if ([self.instruction isEqualToString:@"CALL"]) {
		[self executeCALL:pic];
		return;
	}
	
	if ([self.instruction isEqualToString:@"GOTO"]) {
        [self executeGOTO:pic];
        return;
	}
}

- (void)executeRETURN:(PSVirtualPIC *)pic {
// Programmzähler vom Call Stack holen
    pic.storage.pc = [pic.callStack pop];
}

- (void)executeANDLW:(PSVirtualPIC *)pic {
    pic.storage.w.registerValue = pic.storage.w.registerValue & self.literal;
    if (pic.storage.w.registerValue == 0) {
        pic.storage.status.bit2 = 1;
    } else {
        pic.storage.status.bit2 = 0;
    }
}

- (void)executeIORLW:(PSVirtualPIC *)pic {
    pic.storage.w.registerValue = pic.storage.w.registerValue | self.literal;
    if (pic.storage.w.registerValue == 0) {
        pic.storage.status.bit2 = 1;
    } else {
        pic.storage.status.bit2 = 0;
    }
}

- (void)executeXORLW:(PSVirtualPIC *)pic {
    pic.storage.w.registerValue = pic.storage.w.registerValue ^ self.literal;
    if (pic.storage.w.registerValue == 0) {
        pic.storage.status.bit2 = 1;
    } else {
        pic.storage.status.bit2 = 0;
    }
}

- (void)executeSUBLW:(PSVirtualPIC *)pic {
    PSRegister *statusRegister = pic.storage.status;
    PSRegister *wRegister = pic.storage.w;
    wRegister.registerValue = self.literal - wRegister.registerValue;

    if(wRegister.registerValue > 0 && wRegister.registerValue < 0xFF){
statusRegister.bit0 = true;
statusRegister.bit2 = false;

}
    if(wRegister.registerValue == 0){
statusRegister.bit0 = true;
statusRegister.bit2 = true;
}
    if(wRegister.registerValue == 0xFF){
statusRegister.bit0 = false;
statusRegister.bit2 = false;
}
}

- (void)executeBCF:(PSVirtualPIC *)pic {
    PSRegister *fileRegister = [pic.storage registerforAddress:self.registerAddress];
    switch (self.bitAddress) {
        case 0:
            fileRegister.bit0 = false;
            break;
        case 1:
            fileRegister.bit1 = false;
            break;
        case 2:
            fileRegister.bit2 = false;
            break;
        case 3:
            fileRegister.bit3 = false;
            break;
        case 4:
            fileRegister.bit4 = false;
            break;
        case 5:
            fileRegister.bit5 = false;
            break;
        case 6:
            fileRegister.bit6 = false;
            break;
        case 7:
            fileRegister.bit7 = false;
            break;
    }
}

- (void)executeBSF:(PSVirtualPIC *)pic {
    PSRegister *fileRegister = [pic.storage registerforAddress:self.registerAddress];
    switch (self.bitAddress) {
        case 0:
            fileRegister.bit0 = true;
            break;
        case 1:
            fileRegister.bit1 = true;
            break;
        case 2:
            fileRegister.bit2 = true;
            break;
        case 3:
            fileRegister.bit3 = true;
            break;
        case 4:
            fileRegister.bit4 = true;
            break;
        case 5:
            fileRegister.bit5 = true;
            break;
        case 6:
            fileRegister.bit6 = true;
            break;
        case 7:
            fileRegister.bit7 = true;
            break;
    }
}

- (void)executeGOTO:(PSVirtualPIC *)pic {
    pic.storage.pc = self.literal - 1;
}

@end
