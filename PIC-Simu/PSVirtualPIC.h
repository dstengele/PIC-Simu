//
//  PSSourceFile.h
//  PIC-Simu
//
//  Created by Dennis Stengele on 31/03/14.
//  Copyright (c) 2014 Dennis Stengele. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSRegisters.h"

@interface PSVirtualPIC : NSObject {
	NSMutableArray *fileContents;
}
@property (weak) IBOutlet NSArrayController *locArrayController;
@property (retain) NSMutableArray* fileContents;
@property (weak) IBOutlet PSRegisters *storage;
@property (readwrite) NSInteger pc;

- (void)initWithTextFile:(NSURL *)sourceFile;
- (NSIndexSet *)tableView:(NSTableView *)tableView selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes;
- (void)executeNextIntruction;

@end
