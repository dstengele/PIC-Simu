//
//  PSRegisters.h
//  PIC-Simu
//
//  Created by Dennis Stengele on 07/04/14.
//  Copyright (c) 2014 Dennis Stengele. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSRegister.h"

@interface PSRegisters : NSObject

	// Special Function Registers
	// Bank 1
@property (readwrite) PSRegister *indf;
@property (readwrite) PSRegister *tmr0;
@property (readwrite) PSRegister *pcl;
@property (readwrite) PSRegister *status;
@property (readwrite) PSRegister *fsr;
@property (readwrite) PSRegister *porta;
@property (readwrite) PSRegister *portb;
@property (readwrite) PSRegister *eedata;
@property (readwrite) PSRegister *eeadr;
@property (readwrite) PSRegister *pclath;
@property (readwrite) PSRegister *intcon;

	// Bank 2
@property (readwrite) PSRegister *option;
@property (readwrite) PSRegister *trisa;
@property (readwrite) PSRegister *trisb;
@property (readwrite) PSRegister *eecon1;
@property (readwrite) PSRegister *eecon2;

	// General Purpose
@property (readwrite) PSRegister *reg0C;
@property (readwrite) PSRegister *reg0D;
@property (readwrite) PSRegister *reg0E;
@property (readwrite) PSRegister *reg0F;

@property (readwrite) PSRegister *reg10;
@property (readwrite) PSRegister *reg11;
@property (readwrite) PSRegister *reg12;
@property (readwrite) PSRegister *reg13;
@property (readwrite) PSRegister *reg14;
@property (readwrite) PSRegister *reg15;
@property (readwrite) PSRegister *reg16;
@property (readwrite) PSRegister *reg17;
@property (readwrite) PSRegister *reg18;
@property (readwrite) PSRegister *reg19;
@property (readwrite) PSRegister *reg1A;
@property (readwrite) PSRegister *reg1B;
@property (readwrite) PSRegister *reg1C;
@property (readwrite) PSRegister *reg1D;
@property (readwrite) PSRegister *reg1E;
@property (readwrite) PSRegister *reg1F;

@property (readwrite) PSRegister *reg20;
@property (readwrite) PSRegister *reg21;
@property (readwrite) PSRegister *reg22;
@property (readwrite) PSRegister *reg23;
@property (readwrite) PSRegister *reg24;
@property (readwrite) PSRegister *reg25;
@property (readwrite) PSRegister *reg26;
@property (readwrite) PSRegister *reg27;
@property (readwrite) PSRegister *reg28;
@property (readwrite) PSRegister *reg29;
@property (readwrite) PSRegister *reg2A;
@property (readwrite) PSRegister *reg2B;
@property (readwrite) PSRegister *reg2C;
@property (readwrite) PSRegister *reg2D;
@property (readwrite) PSRegister *reg2E;
@property (readwrite) PSRegister *reg2F;

@property (readwrite) PSRegister *reg30;
@property (readwrite) PSRegister *reg31;
@property (readwrite) PSRegister *reg32;
@property (readwrite) PSRegister *reg33;
@property (readwrite) PSRegister *reg34;
@property (readwrite) PSRegister *reg35;
@property (readwrite) PSRegister *reg36;
@property (readwrite) PSRegister *reg37;
@property (readwrite) PSRegister *reg38;
@property (readwrite) PSRegister *reg39;
@property (readwrite) PSRegister *reg3A;
@property (readwrite) PSRegister *reg3B;
@property (readwrite) PSRegister *reg3C;
@property (readwrite) PSRegister *reg3D;
@property (readwrite) PSRegister *reg3E;
@property (readwrite) PSRegister *reg3F;

@property (readwrite) PSRegister *reg40;
@property (readwrite) PSRegister *reg41;
@property (readwrite) PSRegister *reg42;
@property (readwrite) PSRegister *reg43;
@property (readwrite) PSRegister *reg44;
@property (readwrite) PSRegister *reg45;
@property (readwrite) PSRegister *reg46;
@property (readwrite) PSRegister *reg47;
@property (readwrite) PSRegister *reg48;
@property (readwrite) PSRegister *reg49;
@property (readwrite) PSRegister *reg4A;
@property (readwrite) PSRegister *reg4B;
@property (readwrite) PSRegister *reg4C;
@property (readwrite) PSRegister *reg4D;
@property (readwrite) PSRegister *reg4E;
@property (readwrite) PSRegister *reg4F;

@end
