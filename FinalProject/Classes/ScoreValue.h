//
//  ScoreValue.h
//  XML
//
//  Created by Snow Leopard User on 26/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ScoreValue : NSObject {
	double  score;
	NSString *result;	
}
@property (nonatomic, retain,readwrite) NSString *result;
@property (nonatomic, readwrite) double score;
-(NSComparisonResult) compare:(ScoreValue*) obj;
@end
