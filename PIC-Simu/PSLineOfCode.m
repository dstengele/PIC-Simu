//
//  PSLineOfCode.m
//  PIC-Simu
//
//  Created by Dennis Stengele on 08/04/14.
//  Copyright (c) 2014 Dennis Stengele. All rights reserved.
//

#import "PSLineOfCode.h"

@implementation PSLineOfCode

@synthesize hasBreakpoint;
@synthesize loc;
@synthesize instruction;
@synthesize programCounter;

- (id)init {
	self = [super init];
	if (self) {
		self.hasBreakpoint = false;
		self.loc = [[NSString alloc] init];
		self.instruction = [[NSString alloc] init];
		self.programCounter = [[NSString alloc] init];
	}
	return self;
}

@end
