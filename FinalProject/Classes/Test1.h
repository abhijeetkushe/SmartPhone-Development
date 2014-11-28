//
//  Test.h
//  XML
//
//  Created by Snow Leopard User on 26/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Test1 : NSObject {
	NSString* testName;
	NSString* testCategory;
	NSInteger testID;
	NSMutableArray *questionList;
	NSMutableArray *resultList;
}
@property (nonatomic, retain,readwrite) NSString *testName;
@property (nonatomic, retain,readwrite) NSString *testCategory;
@property (nonatomic, retain,readwrite) NSMutableArray *questionList;
@property (nonatomic, retain,readwrite) NSMutableArray *resultList;
@property (nonatomic, readwrite) NSInteger testID;
@end
