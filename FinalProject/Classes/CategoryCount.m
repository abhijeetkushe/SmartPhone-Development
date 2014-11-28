//
//  CategoryCount.m
//  XML
//
//  Created by Snow Leopard User on 27/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CategoryCount.h"


@implementation CategoryCount 
@synthesize count, category;

- (void) dealloc {
	
	[category release];
	[super dealloc];
}
@end
