//
//  PSSourceFile.m
//  PIC-Simu
//
//  Created by Dennis Stengele on 31/03/14.
//  Copyright (c) 2014 Dennis Stengele. All rights reserved.
//

#import "PSVirtualPIC.h"

@implementation PSVirtualPIC

- (void)initWithTextFile:(NSURL *)sourceFile {
		// Datei laden
	NSData* fileData = [NSData dataWithContentsOfURL:sourceFile];
	
		// Dateiinhalt in NSString konvertieren
	NSString* fileString = [[NSString alloc] initWithBytes:[fileData bytes]
													length:[fileData length]
												  encoding:NSUTF8StringEncoding];
	
	NSLog(@"%@", fileString);
	
	NSString* delimiter = @"\n";
	
		// Dateiinhalt als Array in Instanzvariable speichern
	[self setFileContents: [fileString componentsSeparatedByString:delimiter]];
}

- (NSArray *)fileContents {
    return fileContents;
}

- (void)setFileContents:(NSArray *)newValue {
    fileContents = newValue;
}

@end
