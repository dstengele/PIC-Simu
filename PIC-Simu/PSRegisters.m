//
//  PSRegisters.m
//  PIC-Simu
//
//  Created by Dennis Stengele on 07/04/14.
//  Copyright (c) 2014 Dennis Stengele. All rights reserved.
//

#import "PSRegisters.h"
#import "PSRegister.h"

	// "Speicher", beinhaltet alle Register
@implementation PSRegisters

BOOL oldRb0 = 0;
uint8_t oldRbValue = 0;

	// Init-Methode, initialisiert alle Register
- (id)init {
	self = [super init];

	if (self) {
			// SFR
		self.w	= [[PSRegister alloc] init];
		self.indf	= [[PSRegister alloc] init];
		self.tmr0	= [[PSRegister alloc] init];
		self.pcl	= [[PSRegister alloc] init];
		self.status = [[PSRegister alloc] init];
		self.fsr	= [[PSRegister alloc] init];
		self.porta	= [[PSRegister alloc] init];
		self.portb	= [[PSRegister alloc] init];
		self.eedata = [[PSRegister alloc] init];
		self.eeadr	= [[PSRegister alloc] init];
		self.pclath = [[PSRegister alloc] init];
		self.intcon = [[PSRegister alloc] init];
		self.option = [[PSRegister alloc] init];
		self.trisa	= [[PSRegister alloc] init];
		self.trisb	= [[PSRegister alloc] init];
		self.eecon1 = [[PSRegister alloc] init];
		self.eecon2 = [[PSRegister alloc] init];

			// GPR
		self.reg0C	= [[PSRegister alloc] init];
		self.reg0D	= [[PSRegister alloc] init];
		self.reg0E	= [[PSRegister alloc] init];
		self.reg0F	= [[PSRegister alloc] init];

		self.reg10	= [[PSRegister alloc] init];
		self.reg11	= [[PSRegister alloc] init];
		self.reg12	= [[PSRegister alloc] init];
		self.reg13	= [[PSRegister alloc] init];
		self.reg14	= [[PSRegister alloc] init];
		self.reg15	= [[PSRegister alloc] init];
		self.reg16	= [[PSRegister alloc] init];
		self.reg17	= [[PSRegister alloc] init];
		self.reg18	= [[PSRegister alloc] init];
		self.reg19	= [[PSRegister alloc] init];
		self.reg1A	= [[PSRegister alloc] init];
		self.reg1B	= [[PSRegister alloc] init];
		self.reg1C	= [[PSRegister alloc] init];
		self.reg1D	= [[PSRegister alloc] init];
		self.reg1E	= [[PSRegister alloc] init];
		self.reg1F	= [[PSRegister alloc] init];

		self.reg20	= [[PSRegister alloc] init];
		self.reg21	= [[PSRegister alloc] init];
		self.reg22	= [[PSRegister alloc] init];
		self.reg23	= [[PSRegister alloc] init];
		self.reg24	= [[PSRegister alloc] init];
		self.reg25	= [[PSRegister alloc] init];
		self.reg26	= [[PSRegister alloc] init];
		self.reg27	= [[PSRegister alloc] init];
		self.reg28	= [[PSRegister alloc] init];
		self.reg29	= [[PSRegister alloc] init];
		self.reg2A	= [[PSRegister alloc] init];
		self.reg2B	= [[PSRegister alloc] init];
		self.reg2C	= [[PSRegister alloc] init];
		self.reg2D	= [[PSRegister alloc] init];
		self.reg2E	= [[PSRegister alloc] init];
		self.reg2F	= [[PSRegister alloc] init];

		self.reg30	= [[PSRegister alloc] init];
		self.reg31	= [[PSRegister alloc] init];
		self.reg32	= [[PSRegister alloc] init];
		self.reg33	= [[PSRegister alloc] init];
		self.reg34	= [[PSRegister alloc] init];
		self.reg35	= [[PSRegister alloc] init];
		self.reg36	= [[PSRegister alloc] init];
		self.reg37	= [[PSRegister alloc] init];
		self.reg38	= [[PSRegister alloc] init];
		self.reg39	= [[PSRegister alloc] init];
		self.reg3A	= [[PSRegister alloc] init];
		self.reg3B	= [[PSRegister alloc] init];
		self.reg3C	= [[PSRegister alloc] init];
		self.reg3D	= [[PSRegister alloc] init];
		self.reg3E	= [[PSRegister alloc] init];
		self.reg3F	= [[PSRegister alloc] init];

		self.reg40	= [[PSRegister alloc] init];
		self.reg41	= [[PSRegister alloc] init];
		self.reg42	= [[PSRegister alloc] init];
		self.reg43	= [[PSRegister alloc] init];
		self.reg44	= [[PSRegister alloc] init];
		self.reg45	= [[PSRegister alloc] init];
		self.reg46	= [[PSRegister alloc] init];
		self.reg47	= [[PSRegister alloc] init];
		self.reg48	= [[PSRegister alloc] init];
		self.reg49	= [[PSRegister alloc] init];
		self.reg4A	= [[PSRegister alloc] init];
		self.reg4B	= [[PSRegister alloc] init];
		self.reg4C	= [[PSRegister alloc] init];
		self.reg4D	= [[PSRegister alloc] init];
		self.reg4E	= [[PSRegister alloc] init];
		self.reg4F	= [[PSRegister alloc] init];
	}
	return self;
}

	// Register mit Addresse auf bestimmten Wert setzen
