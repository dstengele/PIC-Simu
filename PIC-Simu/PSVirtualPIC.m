//
//  PSSourceFile.m
//  PIC-Simu
//
//  Created by Dennis Stengele on 31/03/14.
//  Copyright (c) 2014 Dennis Stengele. All rights reserved.
//

#import "PSVirtualPIC.h"

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
	self.fileContents = [fileString componentsSeparatedByString:delimiter];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return fileContents.count;
}

- (id)tableView:(NSTableView *)tableView
objectValueForTableColumn:(NSTableColumn *)tableColumn
			row:(NSInteger)row {
    return [fileContents objectAtIndex:row];
}

@end
