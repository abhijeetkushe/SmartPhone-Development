//
//  PersonalProfile.m
//  FinalProject
//
//  Created by Snow Leopard User on 28/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PersonalProfile.h"
#import "Employee.h"
#import "AddressProfile.h"

@implementation PersonalProfile
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
	UIView* createView=self.view;
	
	((UITextField*)[createView viewWithTag:1]).text=emp.firstname;	
	
	
	
	((UITextField*)[createView viewWithTag:2]).text=emp.lastName;
	
	((UITextField*)[createView viewWithTag:3]).text=emp.email;
	
	
	NSDateFormatter* df=[[[NSDateFormatter alloc ]init] autorelease];
	[df setDateFormat:@"MM-dd-yyyy"];
	
	NSString* dobDate=[df stringFromDate:emp.dob];
	
	
	((UITextField*)[createView viewWithTag:4]).text=dobDate;
	
	
	
	((UITextField*)[createView viewWithTag:5]).text=emp.phoneno;
	
	
	((UITextField*)[createView viewWithTag:6]).text=emp.userName;
	
	
	((UITextField*)[createView viewWithTag:7]).text=emp.password;
	
	UIButton* radio1=(UIButton*)[createView viewWithTag:8];
	UIButton* radio2=(UIButton*)[createView viewWithTag:9];

	[radio1 setImage:[UIImage imageNamed:@"radio_sel.jpg"] forState:UIControlStateSelected];
	[radio1 setImage:[UIImage imageNamed:@"radio_unsel.jpg"] forState:UIControlStateNormal];
	radio1.selected=NO;
	[radio1 addTarget:self action:@selector(checkboxButton:) forControlEvents:UIControlEventTouchUpInside];
	[radio2 setImage:[UIImage imageNamed:@"radio_sel.jpg"] forState:UIControlStateSelected];
	[radio2 setImage:[UIImage imageNamed:@"radio_unsel.jpg"] forState:UIControlStateNormal];
	radio2.selected=NO;
	[radio2 addTarget:self action:@selector(checkboxButton:) forControlEvents:UIControlEventTouchUpInside];
	if([emp.role isEqual:@"Doctor"]){
		radio1.selected=YES;
		radio2.enabled=NO;
	}else {
		radio1.enabled=NO;
		radio2.selected=YES;
	}
	

}
	
- (void)checkboxButton:(UIButton *)button{
		/*if(![radio1 isEqual:button]){
			[radio1 setSelected:NO];
		}	
		if(![radio2 isEqual:button]){
			[radio2 setSelected:NO];
		}	
		if (!button.selected) {
			button.selected = YES;
		}*/
}
	
- (IBAction) toAddressPage:(id)sender {	
	AddressProfile *addAddrController = [[AddressProfile alloc] initWithNibName:@"AddressProfile" bundle:nil ];
	addAddrController.emp=emp;
	[self.navigationController pushViewController:addAddrController animated:YES];
	[addAddrController release];
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
