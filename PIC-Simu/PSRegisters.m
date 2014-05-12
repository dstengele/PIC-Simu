//
//  PSRegisters.m
//  PIC-Simu
//
//  Created by Dennis Stengele on 07/04/14.
//  Copyright (c) 2014 Dennis Stengele. All rights reserved.
//

#import "PSRegisters.h"

@implementation PSRegisters

@synthesize w;

	// Bank 0
@synthesize indf;
@synthesize tmr0;
@synthesize pcl;
@synthesize status;
@synthesize fsr;
@synthesize porta;
@synthesize portb;
@synthesize eedata;
@synthesize eeadr;
@synthesize pclath;
@synthesize intcon;

	// Bank 1
@synthesize option;
@synthesize trisa;
@synthesize trisb;
@synthesize eecon1;
@synthesize eecon2;

	// GPR
@synthesize reg0C;
@synthesize reg0D;
@synthesize reg0E;
@synthesize reg0F;

@synthesize reg10;
@synthesize reg11;
@synthesize reg12;
@synthesize reg13;
@synthesize reg14;
@synthesize reg15;
@synthesize reg16;
@synthesize reg17;
@synthesize reg18;
@synthesize reg19;
@synthesize reg1A;
@synthesize reg1B;
@synthesize reg1C;
@synthesize reg1D;
@synthesize reg1E;
@synthesize reg1F;

@synthesize reg20;
@synthesize reg21;
@synthesize reg22;
@synthesize reg23;
@synthesize reg24;
@synthesize reg25;
@synthesize reg26;
@synthesize reg27;
@synthesize reg28;
@synthesize reg29;
@synthesize reg2A;
@synthesize reg2B;
@synthesize reg2C;
@synthesize reg2D;
@synthesize reg2E;
@synthesize reg2F;

@synthesize reg30;
@synthesize reg31;
@synthesize reg32;
@synthesize reg33;
@synthesize reg34;
@synthesize reg35;
@synthesize reg36;
@synthesize reg37;
@synthesize reg38;
@synthesize reg39;
@synthesize reg3A;
@synthesize reg3B;
@synthesize reg3C;
@synthesize reg3D;
@synthesize reg3E;
@synthesize reg3F;

@synthesize reg40;
@synthesize reg41;
@synthesize reg42;
@synthesize reg43;
@synthesize reg44;
@synthesize reg45;
@synthesize reg46;
@synthesize reg47;
@synthesize reg48;
@synthesize reg49;
@synthesize reg4A;
@synthesize reg4B;
@synthesize reg4C;
@synthesize reg4D;
@synthesize reg4E;
@synthesize reg4F;


