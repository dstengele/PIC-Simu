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
@synthesize virtualPIC;
@synthesize startButtonMenu;
@synthesize startButtonToolbar;
@synthesize stepButtonMenu;
@synthesize stepButtonToolbar;
@synthesize stopButtonMenu;
@synthesize stopButtonToolbar;
@synthesize window;
@synthesize nextInstructionRunLoopTimer;

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

	// Öffnen einer neuen LST-Datei
- (IBAction)openFile:(id)sender {
		// File-open-Panel öffnen
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
	[self.virtualPIC initWithTextFile:path];
	
	[self.startButtonMenu setEnabled:true];
	[self.startButtonToolbar setEnabled:true];
}

	// Start-Knopf drücken
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
		// Timer für die automatische Ausführung des nächsten Befehls
	self.nextInstructionRunLoopTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self.virtualPIC selector:@selector(timerFireMethod:) userInfo:self repeats:YES];
	NSLog(@"Created Timer");
}

	// Stop-Knopf-drücken
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
		// Timer ausschalten
	if (self.nextInstructionRunLoopTimer != nil) {
		[self.nextInstructionRunLoopTimer invalidate];
		NSLog(@"Invalidated Timer");
	}
}

	// Step-Button gedrückt
- (IBAction)stepButtonPress:(id)sender {
	[self.virtualPIC executeNextInstruction];
	NSLog(@"Executed one instruction");
}

	// Reset-Button gedrückt
- (IBAction)resetButtonPress:(id)sender {
	[self.virtualPIC resetRegisters];
}

	// Öffnen der PDF-Hilfe
- (IBAction)showPDFHelp:(id)sender {
	NSBundle *mainBundle = [NSBundle mainBundle];
	NSString *bundlePath = [mainBundle bundlePath];
	NSString *documentationPath = [bundlePath stringByAppendingString:@"/Contents/Resources/en.lproj/Documentation.pdf"];	// Muss an dieser Stelle im Bundle liegen
	[[NSWorkspace sharedWorkspace] openURL:[NSURL fileURLWithPath:documentationPath]];
}
@end
