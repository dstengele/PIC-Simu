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
		PSLineOfCode *new_loc = [PSLineOfCode alloc];
		new_loc.loc = loc;
		new_loc.hasBreakpoint = NO;
		new_loc.instruction = [loc substringWithRange:NSMakeRange(5, 4)];
		new_loc.programCounter = [loc substringWithRange:NSMakeRange(0, 4)];
		[_locArrayController addObject:new_loc];
	}
}

@end