- (id)init {
	self = [super init];

	if (self) {
			// SFR
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

- (void)setRegister:(uint16_t)registerAddress toValue:(uint16_t)newValue {
	switch (registerAddress) {
		case 0x00:
			self.indf.registerValue = newValue;
			break;

		case 0x01:
			self.tmr0.registerValue = newValue;
			break;

		case 0x02:
			self.pcl.registerValue = newValue;
			break;

		case 0x03:
			self.status.registerValue = newValue;
			break;

		case 0x04:
			self.fsr.registerValue = newValue;
			break;

		case 0x05:
			self.porta.registerValue = newValue;
			break;

		case 0x06:
			self.portb.registerValue = newValue;
			break;

		case 0x08:
			self.eedata.registerValue = newValue;
			break;

		case 0x09:
			self.eeadr.registerValue = newValue;
			break;

		case 0x0A:
			self.pclath.registerValue = newValue;
			break;

		case 0x0B:
			self.intcon.registerValue = newValue;
			break;

		case 0x81:
			self.option.registerValue = newValue;
			break;

		case 0x85:
			self.trisa.registerValue = newValue;
			break;

		case 0x86:
			self.trisb.registerValue = newValue;
			break;

		case 0x88:
			self.eecon1.registerValue = newValue;
			break;

		case 0x89:
			self.eecon2.registerValue = newValue;
			break;

		case 0x0C:
			self.reg0C.registerValue = newValue;
			break;

		case 0x0D:
			self.reg0D.registerValue = newValue;
			break;

		case 0x0E:
			self.reg0E.registerValue = newValue;
			break;

		case 0x0F:
			self.reg0F.registerValue = newValue;
			break;

		case 0x10:
			self.reg10.registerValue = newValue;
			break;

		case 0x11:
			self.reg11.registerValue = newValue;
			break;

		case 0x12:
			self.reg12.registerValue = newValue;
			break;

		case 0x13:
			self.reg13.registerValue = newValue;
			break;

		case 0x14:
			self.reg14.registerValue = newValue;
			break;

		case 0x15:
			self.reg15.registerValue = newValue;
			break;

		case 0x16:
			self.reg16.registerValue = newValue;
			break;

		case 0x17:
			self.reg17.registerValue = newValue;
			break;

		case 0x18:
			self.reg18.registerValue = newValue;
			break;

		case 0x19:
			self.reg19.registerValue = newValue;
			break;

		case 0x1A:
			self.reg1A.registerValue = newValue;
			break;

		case 0x1B:
			self.reg1B.registerValue = newValue;
			break;

		case 0x1C:
			self.reg1C.registerValue = newValue;
			break;

		case 0x1D:
			self.reg1D.registerValue = newValue;
			break;

		case 0x1E:
			self.reg1E.registerValue = newValue;
			break;

		case 0x1F:
			self.reg1F.registerValue = newValue;
			break;

		case 0x20:
			self.reg20.registerValue = newValue;
			break;

		case 0x21:
			self.reg21.registerValue = newValue;
			break;

		case 0x22:
			self.reg22.registerValue = newValue;
			break;

		case 0x23:
			self.reg23.registerValue = newValue;
			break;

		case 0x24:
			self.reg24.registerValue = newValue;
			break;

		case 0x25:
			self.reg25.registerValue = newValue;
			break;

		case 0x26:
			self.reg26.registerValue = newValue;
			break;

		case 0x27:
			self.reg27.registerValue = newValue;
			break;

		case 0x28:
			self.reg28.registerValue = newValue;
			break;

		case 0x29:
			self.reg29.registerValue = newValue;
			break;

		case 0x2A:
			self.reg2A.registerValue = newValue;
			break;

		case 0x2B:
			self.reg2B.registerValue = newValue;
			break;

		case 0x2C:
			self.reg2C.registerValue = newValue;
			break;

		case 0x2D:
			self.reg2D.registerValue = newValue;
			break;

		case 0x2E:
			self.reg2E.registerValue = newValue;
			break;

		case 0x2F:
			self.reg2F.registerValue = newValue;
			break;

		case 0x30:
			self.reg30.registerValue = newValue;
			break;

		case 0x31:
			self.reg31.registerValue = newValue;
			break;

		case 0x32:
			self.reg32.registerValue = newValue;
			break;

		case 0x33:
			self.reg33.registerValue = newValue;
			break;

		case 0x34:
			self.reg34.registerValue = newValue;
			break;

		case 0x35:
			self.reg35.registerValue = newValue;
			break;

		case 0x36:
			self.reg36.registerValue = newValue;
			break;

		case 0x37:
			self.reg37.registerValue = newValue;
			break;

		case 0x38:
			self.reg38.registerValue = newValue;
			break;

		case 0x39:
			self.reg39.registerValue = newValue;
			break;

		case 0x3A:
			self.reg3A.registerValue = newValue;
			break;

		case 0x3B:
			self.reg3B.registerValue = newValue;
			break;

		case 0x3C:
			self.reg3C.registerValue = newValue;
			break;

		case 0x3D:
			self.reg3D.registerValue = newValue;
			break;

		case 0x3E:
			self.reg3E.registerValue = newValue;
			break;

		case 0x3F:
			self.reg3F.registerValue = newValue;
			break;

		case 0x40:
			self.reg40.registerValue = newValue;
			break;

		case 0x41:
			self.reg41.registerValue = newValue;
			break;

		case 0x42:
			self.reg42.registerValue = newValue;
			break;

		case 0x43:
			self.reg43.registerValue = newValue;
			break;

		case 0x44:
			self.reg44.registerValue = newValue;
			break;

		case 0x45:
			self.reg45.registerValue = newValue;
			break;

		case 0x46:
			self.reg46.registerValue = newValue;
			break;

		case 0x47:
			self.reg47.registerValue = newValue;
			break;

		case 0x48:
			self.reg48.registerValue = newValue;
			break;

		case 0x49:
			self.reg49.registerValue = newValue;
			break;

		case 0x4A:
			self.reg4A.registerValue = newValue;
			break;

		case 0x4B:
			self.reg4B.registerValue = newValue;
			break;

		case 0x4C:
			self.reg4C.registerValue = newValue;
			break;

		case 0x4D:
			self.reg4D.registerValue = newValue;
			break;

		case 0x4E:
			self.reg4E.registerValue = newValue;
			break;

		case 0x4F:
			self.reg4F.registerValue = newValue;
			break;

		default:
			break;
	}
}

- (uint16_t)registerValueforAddress:(uint16_t)registerAddress {
	switch (registerAddress) {
		case 0x00:
			return self.indf.registerValue;

		case 0x01:
			return self.tmr0.registerValue;

		case 0x02:
			return self.pcl.registerValue;

		case 0x03:
			return self.status.registerValue;

		case 0x04:
			return self.fsr.registerValue;

		case 0x05:
			return self.porta.registerValue;

		case 0x06:
			return self.portb.registerValue;

		case 0x08:
			return self.eedata.registerValue;

		case 0x09:
			return self.eeadr.registerValue;

		case 0x0A:
			return self.pclath.registerValue;

		case 0x0B:
			return self.intcon.registerValue;

		case 0x81:
			return self.option.registerValue;

		case 0x85:
			return self.trisa.registerValue;

		case 0x86:
			return self.trisb.registerValue;

		case 0x88:
			return self.eecon1.registerValue;

		case 0x89:
			return self.eecon2.registerValue;

		case 0x0C:
			return self.reg0C.registerValue;

		case 0x0D:
			return self.reg0D.registerValue;

		case 0x0E:
			return self.reg0E.registerValue;

		case 0x0F:
			return self.reg0F.registerValue;

		case 0x10:
			return self.reg10.registerValue;

		case 0x11:
			return self.reg11.registerValue;

		case 0x12:
			return self.reg12.registerValue;

		case 0x13:
			return self.reg13.registerValue;

		case 0x14:
			return self.reg14.registerValue;

		case 0x15:
			return self.reg15.registerValue;

		case 0x16:
			return self.reg16.registerValue;

		case 0x17:
			return self.reg17.registerValue;

		case 0x18:
			return self.reg18.registerValue;

		case 0x19:
			return self.reg19.registerValue;

		case 0x1A:
			return self.reg1A.registerValue;

		case 0x1B:
			return self.reg1B.registerValue;

		case 0x1C:
			return self.reg1C.registerValue;

		case 0x1D:
			return self.reg1D.registerValue;

		case 0x1E:
			return self.reg1E.registerValue;

		case 0x1F:
			return self.reg1F.registerValue;

		case 0x20:
			return self.reg20.registerValue;

		case 0x21:
			return self.reg21.registerValue;

		case 0x22:
			return self.reg22.registerValue;

		case 0x23:
			return self.reg23.registerValue;

		case 0x24:
			return self.reg24.registerValue;

		case 0x25:
			return self.reg25.registerValue;

		case 0x26:
			return self.reg26.registerValue;

		case 0x27:
			return self.reg27.registerValue;

		case 0x28:
			return self.reg28.registerValue;

		case 0x29:
			return self.reg29.registerValue;

		case 0x2A:
			return self.reg2A.registerValue;

		case 0x2B:
			return self.reg2B.registerValue;

		case 0x2C:
			return self.reg2C.registerValue;

		case 0x2D:
			return self.reg2D.registerValue;

		case 0x2E:
			return self.reg2E.registerValue;

		case 0x2F:
			return self.reg2F.registerValue;

		case 0x30:
			return self.reg30.registerValue;

		case 0x31:
			return self.reg31.registerValue;

		case 0x32:
			return self.reg32.registerValue;

		case 0x33:
			return self.reg33.registerValue;

		case 0x34:
			return self.reg34.registerValue;

		case 0x35:
			return self.reg35.registerValue;

		case 0x36:
			return self.reg36.registerValue;

		case 0x37:
			return self.reg37.registerValue;

		case 0x38:
			return self.reg38.registerValue;

		case 0x39:
			return self.reg39.registerValue;

		case 0x3A:
			return self.reg3A.registerValue;

		case 0x3B:
			return self.reg3B.registerValue;

		case 0x3C:
			return self.reg3C.registerValue;

		case 0x3D:
			return self.reg3D.registerValue;

		case 0x3E:
			return self.reg3E.registerValue;

		case 0x3F:
			return self.reg3F.registerValue;

		case 0x40:
			return self.reg40.registerValue;

		case 0x41:
			return self.reg41.registerValue;

		case 0x42:
			return self.reg42.registerValue;

		case 0x43:
			return self.reg43.registerValue;

		case 0x44:
			return self.reg44.registerValue;

		case 0x45:
			return self.reg45.registerValue;

		case 0x46:
			return self.reg46.registerValue;

		case 0x47:
			return self.reg47.registerValue;

		case 0x48:
			return self.reg48.registerValue;

		case 0x49:
			return self.reg49.registerValue;

		case 0x4A:
			return self.reg4A.registerValue;

		case 0x4B:
			return self.reg4B.registerValue;

		case 0x4C:
			return self.reg4C.registerValue;

		case 0x4D:
			return self.reg4D.registerValue;

		case 0x4E:
			return self.reg4E.registerValue;

		case 0x4F:
			return self.reg4F.registerValue;

		default:
			return 0;
	}
}
@end
