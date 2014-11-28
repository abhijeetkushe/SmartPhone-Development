//
//  DatePickerController.m
//  Assignment7
//
//  Created by Snow Leopard User on 01/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DatePickerController.h"


@implementation DatePickerController
@synthesize parentView;
-(IBAction) selectDate:(id)sender {
	UIView *datePickerView=self.view;
	NSDate* dob=((UIDatePicker*)[datePickerView viewWithTag:1]).date;	
	NSDateFormatter* df=[[[NSDateFormatter alloc ]init] autorelease];
	[df setDateFormat:@"MM-dd-yyyy"];	
	((UITextField*)[self.parentView viewWithTag:4]).text=[df stringFromDate:dob];
	[self.navigationController popViewControllerAnimated:YES];
}	
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
    [super dealloc];
}


@end
