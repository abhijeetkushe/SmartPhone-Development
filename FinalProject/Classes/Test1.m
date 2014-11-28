//
//  Test.m
//  XML
//
//  Created by Snow Leopard User on 26/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Test1.h"


@implementation Test1
@synthesize testID,testName,testCategory, questionList, resultList;

- (void) dealloc {
	
	[testName release];
	[testCategory release];
	[questionList release];
	[resultList release];
	[super dealloc];
}
@end
