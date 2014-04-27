//
//  PSRegister.h
//  PIC-Simu
//
//  Created by Dennis Stengele on 14/04/14.
//  Copyright (c) 2014 Dennis Stengele. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSRegister : NSObject

@property (readwrite) BOOL bit0;
@property (readwrite) BOOL bit1;
@property (readwrite) BOOL bit2;
@property (readwrite) BOOL bit3;
@property (readwrite) BOOL bit4;
@property (readwrite) BOOL bit5;
@property (readwrite) BOOL bit6;
@property (readwrite) BOOL bit7;
@property (retain) NSString *stringValue;

- (void)setRegisterValueWithBinaryString:(NSString *)binaryString;
- (void)setRegisterValueWithDecimalNumber:(NSInteger *)decimalNumber;
- (NSInteger)registerValue;
- (id)init;

@end
