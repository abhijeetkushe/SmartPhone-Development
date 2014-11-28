//
//  Action.m
//  FinalProject
//
//  Created by Snow Leopard User on 14/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FinalAction.h"


@implementation FinalAction
@synthesize type, description,image;
+ (id)actionWithType:(NSString *)type description:(NSString *)description image:(NSString*) image
{
	FinalAction *newAction = [[[FinalAction alloc] init] autorelease];
	newAction.type = type;
	newAction.description = description;
	newAction.image=image;
	return newAction;
}

- (void) dealloc{
	[super dealloc];
	[description release];
	[type release];
	[image release];
}	
@end
