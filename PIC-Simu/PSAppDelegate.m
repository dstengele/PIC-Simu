//
//  DSAppDelegate.m
//  PIC-Simu
//
//  Created by Dennis Stengele on 31/03/14.
//  Copyright (c) 2014 Dennis Stengele. All rights reserved.
//

#import "PSAppDelegate.h"

@implementation PSAppDelegate

@synthesize buttonMenu;
@synthesize buttonToolbar;
@synthesize codeView;
@synthesize resetButtonMenu;
@synthesize resetButtonToolbar;
@synthesize source;
@synthesize startButtonMenu;
@synthesize startButtonToolbar;
@synthesize stepButtonMenu;
@synthesize stepButtonToolbar;
@synthesize stopButtonMenu;
@synthesize stopButtonToolbar;
@synthesize window;

- (void)logButtonStatus {
	NSLog(@"Status Startbutton: %hhd", [self.startButtonToolbar isEnabled]);
	NSLog(@"Status Stopbutton: %hhd", [self.stopButtonToolbar isEnabled]);
	NSLog(@"Status Stepbutton: %hhd", [self.stepButtonToolbar isEnabled]);
	NSLog(@"Status Resetbutton: %hhd", [self.resetButtonToolbar isEnabled]);
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	
		//TODO: Alles in extra-Methode verpacken, mgl.weise mit switch-case in einer einzigen
	[self.startButtonMenu setEnabled:NO];
	[self.startButtonToolbar setEnabled:NO];
	
	[self.stopButtonMenu setEnabled:NO];
	[self.stopButtonToolbar setEnabled:NO];
	
	[self.stepButtonMenu setEnabled:NO];
	[self.stepButtonToolbar setEnabled:NO];
	
	[self.resetButtonMenu setEnabled:NO];
	[self.resetButtonToolbar setEnabled:NO];
	
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
	[self.source initWithTextFile:path];
	
	[self.startButtonMenu setEnabled:true];
	[self.startButtonToolbar setEnabled:true];
}

	//TODO: Müsste in einer einzelnen Methode möglich sein, Tags für Buttons setzen und darauf prüfen
- (IBAction)startButtonPress:(id)sender {
	[self.startButtonMenu setEnabled:NO];
	[self.startButtonToolbar setEnabled:NO];
	
	[self.stopButtonMenu setEnabled:YES];
	[self.stopButtonToolbar setEnabled:YES];
	
	[self.stepButtonMenu setEnabled:NO];
	[self.stepButtonToolbar setEnabled:NO];
	
	[self.resetButtonMenu setEnabled:NO];
	[self.resetButtonToolbar setEnabled:NO];
	[self logButtonStatus];
}
- (IBAction)stopButtonPress:(id)sender {
	[self.startButtonMenu setEnabled:YES];
	[self.startButtonToolbar setEnabled:YES];
	
	[self.stopButtonMenu setEnabled:NO];
	[self.stopButtonToolbar setEnabled:NO];
	
	[self.stepButtonMenu setEnabled:YES];
	[self.stepButtonToolbar setEnabled:YES];
	
	[self.resetButtonMenu setEnabled:YES];
	[self.resetButtonToolbar setEnabled:YES];
	[self logButtonStatus];
}
- (IBAction)stepButtonPress:(id)sender {
	
}
- (IBAction)resetButtonPress:(id)sender {
	
}

@end
