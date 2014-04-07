//
//  DSAppDelegate.m
//  PIC-Simu
//
//  Created by Dennis Stengele on 31/03/14.
//  Copyright (c) 2014 Dennis Stengele. All rights reserved.
//

#import "PSAppDelegate.h"

@implementation PSAppDelegate

- (void)logButtonStatus {
	NSLog(@"Status Startbutton: %hhd", [_startButtonToolbar isEnabled]);
	NSLog(@"Status Stopbutton: %hhd", [_stopButtonToolbar isEnabled]);
	NSLog(@"Status Stepbutton: %hhd", [_stepButtonToolbar isEnabled]);
	NSLog(@"Status Resetbutton: %hhd", [_resetButtonToolbar isEnabled]);
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	
		//TODO: Alles in extra-Methode verpacken, mgl.weise mit switch-case in einer einzigen
	[_startButtonMenu setEnabled:NO];
	[_startButtonToolbar setEnabled:NO];
	
	[_stopButtonMenu setEnabled:NO];
	[_stopButtonToolbar setEnabled:NO];
	
	[_stepButtonMenu setEnabled:NO];
	[_stepButtonToolbar setEnabled:NO];
	
	[_resetButtonMenu setEnabled:NO];
	[_resetButtonToolbar setEnabled:NO];
	
	[self logButtonStatus];
}
- (IBAction)openFile:(id)sender {
	NSOpenPanel* openPanel = [NSOpenPanel openPanel];
	[openPanel setCanChooseFiles:YES];
	[openPanel setCanCreateDirectories:NO];
	[openPanel setPrompt:@"PIC-Source auswählen"];
	[openPanel setAllowsMultipleSelection:NO];
	NSURL *path;
	if ([openPanel runModal] == NSOKButton) {
		NSArray* files = [openPanel URLs];
		path = [files objectAtIndex:0];
		NSLog(@"Pfad: %@", path);
	}
	[_source initWithTextFile:path];
	
	[_startButtonMenu setEnabled:true];
	[_startButtonToolbar setEnabled:true];
}

	//TODO: Müsste in einer einzelnen Methode möglich sein, Tags für Buttons setzen und darauf prüfen
- (IBAction)startButtonPress:(id)sender {
	[_startButtonMenu setEnabled:NO];
	[_startButtonToolbar setEnabled:NO];
	
	[_stopButtonMenu setEnabled:YES];
	[_stopButtonToolbar setEnabled:YES];
	
	[_stepButtonMenu setEnabled:NO];
	[_stepButtonToolbar setEnabled:NO];
	
	[_resetButtonMenu setEnabled:NO];
	[_resetButtonToolbar setEnabled:NO];
	[self logButtonStatus];
}
- (IBAction)stopButtonPress:(id)sender {
	[_startButtonMenu setEnabled:YES];
	[_startButtonToolbar setEnabled:YES];
	
	[_stopButtonMenu setEnabled:NO];
	[_stopButtonToolbar setEnabled:NO];
	
	[_stepButtonMenu setEnabled:YES];
	[_stepButtonToolbar setEnabled:YES];
	
	[_resetButtonMenu setEnabled:YES];
	[_resetButtonToolbar setEnabled:YES];
	[self logButtonStatus];
}
- (IBAction)stepButtonPress:(id)sender {
	
}
- (IBAction)resetButtonPress:(id)sender {
	
}

@end