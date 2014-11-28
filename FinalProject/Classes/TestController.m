//
//  testController.m
//  XML
//
//  Created by Snow Leopard User on 27/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TestController.h"
#import "XMLTestParser.h"
#import "FinalProjectAppDelegate.h"
#import "CategoryCount.h"
#import "TestDetailTableController.h"

@implementation TestController
@synthesize rootView;
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
	self.title=@"Select Available Categories";
	NSURL *url = [[NSURL alloc] initWithString:@"http://192.168.247.1:8080/SpringMVCFinal/smartphone/upload/categorycount/all"];
	NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	
	//Initialize the delegate.
	XMLTestParser *parser = [[XMLTestParser alloc] initXMLParser];
	
	//Set delegate
	[xmlParser setDelegate:parser];
	
	//Start parsing the XML file.
	BOOL success = [xmlParser parse];
	
	if(success)
		NSLog(@"No Errors");
	else
		NSLog(@"Error Error Error!!!");
	FinalProjectAppDelegate *appDelegate = (FinalProjectAppDelegate *)[[UIApplication sharedApplication] delegate];
	personality.alpha=.50;
	parenting.alpha=.50;
	depression.alpha=.50;
	anxiety.alpha=.50;
	addiction.alpha=.50;
	thoughts.alpha=.50;
	
	personality.enabled=NO;
	parenting.enabled=NO;
	depression.enabled=NO;
	anxiety.enabled=NO;
	addiction.enabled=NO;
	thoughts.enabled=NO;
	
	[xmlParser release];
	[parser release];
	for(CategoryCount* catCount in appDelegate.categoryCountList){
		if ([catCount.category isEqualToString:@"ANXIETY"]) {
			anxiety.alpha=1.0;
			anxiety.enabled=YES;
		}else if ([catCount.category isEqualToString:@"PERSONALITY"]) {
			personality.alpha=1.0;
			personality.enabled=YES;
		}else if ([catCount.category isEqualToString:@"DEPRESSION"]) {
			depression.alpha=1.0;
			depression.enabled=YES;
		}else if ([catCount.category isEqualToString:@"ADDICTION"]) {
			addiction.alpha=1.0;
			addiction.enabled=YES;
		}else if ([catCount.category isEqualToString:@"THOUGHTS"]) {
			thoughts.alpha=1.0;
			thoughts.enabled=YES;
		}else if ([catCount.category isEqualToString:@"PARENTING"]) {
			parenting.alpha=1.0;
			parenting.enabled=YES;
		}
	}
	
	
	
	
	
}

- (IBAction) submitCategory:(id)sender {
	UIButton * button=(UIButton*)sender;
	NSString *category=nil;
	switch (button.tag) {
		case 1:{
			category=@"PERSONALITY";
			break;
		}
		case 2:{
			category=@"PARENTING";
			break;
		}
		case 3:{
			category=@"DEPRESSION";
			break;
		}
		case 4:{
			category=@"ANXIETY";
			break;
		}
		case 5:{
			category=@"THOUGHTS";
			break;
		}
		case 6:{
			category=@"ADDICTION";
			break;
		}	
		default:
			break;
	}
	TestDetailTableController *detailController=[[TestDetailTableController alloc]initWithNibName:@"TestDetailTableController" bundle:[NSBundle mainBundle]];
	detailController.selectedCategory=category;
	[self.rootView.navigationController pushViewController:detailController animated:YES];
	[detailController release];
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
	[parenting release];
	[depression release];
	[addiction release];
	[anxiety release];
	[thoughts release];
	[personality release];
    [super dealloc];
}


@end
