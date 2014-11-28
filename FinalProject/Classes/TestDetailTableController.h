//
//  TestDetailTableController.h
//  XML
//
//  Created by Snow Leopard User on 27/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FinalProjectAppDelegate;
@interface TestDetailTableController : UITableViewController {
	NSString *selectedCategory;
	NSMutableArray* categoryTests;
	FinalProjectAppDelegate *appDelegate;
}
@property(retain,nonatomic,readwrite) NSString *selectedCategory;
@property(assign,nonatomic,readwrite) NSMutableArray* categoryTests;

@end
