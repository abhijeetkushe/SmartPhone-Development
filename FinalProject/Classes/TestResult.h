//
//  TestResult.h
//  XML
//
//  Created by Snow Leopard User on 27/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TestResult : NSObject {
	NSInteger question;
	NSInteger selectedOption;
}
@property(nonatomic,readwrite) NSInteger question;
@property(nonatomic,readwrite) NSInteger selectedOption;
@end
