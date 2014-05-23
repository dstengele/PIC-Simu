//
//  PSRegister.m
//  PIC-Simu
//
//  Created by Dennis Stengele on 14/04/14.
//  Copyright (c) 2014 Dennis Stengele. All rights reserved.
//

#import "PSRegister.h"

@implementation PSRegister

NSString *stringValue;

@synthesize bit0;
@synthesize bit1;
@synthesize bit2;
@synthesize bit3;
@synthesize bit4;
@synthesize bit5;
@synthesize bit6;
@synthesize bit7;



- (id)init {
	self = [super init];
	if (self) {
		self.bit0 = 0;
		self.bit1 = 0;
		self.bit2 = 0;
		self.bit3 = 0;
		self.bit4 = 0;
		self.bit5 = 0;
		self.bit6 = 0;
		self.bit7 = 0;
	}
	return self;
}

- (void)setRegisterValue:(NSInteger)decimalNumber {
	if (decimalNumber > 255) {
		[NSException raise:@"Register set to invalid value"
					format:@"Value %ld is too big", decimalNumber];
	}
	NSInteger binaryNumber = decimalNumber;
	self.bit0 = binaryNumber & 0b00000001;
	binaryNumber >>= 1;
	self.bit1 = binaryNumber & 0b00000001;
	binaryNumber >>= 1;
	self.bit2 = binaryNumber & 0b00000001;
	binaryNumber >>= 1;
	self.bit3 = binaryNumber & 0b00000001;
	binaryNumber >>= 1;
	self.bit4 = binaryNumber & 0b00000001;
	binaryNumber >>= 1;
	self.bit5 = binaryNumber & 0b00000001;
	binaryNumber >>= 1;
	self.bit6 = binaryNumber & 0b00000001;
	binaryNumber >>= 1;
	self.bit7 = binaryNumber & 0b00000001;
}

- (NSInteger)registerValue {
	return (int)self.bit7*128+(int)self.bit6*64+(int)self.bit5*32+(int)self.bit4*16+(int)self.bit3*8+(int)self.bit2*4+(int)self.bit1*2+(int)self.bit0;
}

- (NSString *)stringValue {
	NSString *value = [NSString stringWithFormat:@"0x%lX", (unsigned long)self.registerValue];
	return value;
}

- (void)setStringValue:(NSString *)newStringValue {
	NSError *error = NULL;
	NSRegularExpression *regexBinaryString = [NSRegularExpression regularExpressionWithPattern:@"[01]{8}"
																		   options:NSRegularExpressionCaseInsensitive
																			 error:&error];
	NSRegularExpression *regexHexString = [NSRegularExpression regularExpressionWithPattern:@"[0123456789ABCDEFabcdef]{2}"
																					   options:NSRegularExpressionCaseInsensitive
																						 error:&error];
	
	BOOL isBinary = [regexBinaryString numberOfMatchesInString:newStringValue
													   options:NSMatchingAnchored
														 range:NSMakeRange(0, [newStringValue length])] == 1;
	BOOL isHex = [regexHexString numberOfMatchesInString:newStringValue
													   options:NSMatchingAnchored
														 range:NSMakeRange(0, [newStringValue length])] == 1;
	
	if (isBinary) {
		self.bit0 = [[newStringValue substringWithRange:NSMakeRange(0, 1)] boolValue];
		self.bit1 = [[newStringValue substringWithRange:NSMakeRange(1, 1)] boolValue];
		self.bit2 = [[newStringValue substringWithRange:NSMakeRange(2, 1)] boolValue];
		self.bit3 = [[newStringValue substringWithRange:NSMakeRange(3, 1)] boolValue];
		self.bit4 = [[newStringValue substringWithRange:NSMakeRange(4, 1)] boolValue];
		self.bit5 = [[newStringValue substringWithRange:NSMakeRange(5, 1)] boolValue];
		self.bit6 = [[newStringValue substringWithRange:NSMakeRange(6, 1)] boolValue];
		self.bit7 = [[newStringValue substringWithRange:NSMakeRange(7, 1)] boolValue];
	}
	
	if (isHex) {
		unsigned int value = 0;
		NSScanner *scanner = [NSScanner scannerWithString:newStringValue];
		[scanner scanHexInt:&value];
		NSNumber *valueNum = [NSNumber numberWithUnsignedInt:value];
		NSInteger valueInt = [valueNum integerValue];

		[self setRegisterValue:valueInt];
	}
}

- (BOOL)bitValueForBit:(uint16_t)bitAddress {
	switch (bitAddress) {
		case 0:
			return self.bit0;
		case 1:
			return self.bit1;
		case 2:
			return self.bit2;
		case 3:
			return self.bit3;
		case 4:
			return self.bit4;
		case 5:
			return self.bit5;
		case 6:
			return self.bit6;
		case 7:
			return self.bit7;
		default:
			return false;
	}
}

- (void)setBitValueTo:(BOOL)newValue forBit:(uint16_t)bitAddress {
	switch (bitAddress) {
		case 0:
			self.bit0 = newValue;
		case 1:
			self.bit1 = newValue;
		case 2:
			self.bit2 = newValue;
		case 3:
			self.bit3 = newValue;
		case 4:
			self.bit4 = newValue;
		case 5:
			self.bit5 = newValue;
		case 6:
			self.bit6 = newValue;
		case 7:
			self.bit7 = newValue;
	}
}

@end