- (void)setRegister:(uint8_t)registerAddress toValue:(uint8_t)newValue {
	PSRegister *reg = [self registerforAddress:registerAddress];
	[reg setRegisterValue:newValue];
}

	// Lookup-Methode, die für bestimmte Addresse das dazugehörende Register zurückgibt.
- (PSRegister *)registerforAddress:(uint8_t)registerAddress {
	switch (registerAddress) {
		case 0x00:
		case 0x80: {
			PSRegister *indirect = [self registerforAddress:self.fsr.registerValue];
			return indirect;
		}
			
		case 0x81:
			return self.option;

		case 0x01:
			return self.tmr0;

		case 0x02:
		case 0x82:
			return self.pcl;

		case 0x03:
		case 0x83:
			return self.status;

		case 0x04:
		case 0x84:
			return self.fsr;

		case 0x05:
			return self.porta;
			
		case 0x85:
			return self.trisa;

		case 0x06:
			return self.portb;
			
		case 0x86:
			return self.trisb;

		case 0x08:
			return self.eedata;
			
		case 0x88:
			return self.eecon1;

		case 0x09:
			return self.eeadr;
			
		case 0x89:
			return self.eecon2;

		case 0x0A:
		case 0x8A:
			return self.pclath;

		case 0x0B:
		case 0x8B:
			return self.intcon;


		case 0x0C:
			return self.reg0C;

		case 0x0D:
			return self.reg0D;

		case 0x0E:
			return self.reg0E;

		case 0x0F:
			return self.reg0F;

		case 0x10:
			return self.reg10;

		case 0x11:
			return self.reg11;

		case 0x12:
			return self.reg12;

		case 0x13:
			return self.reg13;

		case 0x14:
			return self.reg14;

		case 0x15:
			return self.reg15;

		case 0x16:
			return self.reg16;

		case 0x17:
			return self.reg17;

		case 0x18:
			return self.reg18;

		case 0x19:
			return self.reg19;

		case 0x1A:
			return self.reg1A;

		case 0x1B:
			return self.reg1B;

		case 0x1C:
			return self.reg1C;

		case 0x1D:
			return self.reg1D;

		case 0x1E:
			return self.reg1E;

		case 0x1F:
			return self.reg1F;

		case 0x20:
			return self.reg20;

		case 0x21:
			return self.reg21;

		case 0x22:
			return self.reg22;

		case 0x23:
			return self.reg23;

		case 0x24:
			return self.reg24;

		case 0x25:
			return self.reg25;

		case 0x26:
			return self.reg26;

		case 0x27:
			return self.reg27;

		case 0x28:
			return self.reg28;

		case 0x29:
			return self.reg29;

		case 0x2A:
			return self.reg2A;

		case 0x2B:
			return self.reg2B;

		case 0x2C:
			return self.reg2C;

		case 0x2D:
			return self.reg2D;

		case 0x2E:
			return self.reg2E;

		case 0x2F:
			return self.reg2F;

		case 0x30:
			return self.reg30;

		case 0x31:
			return self.reg31;

		case 0x32:
			return self.reg32;

		case 0x33:
			return self.reg33;

		case 0x34:
			return self.reg34;

		case 0x35:
			return self.reg35;

		case 0x36:
			return self.reg36;

		case 0x37:
			return self.reg37;

		case 0x38:
			return self.reg38;

		case 0x39:
			return self.reg39;

		case 0x3A:
			return self.reg3A;

		case 0x3B:
			return self.reg3B;

		case 0x3C:
			return self.reg3C;

		case 0x3D:
			return self.reg3D;

		case 0x3E:
			return self.reg3E;

		case 0x3F:
			return self.reg3F;

		case 0x40:
			return self.reg40;

		case 0x41:
			return self.reg41;

		case 0x42:
			return self.reg42;

		case 0x43:
			return self.reg43;

		case 0x44:
			return self.reg44;

		case 0x45:
			return self.reg45;

		case 0x46:
			return self.reg46;

		case 0x47:
			return self.reg47;

		case 0x48:
			return self.reg48;

		case 0x49:
			return self.reg49;

		case 0x4A:
			return self.reg4A;

		case 0x4B:
			return self.reg4B;

		case 0x4C:
			return self.reg4C;

		case 0x4D:
			return self.reg4D;

		case 0x4E:
			return self.reg4E;

		case 0x4F:
			return self.reg4F;

		default:
			return 0;
	}
}

	// Ausgeben des Wertes eines bestimmten Bits in einem bestimmten Register
