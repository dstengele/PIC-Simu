//
//  PSSourceFile.h
//  PIC-Simu
//
//  Created by Dennis Stengele on 31/03/14.
//  Copyright (c) 2014 Dennis Stengele. All rights reserved.
//

@import Foundation;
#import "PSRegisters.h"
#import "PSCallStack.h"

@interface PSVirtualPIC : NSObject {
}
@property (weak) IBOutlet NSArrayController *locArrayController;
@property (retain) NSMutableArray* fileContents;
@property (weak) IBOutlet PSRegisters *storage;
@property (readwrite) NSInteger pc;
@property (readwrite) NSInteger wdt;
@property (retain) PSRegister* regW;
@property (retain) PSCallStack* callStack;

- (void)initWithTextFile:(NSURL *)sourceFile;
- (NSIndexSet *)tableView:(NSTableView *)tableView selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes;
- (BOOL)executeNextInstruction;
//- (void)setRegisterwithAddress:(int16_t)address toValue:(int16_t)value;
- (void)timerFireMethod:(NSTimer *)timer;

@end
