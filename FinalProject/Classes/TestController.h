//
//  testController.h
//  XML
//
//  Created by Snow Leopard User on 27/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TestController : UIViewController {
	IBOutlet UIButton *personality;
	IBOutlet UIButton *parenting;
	IBOutlet UIButton *depression;
	IBOutlet UIButton *anxiety;
	IBOutlet UIButton *addiction;
	IBOutlet UIButton *thoughts;
	UIViewController* rootView;
}
-(IBAction) submitCategory:(id)sender;
@property (nonatomic, assign,readwrite) UIViewController* rootView;

@end
