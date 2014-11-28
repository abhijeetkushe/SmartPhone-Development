//
//  DatePickerController.h
//  Assignment7
//
//  Created by Snow Leopard User on 01/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DatePickerController : UIViewController {
	UIView* parentView;
}
@property (readwrite,assign,nonatomic)UIView* parentView;
-(IBAction) selectDate:(id)sender; 
@end
