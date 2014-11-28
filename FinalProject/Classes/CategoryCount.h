//
//  CategoryCount.h
//  XML
//
//  Created by Snow Leopard User on 27/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CategoryCount : NSObject {
	NSInteger  count;
	NSString *category;	
}
@property (nonatomic, retain,readwrite) NSString *category;
@property (nonatomic, readwrite) NSInteger  count;
@end
