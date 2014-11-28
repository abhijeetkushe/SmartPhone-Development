//
//  addEmployeeController.h
//  Assignment7
//
//  Created by Snow Leopard User on 30/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddUserController : UIViewController<UITextFieldDelegate> {
	IBOutlet UIButton *radio1;
	IBOutlet UIButton *radio2;
}
@property(readwrite,retain) IBOutlet UIButton *radio1;
@property(readwrite,retain) IBOutlet UIButton *radio2;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil initialText:(NSString *)txt ;
-(IBAction) toAddressPage:(id)sender;
-(IBAction) toDatePicker:(id)sender;

@end
