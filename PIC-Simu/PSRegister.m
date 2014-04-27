//
//  PSRegister.m
//  PIC-Simu
//
//  Created by Dennis Stengele on 14/04/14.
//  Copyright (c) 2014 Dennis Stengele. All rights reserved.
//

#import "PSRegister.h"

@implementation PSRegister

@synthesize bit0;
@synthesize bit1;
@synthesize bit2;
@synthesize bit3;
@synthesize bit4;
@synthesize bit5;
@synthesize bit6;
@synthesize bit7;

@synthesize stringValue;


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

	//Im Format Bit 7 ... Bit 0
- (void)setRegisterValueWithBinaryString:(NSString *)binaryString {
	NSError *error = NULL;
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[01]{8}"
																		   options:NSRegularExpressionCaseInsensitive
																			 error:&error];
	NSUInteger count = [regex numberOfMatchesInString:binaryString
											  options:NSMatchingAnchored
												range:NSMakeRange(0, [binaryString length])];
	if (count == 1 && [binaryString length] == 8) {
		[self setBit7:(BOOL)[binaryString substringWithRange:NSMakeRange(0, 1)]];
		[self setBit6:(BOOL)[binaryString substringWithRange:NSMakeRange(1, 1)]];
		[self setBit5:(BOOL)[binaryString substringWithRange:NSMakeRange(2, 1)]];
		[self setBit4:(BOOL)[binaryString substringWithRange:NSMakeRange(3, 1)]];
		[self setBit3:(BOOL)[binaryString substringWithRange:NSMakeRange(4, 1)]];
		[self setBit2:(BOOL)[binaryString substringWithRange:NSMakeRange(5, 1)]];
		[self setBit1:(BOOL)[binaryString substringWithRange:NSMakeRange(6, 1)]];
		[self setBit0:(BOOL)[binaryString substringWithRange:NSMakeRange(7, 1)]];
	}
}

- (void)setRegisterValueWithDecimalNumber:(NSInteger *)decimalNumber {
	if (*decimalNumber > 255) {
		[NSException raise:@"Register set to invalid value"
					format:@"Value %ld is too big", *decimalNumber];
	}
	NSMutableString *str = [NSMutableString string];
	NSInteger decimalNumberCopy = *decimalNumber;
	
		// Magic from Stackoverflow
	for(NSInteger i = 0; i < 8 ; i++) {
			// Prepend "0" or "1", depending on the bit
		[str insertString:((decimalNumberCopy & 1) ? @"1" : @"0") atIndex:0];
		decimalNumberCopy >>= 1;
	}
	self.stringValue = str;
}

- (NSInteger)registerValue {
	return (int)bit7*128+(int)bit6*64+(int)bit5*32+(int)bit4*16+(int)bit3*8+(int)bit2*4+(int)bit1*2+(int)bit0;
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
		[self setRegisterValueWithDecimalNumber:&valueInt];
	}
}

@end
