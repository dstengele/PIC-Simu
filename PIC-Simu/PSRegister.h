//
//  PSRegister.h
//  PIC-Simu
//
//  Created by Dennis Stengele on 14/04/14.
//  Copyright (c) 2014 Dennis Stengele. All rights reserved.
//

@import Foundation;

@interface PSRegister : NSObject

extern NSString *stringValue;

@property (readwrite) BOOL bit0;
@property (readwrite) BOOL bit1;
@property (readwrite) BOOL bit2;
@property (readwrite) BOOL bit3;
@property (readwrite) BOOL bit4;
@property (readwrite) BOOL bit5;
@property (readwrite) BOOL bit6;
@property (readwrite) BOOL bit7;

- (void)setRegisterValue:(uint8_t)decimalNumber;
- (uint8_t)registerValue;

- (BOOL)bitValueForBit:(uint8_t)bit;
- (void)setBitValueTo:(BOOL)newValue forBit:(uint8_t)bitAddress;

- (id)init;

@end
