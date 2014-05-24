//
//  PSCallStack.m
//  PIC-Simu
//
//  Created by Dennis Stengele on 12/05/14.
//  Copyright (c) 2014 Dennis Stengele. All rights reserved.
//

#import "PSCallStack.h"

@implementation PSCallStack

@synthesize count;
@synthesize m_array;

- (id)init {
	self = [super init];
    if (self) {
        m_array = [[NSMutableArray alloc] init];
        count = 0;
    }
    return self;
}

- (void)push:(NSInteger)pc {
	[self willChangeValueForKey:@"m_array"];
    [self.m_array addObject:[NSNumber numberWithInteger:pc]];
    self.count = (int)self.m_array.count;
	[self didChangeValueForKey:@"m_array"];
}

- (NSInteger)pop {
	[self willChangeValueForKey:@"m_array"];
    id obj = nil;
    if (self.m_array.count > 0) {
        obj = [self.m_array lastObject];
        [self.m_array removeLastObject];
        self.count = (int)self.m_array.count;
    }
	[self didChangeValueForKey:@"m_array"];
    return [obj integerValue];
}

- (void)clear {
    [self.m_array removeAllObjects];
    self.count = 0;
}
@end
