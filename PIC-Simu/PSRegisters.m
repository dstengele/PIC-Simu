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
@end
