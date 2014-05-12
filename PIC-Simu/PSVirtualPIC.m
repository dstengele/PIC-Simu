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
@synthesize pc;
@synthesize wdt;

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

- (void)executeNextInstruction {
	NSUInteger nextInstructionRow = [self.fileContents indexOfObjectPassingTest:
									 ^BOOL(id obj, NSUInteger idx, BOOL *stop){
										 PSLineOfCode *l = obj;
										 NSString *pcString = [NSString stringWithFormat:@"%ld", (long)self.pc];
										 if ([l.programCounter isEqualTo:pcString]) {
											 return TRUE;
										 }
										 return FALSE;
									 }
									];
	NSString *instructionString = [[self.fileContents objectAtIndex:nextInstructionRow] instruction];

	int16_t instructionBinary = [instructionString intValue];
	PSInstruction *instruction = [[PSInstruction alloc] initWithBits:instructionBinary];

	[instruction executeWithVirtualPIC:self];

}

- (void)setRegisterwithAddress:(int16_t)address toValue:(int16_t)value {
	switch (address) {
		case 0x00:
		case 0x80:
			[self.storage.indf setRegisterValueWithDecimalNumber:(long)value];
			break;
		
		case 0x01:
			[self.storage.tmr0 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x02:
		case 0x82:
			[self.storage.pcl setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x03:
		case 0x83:
			[self.storage.status setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x04:
		case 0x84:
			[self.storage.fsr setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x05:
			[self.storage.porta setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x06:
			[self.storage.portb setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x07:
			break;
			
		case 0x08:
			[self.storage.eedata setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x09:
			[self.storage.eeadr setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x0A:
		case 0x8A:
			[self.storage.pclath setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x0B:
		case 0x8B:
			[self.storage.intcon setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x81:
			[self.storage.option setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x85:
			[self.storage.trisa setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x86:
			[self.storage.trisb setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x88:
			[self.storage.eecon1 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x89:
			[self.storage.eecon2 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
			
			
		case 0x0C:
		case 0x8C:
			[self.storage.reg0C setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x0D:
		case 0x8D:
			[self.storage.reg0D setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x0E:
		case 0x8E:
			[self.storage.reg0E setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x0F:
		case 0x8F:
			[self.storage.reg0F setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x10:
		case 0x90:
			[self.storage.reg10 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x11:
		case 0x91:
			[self.storage.reg11 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x12:
		case 0x92:
			[self.storage.reg12 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x13:
		case 0x93:
			[self.storage.reg13 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x14:
		case 0x94:
			[self.storage.reg14 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x15:
		case 0x95:
			[self.storage.reg15 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x16:
		case 0x96:
			[self.storage.reg16 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x17:
		case 0x97:
			[self.storage.reg17 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x18:
		case 0x98:
			[self.storage.reg18 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x19:
		case 0x99:
			[self.storage.reg19 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x1A:
		case 0x9A:
			[self.storage.reg1A setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x1B:
		case 0x9B:
			[self.storage.reg1B setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x1C:
		case 0x9C:
			[self.storage.reg1C setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x1D:
		case 0x9D:
			[self.storage.reg1D setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x1E:
		case 0x9E:
			[self.storage.reg1E setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x1F:
		case 0x9F:
			[self.storage.reg1F setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x20:
		case 0xA0:
			[self.storage.reg20 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x21:
		case 0xA1:
			[self.storage.reg21 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x22:
		case 0xA2:
			[self.storage.reg22 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x23:
		case 0xA3:
			[self.storage.reg23 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x24:
		case 0xA4:
			[self.storage.reg24 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x25:
		case 0xA5:
			[self.storage.reg25 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x26:
		case 0xA6:
			[self.storage.reg26 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x27:
		case 0xA7:
			[self.storage.reg27 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x28:
		case 0xA8:
			[self.storage.reg28 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x29:
		case 0xA9:
			[self.storage.reg29 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x2A:
		case 0xAA:
			[self.storage.reg2A setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x2B:
		case 0xAB:
			[self.storage.reg2B setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x2C:
		case 0xAC:
			[self.storage.reg2C setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x2D:
		case 0xAD:
			[self.storage.reg2D setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x2E:
		case 0xAE:
			[self.storage.reg2E setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x2F:
		case 0xAF:
			[self.storage.reg2F setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x30:
		case 0xB0:
			[self.storage.reg30 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x31:
		case 0xB1:
			[self.storage.reg31 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x32:
		case 0xB2:
			[self.storage.reg32 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x33:
		case 0xB3:
			[self.storage.reg33 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x34:
		case 0xB4:
			[self.storage.reg34 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x35:
		case 0xB5:
			[self.storage.reg35 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x36:
		case 0xB6:
			[self.storage.reg36 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x37:
		case 0xB7:
			[self.storage.reg37 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x38:
		case 0xB8:
			[self.storage.reg38 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x39:
		case 0xB9:
			[self.storage.reg39 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x3A:
		case 0xBA:
			[self.storage.reg3A setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x3B:
		case 0xBB:
			[self.storage.reg3B setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x3C:
		case 0xBC:
			[self.storage.reg3C setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x3D:
		case 0xBD:
			[self.storage.reg3D setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x3E:
		case 0xBE:
			[self.storage.reg3E setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x3F:
		case 0xBF:
			[self.storage.reg3F setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x40:
		case 0xC0:
			[self.storage.reg40 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x41:
		case 0xC1:
			[self.storage.reg41 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x42:
		case 0xC2:
			[self.storage.reg42 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x43:
		case 0xC3:
			[self.storage.reg43 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x44:
		case 0xC4:
			[self.storage.reg44 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x45:
		case 0xC5:
			[self.storage.reg45 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x46:
		case 0xC6:
			[self.storage.reg46 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x47:
		case 0xC7:
			[self.storage.reg47 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x48:
		case 0xC8:
			[self.storage.reg48 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x49:
		case 0xC9:
			[self.storage.reg49 setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x4A:
		case 0xCA:
			[self.storage.reg4A setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x4B:
		case 0xCB:
			[self.storage.reg4B setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x4C:
		case 0xCC:
			[self.storage.reg4C setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x4D:
		case 0xCD:
			[self.storage.reg4D setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x4E:
		case 0xCE:
			[self.storage.reg4E setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		case 0x4F:
		case 0xCF:
			[self.storage.reg4F setRegisterValueWithDecimalNumber:(long)value];
			break;
			
		default:
			break;
	}
}

- (void)timerFireMethod:(NSTimer *)timer {
	[self executeNextInstruction];
}

@end
