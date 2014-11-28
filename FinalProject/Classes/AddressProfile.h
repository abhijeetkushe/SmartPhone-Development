//
//  AddressProfile.h
//  FinalProject
//
//  Created by Snow Leopard User on 28/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Employee;
@interface AddressProfile : UIViewController {
	Employee* emp;
}
@property (readwrite,nonatomic, retain)Employee* emp;
@end