- (BOOL)bitValueForAddress:(uint8_t)registerAddress andBit:(uint8_t)bitAddress {
	PSRegister *reg = [self registerforAddress:registerAddress];
	switch (bitAddress) {
		case 0:
			return reg.bit0;
		case 1:
			return reg.bit1;
		case 2:
			return reg.bit2;
		case 3:
			return reg.bit3;
		case 4:
			return reg.bit4;
		case 5:
			return reg.bit5;
		case 6:
			return reg.bit6;
		case 7:
			return reg.bit7;
		default:
			return false;
	}
}

	// Programmzähler berechnen und ausgeben
- (uint16_t)pc {
	uint16_t res =
	   (self.pclath.bit4 * 4096)
	+  (self.pclath.bit3 * 2048)
	+  (self.pclath.bit2 * 1024)
	+  (self.pclath.bit1 * 512)
	+  (self.pclath.bit0 * 256)
	+  (self.pcl.   bit7 * 128)
	+  (self.pcl.   bit6 * 64)
	+  (self.pcl.   bit5 * 32)
	+  (self.pcl.   bit4 * 16)
	+  (self.pcl.   bit3 * 8)
	+  (self.pcl.   bit2 * 4)
	+  (self.pcl.   bit1 * 2)
	+  (self.pcl.   bit0);
	
	return res;
}

	// Programmzähler setzen
- (void)setPc:(uint16_t)newPc {
		// Aufteilen in oberen und unteren Teil
	uint16_t newPcCopy = newPc & 0b0001111111111111;
	uint16_t high = newPcCopy &  0b1111111100000000;
	uint16_t low = newPcCopy &   0b0000000011111111;
	
		// Unteren Teil setzen
	[self.pcl setRegisterValue:low];
		// Oberen Teil setzen
	[self.pclath setRegisterValue:high];
}

	// Programmzähler erhöhen
- (void)incrementPc {
	uint16_t temp = [self pc];
	temp++;
	[self setPc:temp];
}

	// Internen Timer erhöhen
- (void)incrementTmr {
	uint8_t temp = self.tmr0.registerValue;
	temp++;
	self.tmr0.registerValue = temp;
}

	// Prüfen, ob das TMR0-Register übergelaufen ist und gegebenenfalls Interrupt setzen
- (BOOL)checkTmrInt {
	[self incrementTmr];
	if (self.tmr0.registerValue == 0) {
		self.status.bit2 = 1;
		if (self.intcon.bit5) {
			self.intcon.bit2 = 1;
			return TRUE;
			
		}
	}
	return FALSE;
}

	// Auf Flanke an RB0 prüfen und gegebenenfalls Interrupt setzen
- (BOOL)checkrb0Int {
	if (self.intcon.bit4) {
		if (self.option.bit6) {
			if (oldRb0 == 0 && self.portb.bit0 == 1) {
				self.intcon.bit1 = 1;
				oldRb0 = self.portb.bit0;
				return TRUE;
			}
		} else {
			if (oldRb0 == 1 && self.portb.bit0 == 0) {
				self.intcon.bit1 = 1;
				oldRb0 = self.portb.bit0;
				return TRUE;
			}
		}
	}
	oldRb0 = self.portb.bit0;
	return FALSE;
}

	// Auf Flanke an PORTB prüfen und gegebenenfalls Interrupt setzen
- (BOOL)checkportbInt {
	uint8_t bit7, bit6, bit5, bit4;
	(self.trisb.bit7)?(bit7 = 0):(bit7 = self.portb.bit7 * 128);
	
	(self.trisb.bit6)?(bit6 = 0):(bit6 = self.portb.bit6 * 64);
	
	(self.trisb.bit5)?(bit5 = 0):(bit5 = self.portb.bit5 * 32);
	
	(self.trisb.bit4)?(bit4 = 0):(bit4 = self.portb.bit4 * 16);
	
	uint8_t rbValue = bit7 + bit6 + bit5 + bit4;
	if (self.intcon.bit3) {
		if (rbValue != oldRbValue) {
			self.intcon.bit0 = 1;
			oldRbValue = rbValue;
			return TRUE;
		}
	}
	oldRbValue = rbValue;
	return FALSE;
}

	// RB0-Prüfvariable zurücksetzen. Wird benutzt, wenn eine Instruktion ausgeführt wird, die PORTB verändert.
	// Dabei soll der Interrupt nicht ausgelöst werden.
- (void)resetOldRb0 {
	oldRb0 = self.portb.bit0;
}
@end
