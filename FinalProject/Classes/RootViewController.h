//
//  RootViewController.h
//  FinalProject
//
//  Created by Snow Leopard User on 14/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController {
	NSMutableArray* options;
}
@property (readwrite,nonatomic, retain)NSMutableArray* options;
@end
