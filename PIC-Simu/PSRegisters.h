//
//  PSRegisters.h
//  PIC-Simu
//
//  Created by Dennis Stengele on 07/04/14.
//  Copyright (c) 2014 Dennis Stengele. All rights reserved.
//

@import Foundation;
#import "PSRegister.h"

@interface PSRegisters : NSObject

	// Special Function Registers
@property (retain) PSRegister *w;

	// Bank 1
@property (retain) PSRegister *indf;
@property (retain) PSRegister *tmr0;
@property (retain) PSRegister *pcl;
@property (retain) PSRegister *status;
@property (retain) PSRegister *fsr;
@property (retain) PSRegister *porta;
@property (retain) PSRegister *portb;
@property (retain) PSRegister *eedata;
@property (retain) PSRegister *eeadr;
@property (retain) PSRegister *pclath;
@property (retain) PSRegister *intcon;

	// Bank 2
@property (retain) PSRegister *option;
@property (retain) PSRegister *trisa;
@property (retain) PSRegister *trisb;
@property (retain) PSRegister *eecon1;
@property (retain) PSRegister *eecon2;

	// General Purpose
@property (retain) PSRegister *reg0C;
@property (retain) PSRegister *reg0D;
@property (retain) PSRegister *reg0E;
@property (retain) PSRegister *reg0F;

@property (retain) PSRegister *reg10;
@property (retain) PSRegister *reg11;
@property (retain) PSRegister *reg12;
@property (retain) PSRegister *reg13;
@property (retain) PSRegister *reg14;
@property (retain) PSRegister *reg15;
@property (retain) PSRegister *reg16;
@property (retain) PSRegister *reg17;
@property (retain) PSRegister *reg18;
@property (retain) PSRegister *reg19;
@property (retain) PSRegister *reg1A;
@property (retain) PSRegister *reg1B;
@property (retain) PSRegister *reg1C;
@property (retain) PSRegister *reg1D;
@property (retain) PSRegister *reg1E;
@property (retain) PSRegister *reg1F;

@property (retain) PSRegister *reg20;
@property (retain) PSRegister *reg21;
@property (retain) PSRegister *reg22;
@property (retain) PSRegister *reg23;
@property (retain) PSRegister *reg24;
@property (retain) PSRegister *reg25;
@property (retain) PSRegister *reg26;
@property (retain) PSRegister *reg27;
@property (retain) PSRegister *reg28;
@property (retain) PSRegister *reg29;
@property (retain) PSRegister *reg2A;
@property (retain) PSRegister *reg2B;
@property (retain) PSRegister *reg2C;
@property (retain) PSRegister *reg2D;
@property (retain) PSRegister *reg2E;
@property (retain) PSRegister *reg2F;

@property (retain) PSRegister *reg30;
@property (retain) PSRegister *reg31;
@property (retain) PSRegister *reg32;
@property (retain) PSRegister *reg33;
@property (retain) PSRegister *reg34;
@property (retain) PSRegister *reg35;
@property (retain) PSRegister *reg36;
@property (retain) PSRegister *reg37;
@property (retain) PSRegister *reg38;
@property (retain) PSRegister *reg39;
@property (retain) PSRegister *reg3A;
@property (retain) PSRegister *reg3B;
@property (retain) PSRegister *reg3C;
@property (retain) PSRegister *reg3D;
@property (retain) PSRegister *reg3E;
@property (retain) PSRegister *reg3F;

@property (retain) PSRegister *reg40;
@property (retain) PSRegister *reg41;
@property (retain) PSRegister *reg42;
@property (retain) PSRegister *reg43;
@property (retain) PSRegister *reg44;
@property (retain) PSRegister *reg45;
@property (retain) PSRegister *reg46;
@property (retain) PSRegister *reg47;
@property (retain) PSRegister *reg48;
@property (retain) PSRegister *reg49;
@property (retain) PSRegister *reg4A;
@property (retain) PSRegister *reg4B;
@property (retain) PSRegister *reg4C;
@property (retain) PSRegister *reg4D;
@property (retain) PSRegister *reg4E;
@property (retain) PSRegister *reg4F;

@end
