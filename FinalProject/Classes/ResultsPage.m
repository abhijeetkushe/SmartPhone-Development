//
//  ResultsPage.m
//  XML
//
//  Created by Snow Leopard User on 27/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ResultsPage.h"


@implementation ResultsPage
@synthesize testN,testCat,testS,testRes,testID;
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
	category.text=self.testCat;
	testName.text=self.testN;
	testScore.text=[NSString stringWithFormat:@"%d",self.testS];
	testResult.text=self.testRes;
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
	[testN release];
	[testCat release];
	[testRes release];	
    [super dealloc];
}


@end
