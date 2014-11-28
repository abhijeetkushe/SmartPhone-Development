//
//  ScoreValue.m
//  XML
//
//  Created by Snow Leopard User on 26/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ScoreValue.h"


@implementation ScoreValue
@synthesize score, result;

-(NSComparisonResult) compare:(ScoreValue*) obj{
	if (score<obj.score) {
		return NSOrderedAscending;
	}else if (score==obj.score) {
		return NSOrderedSame;
	}else{
		return NSOrderedDescending;
	}	
}	
- (void) dealloc {
	
	[result release];
	[super dealloc];
}
@end
