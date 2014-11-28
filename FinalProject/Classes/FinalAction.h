//
//  Action.h
//  FinalProject
//
//  Created by Snow Leopard User on 14/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FinalAction : NSObject {
	NSString *image;
	NSString *description;
	NSString *type;
}
@property (readwrite,nonatomic, copy) NSString *type;
@property (readwrite,nonatomic, copy) NSString *description;
@property (readwrite,nonatomic, copy) NSString *image;
+ (id)actionWithType:(NSString *)type description:(NSString *)description image:(NSString*) image;
@end
