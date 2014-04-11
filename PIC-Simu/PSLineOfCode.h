//
//  PSLineOfCode.h
//  PIC-Simu
//
//  Created by Dennis Stengele on 08/04/14.
//  Copyright (c) 2014 Dennis Stengele. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSLineOfCode : NSObject

@property(readwrite) BOOL hasBreakpoint;
@property(readwrite) NSString* loc;				// Einzelne Zeile Code als NSString
@property(readwrite) NSString* instruction;		// Einzelne Instruktion im Assembler als NSString
@property(readwrite) NSString* programCounter;	// Program Counter als NSString (0-indiziert)

@end
