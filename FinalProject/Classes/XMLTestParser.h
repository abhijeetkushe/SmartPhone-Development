//
//  XMLTestParser.h
//  XML
//
//  Created by Snow Leopard User on 26/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Test1,FinalProjectAppDelegate,Question,ScoreValue,CategoryCount;
@interface XMLTestParser : NSObject<NSXMLParserDelegate> {
	NSMutableString *currentElementValue;
	NSMutableArray *parentElementArray;
	FinalProjectAppDelegate *appDelegate;
	Test1 *test;
	Question *question;
	ScoreValue *scoreVal;
	CategoryCount *categoryCount;
}
- (XMLTestParser *) initXMLParser;
@end
