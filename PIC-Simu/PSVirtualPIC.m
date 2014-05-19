//
//  PSSourceFile.m
//  PIC-Simu
//
//  Created by Dennis Stengele on 31/03/14.
//  Copyright (c) 2014 Dennis Stengele. All rights reserved.
//

#import "PSVirtualPIC.h"
#import "PSLineOfCode.h"
#import "PSInstruction.h"

@implementation PSVirtualPIC

@synthesize fileContents;
@synthesize regW;
@synthesize storage;
@synthesize locArrayController;
@synthesize wdt;
@synthesize callStack;
@synthesize codeView;

- (id)init {
	self = [super init];
	if (self) {
		fileContents = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)initWithTextFile:(NSURL *)sourceFile {
		// Datei laden und -inhalt in NSString konvertieren (Datei muss UTF-8-kodiert sein)
	NSStringEncoding usedEnc;
	NSString* fileString = [NSString stringWithContentsOfURL:sourceFile
												usedEncoding:&usedEnc
													   error:nil];
	NSLog(@"Opened File %@ using Encoding:%lu", sourceFile, usedEnc);

	NSLog(@"%@", fileString);

	NSString* delimiter = @"\n";

		// Dateiinhalt als Array in Instanzvariable speichern

	NSArray *fileArray = [fileString componentsSeparatedByString:delimiter];

	for (NSString *loc in fileArray) {
		PSLineOfCode *new_loc = [[PSLineOfCode alloc] init];
		new_loc.loc = loc;
		new_loc.instruction = [loc substringWithRange:NSMakeRange(5, 4)];
		new_loc.programCounter = [loc substringWithRange:NSMakeRange(0, 4)];
		[self.locArrayController addObject:new_loc];
	}
}

	// Prohibits selection in TableView showing Code
- (NSIndexSet *)tableView:(NSTableView *)tableView selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes {
	return NO;
}

- (BOOL)executeNextInstruction {
	NSUInteger nextInstructionRow = NSNotFound;
	nextInstructionRow = [self.fileContents indexOfObjectPassingTest:
							  ^BOOL(id obj, NSUInteger idx, BOOL *stop){
								  PSLineOfCode *l = obj;
								  NSScanner *scanner = [NSScanner scannerWithString:l.programCounter];
								  uint parsedPc;
								  [scanner scanHexInt:&parsedPc];
								  uint16_t pc = self.storage.pc;
								  if (pc == (NSInteger)parsedPc) {
									  return TRUE;
								  }
								  return FALSE;
							  }
							  ];
	if (nextInstructionRow == NSNotFound) {
		[NSException raise:@"Illegal Value in PCL or PCLATH Register!" format:@"Format Error"];
	}
	
	NSIndexSet *rows;
	NSLog(@"Instruction found: %ld", nextInstructionRow);
	rows = [NSIndexSet indexSetWithIndex:nextInstructionRow];
	[self.codeView selectRowIndexes:rows byExtendingSelection:FALSE];
	
	PSLineOfCode *loc = [self.fileContents objectAtIndex:nextInstructionRow];
	if (loc.hasBreakpoint) {
		return false;
	}
	NSString *instructionString = [[self.fileContents objectAtIndex:nextInstructionRow] instruction];

	int16_t instructionBinary = [instructionString intValue];
	PSInstruction *instruction = [[PSInstruction alloc] initWithBits:instructionBinary];

	[instruction executeWithVirtualPIC:self];
	[self.storage incrementPc];
	return true;
}

- (void)timerFireMethod:(NSTimer *)timer {
	if (![self executeNextInstruction]) {
		[timer invalidate];
	}
	return;
}

@end
