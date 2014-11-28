//
//  CountryPicker.h
//  FinalProject
//
//  Created by Snow Leopard User on 15/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CountryPicker : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource> {
	UIView* parentView;
	NSMutableArray* countryList;
	NSString* selectedValue;
	
}
@property (readwrite,retain,nonatomic)UIView* parentView;
@property (readwrite,retain,nonatomic) NSMutableArray* countryList;
@property (readwrite,retain,nonatomic) NSString* selectedValue;
-(IBAction) selectCountry:(id)sender; 
@end
