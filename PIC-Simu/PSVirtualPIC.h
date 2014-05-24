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
@property (readwrite) NSInteger wdt;
@property (retain) PSCallStack* callStack;
@property (weak) IBOutlet NSTableView *codeView;
@property (weak) IBOutlet NSTableView *stackView;
@property (readwrite) NSInteger runtimeCounter;

@property (weak) IBOutlet NSTextField *cycleCounter;
@property (weak) IBOutlet NSTextField *timeCounter;

@property (readwrite) float cycleDuration;


@property (weak) IBOutlet NSTextField *textField0C;
@property (weak) IBOutlet NSTextField *textField0D;
@property (weak) IBOutlet NSTextField *textField0E;
@property (weak) IBOutlet NSTextField *textField0F;

@property (weak) IBOutlet NSTextField *textField10;
@property (weak) IBOutlet NSTextField *textField11;
@property (weak) IBOutlet NSTextField *textField12;
@property (weak) IBOutlet NSTextField *textField13;
@property (weak) IBOutlet NSTextField *textField14;
@property (weak) IBOutlet NSTextField *textField15;
@property (weak) IBOutlet NSTextField *textField16;
@property (weak) IBOutlet NSTextField *textField17;
@property (weak) IBOutlet NSTextField *textField18;
@property (weak) IBOutlet NSTextField *textField19;
@property (weak) IBOutlet NSTextField *textField1A;
@property (weak) IBOutlet NSTextField *textField1B;
@property (weak) IBOutlet NSTextField *textField1C;
@property (weak) IBOutlet NSTextField *textField1D;
@property (weak) IBOutlet NSTextField *textField1E;
@property (weak) IBOutlet NSTextField *textField1F;

@property (weak) IBOutlet NSTextField *textField20;
@property (weak) IBOutlet NSTextField *textField21;
@property (weak) IBOutlet NSTextField *textField22;
@property (weak) IBOutlet NSTextField *textField23;
@property (weak) IBOutlet NSTextField *textField24;
@property (weak) IBOutlet NSTextField *textField25;
@property (weak) IBOutlet NSTextField *textField26;
@property (weak) IBOutlet NSTextField *textField27;
@property (weak) IBOutlet NSTextField *textField28;
@property (weak) IBOutlet NSTextField *textField29;
@property (weak) IBOutlet NSTextField *textField2A;
@property (weak) IBOutlet NSTextField *textField2B;
@property (weak) IBOutlet NSTextField *textField2C;
@property (weak) IBOutlet NSTextField *textField2D;
@property (weak) IBOutlet NSTextField *textField2E;
@property (weak) IBOutlet NSTextField *textField2F;

@property (weak) IBOutlet NSTextField *textField30;
@property (weak) IBOutlet NSTextField *textField31;
@property (weak) IBOutlet NSTextField *textField32;
@property (weak) IBOutlet NSTextField *textField33;
@property (weak) IBOutlet NSTextField *textField34;
@property (weak) IBOutlet NSTextField *textField35;
@property (weak) IBOutlet NSTextField *textField36;
@property (weak) IBOutlet NSTextField *textField37;
@property (weak) IBOutlet NSTextField *textField38;
@property (weak) IBOutlet NSTextField *textField39;
@property (weak) IBOutlet NSTextField *textField3A;
@property (weak) IBOutlet NSTextField *textField3B;
@property (weak) IBOutlet NSTextField *textField3C;
@property (weak) IBOutlet NSTextField *textField3D;
@property (weak) IBOutlet NSTextField *textField3E;
@property (weak) IBOutlet NSTextField *textField3F;

@property (weak) IBOutlet NSTextField *textField40;
@property (weak) IBOutlet NSTextField *textField41;
@property (weak) IBOutlet NSTextField *textField42;
@property (weak) IBOutlet NSTextField *textField43;
@property (weak) IBOutlet NSTextField *textField44;
@property (weak) IBOutlet NSTextField *textField45;
@property (weak) IBOutlet NSTextField *textField46;
@property (weak) IBOutlet NSTextField *textField47;
@property (weak) IBOutlet NSTextField *textField48;
@property (weak) IBOutlet NSTextField *textField49;
@property (weak) IBOutlet NSTextField *textField4A;
@property (weak) IBOutlet NSTextField *textField4B;
@property (weak) IBOutlet NSTextField *textField4C;
@property (weak) IBOutlet NSTextField *textField4D;
@property (weak) IBOutlet NSTextField *textField4E;
@property (weak) IBOutlet NSTextField *textField4F;


- (void)initWithTextFile:(NSURL *)sourceFile;
- (NSIndexSet *)tableView:(NSTableView *)tableView selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes;
- (BOOL)executeNextInstruction;
- (void)timerFireMethod:(NSTimer *)timer;
- (void)updateFileRegisters;
- (void)resetRegisters;

- (void)updateRuntimeCounterViews;

- (void)setCycleDurationSlider:(float)newValue;
- (float)cycleDurationSlider;

@end
