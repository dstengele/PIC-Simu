//
//  PSInstruction.h
//  PIC-Simu
//
//  Created by Dennis Stengele on 28/04/14.
//  Copyright (c) 2014 Dennis Stengele. All rights reserved.
//

@import Foundation;
#import "PSRegisters.h"
#import "PSVirtualPIC.h"

@interface PSInstruction : NSObject

@property (retain) NSString* instruction;
@property (readwrite) int8_t registerAddress;
@property (readwrite) int8_t bitAddress;
@property (readwrite) int8_t literal;
@property (readwrite) BOOL storeInF;

- (PSInstruction *)initWithBits:(int16_t)instructionBinary;
- (void)executeWithVirtualPIC:(PSVirtualPIC *)pic;

@end
