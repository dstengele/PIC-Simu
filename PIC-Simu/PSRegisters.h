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

@end
