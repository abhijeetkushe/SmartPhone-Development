//
//  Question.m
//  XML
//
//  Created by Snow Leopard User on 26/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Question.h"


@implementation Question
@synthesize question, option1, option2, option3,option4,score1,score2,score3,score4;

- (void) dealloc {
	
	[question release];
	[option1 release];
	[option2 release];
	[option3 release];
	[option4 release];
	[super dealloc];
}
@end
