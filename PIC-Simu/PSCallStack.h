//
//  PSCallStack.h
//  PIC-Simu
//
//  Created by Dennis Stengele on 12/05/14.
//  Copyright (c) 2014 Dennis Stengele. All rights reserved.
//

@import Foundation;

@interface PSCallStack : NSObject {
}

@property (retain) NSMutableArray *m_array;
@property (readwrite) int count;

- (void)push:(NSInteger)pc;
- (NSInteger)pop;
- (void)clear;

@end
