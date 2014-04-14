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
}

- (NSInteger)registerValue {
	return 0;
}

@end
