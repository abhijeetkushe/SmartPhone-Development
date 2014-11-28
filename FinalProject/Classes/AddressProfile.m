//
//  AddressProfile.m
//  FinalProject
//
//  Created by Snow Leopard User on 28/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AddressProfile.h"
#import "Employee.h"
#import "Address.h"
@implementation AddressProfile
@synthesize emp;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	UIView* addrView=self.view;
	Address* address=emp.address;
	((UITextField*)[addrView viewWithTag:1]).text=address.street;	
	((UITextField*)[addrView viewWithTag:2]).text=address.aptNum;
	((UITextField*)[addrView viewWithTag:3]).text=address.city;
	((UITextField*)[addrView viewWithTag:4]).text=address.stateCode;
	((UITextField*)[addrView viewWithTag:6]).text=address.zipCode;
	((UITextField*)[addrView viewWithTag:5]).text=address.country;
		
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[emp release];
    [super dealloc];
}


@end
