//
//  PSSourceFile.m
//  PIC-Simu
//
//  Created by Dennis Stengele on 31/03/14.
//  Copyright (c) 2014 Dennis Stengele. All rights reserved.
//

#import "PSVirtualPIC.h"
#import "PSLineOfCode.h"

@implementation PSVirtualPIC

@synthesize fileContents;

- (void)initWithTextFile:(NSURL *)sourceFile {
		// Datei laden und -inhalt in NSString konvertieren (Datei muss UTF-8-kodiert sein)
	NSStringEncoding usedEnc;
	NSString* fileString = [NSString stringWithContentsOfURL:sourceFile usedEncoding:&usedEnc error:nil];
	NSLog(@"Opened File %@ using Encoding:%lu", sourceFile, usedEnc);
	
	NSLog(@"%@", fileString);
	
	NSString* delimiter = @"\n";
	
		// Dateiinhalt als Array in Instanzvariable speichern
	
	NSArray *fileArray = [fileString componentsSeparatedByString:delimiter];
	
	fileContents = [[NSMutableArray alloc] init];
	
	for (NSString *loc in fileArray) {
		PSLineOfCode *new_loc = [PSLineOfCode alloc];
		new_loc.loc = loc;
		new_loc.hasBreakpoint = NO;
		[fileContents addObject:new_loc];
	}
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return fileContents.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    PSLineOfCode *loc = [fileContents objectAtIndex:row];
	NSString *foo = [loc valueForKey:[tableColumn identifier]];
	NSLog(@"Added %@ to tableView in column %@", foo, [tableColumn identifier]);
	return foo;
}

@end
