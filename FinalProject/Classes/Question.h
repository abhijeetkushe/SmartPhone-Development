//
//  Question.h
//  XML
//
//  Created by Snow Leopard User on 26/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Question : NSObject {
	NSString *question;
	NSString *option1;	
	NSString *option2;	
	NSString *option3;	
	NSString *option4;	
	double  score1;
	double  score2;
	double  score3;
	double  score4;
	
}
@property (nonatomic, retain,readwrite) NSString *question;
@property (nonatomic, retain,readwrite) NSString *option1;
@property (nonatomic, retain,readwrite) NSString *option2;
@property (nonatomic, retain,readwrite) NSString *option3;
@property (nonatomic, retain,readwrite) NSString *option4;	
@property (nonatomic, readwrite) double score1;
@property (nonatomic, readwrite) double score2;
@property (nonatomic, readwrite) double score3;
@property (nonatomic, readwrite) double score4;
@end
