//
//  CreateAddressController.h
//  Assignment7
//
//  Created by Snow Leopard User on 31/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CreateAddressController : UIViewController<UITextFieldDelegate> {
	UIView* parentView;
	NSMutableArray* imageArray;
	NSString* selectedRole;
}
@property (readwrite,nonatomic,assign) UIView* parentView;
@property (readwrite,nonatomic,retain) NSMutableArray* imageArray;
@property (readwrite,nonatomic,retain) NSString* selectedRole;
- (IBAction) submitEmployee:(id)sender;
-(IBAction) toCountryPicker:(id)sender;
@end
