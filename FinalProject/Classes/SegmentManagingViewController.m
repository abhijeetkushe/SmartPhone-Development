    //
//  SegmentManagingViewController.m
//  SegmentedControlExample
//
//  Created by Marcus Crafter on 24/05/10.
//  Copyright 2010 Red Artisan. All rights reserved.
//

#import "SegmentManagingViewController.h"
#import "LoginPage.h"
#import "PatientController.h"
#import "FinalProjectAppDelegate.h"
#import <sqlite3.h>
#import "Employee.h"
#import "AddUserController.h"
#import "Address.h"
#import "PersonalProfile.h"
#import "AddressProfile.h"
#import "TestController.h"
//#import "AustraliaViewControllerNew.h"

@interface SegmentManagingViewController ()

@property (nonatomic, retain, readwrite) IBOutlet UISegmentedControl * segmentedControl;
@property (nonatomic, retain, readwrite) UIViewController            * activeViewController;
@property (nonatomic, retain, readwrite) NSArray                     * segmentedViewControllers;

- (void)didChangeSegmentControl:(UISegmentedControl *)control;
- (NSArray *)segmentedViewControllerContent;

@end

@implementation SegmentManagingViewController

@synthesize segmentedControl, activeViewController, segmentedViewControllers,userID;


-(void) getEmployeeDetails{
	
	// Setup the database object
	sqlite3 *database;
	FinalProjectAppDelegate* appDelegate=(FinalProjectAppDelegate*) [[UIApplication sharedApplication] delegate];
	NSString* dbasePath=appDelegate.databasePath;
		
	// Open the database from the users filessytem
	if(sqlite3_open([dbasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select userID,username,password,firstName,lastName,email,dateOfBirth,phoneNumber,role,streetLine1,aptNumber,city,state,country,zipCode,imagePath from userinfo WHERE userID=?";
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			if(sqlite3_bind_int(compiledStatement, 1, userID)== SQLITE_OK){
				if(sqlite3_step(compiledStatement) == SQLITE_ROW) {
					userID=sqlite3_column_int(compiledStatement, 0);
					NSString *uName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
					NSString *pwd = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
					NSString *fName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
					NSString *lName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
					NSString *email = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];					
					NSDate *dob=[NSDate dateWithTimeIntervalSinceNow: sqlite3_column_double(compiledStatement, 6)];
					NSString *phoneNum = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)];
					NSString *role = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 8)];					
					NSString *streetLine1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 9)];
					NSString *aptNumber = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 10)];
					NSString *city = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 11)];
					NSString *state = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 12)];
					NSString *country = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 13)];
					NSString *zipCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 14)];
					NSString *imagePath = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 15)];
					emp=[[Employee alloc]initWithLast:lName andFirst:fName andEmail:email andDob:dob];
					emp.userName=uName;
					emp.password=pwd;
					emp.phoneno=phoneNum;
					emp.role=role;
					Address* address=[[[Address alloc] initWithStreet:streetLine1 andAptNum:aptNumber andCity:city andStateCode:state andZipCode:zipCode andCountry:country] autorelease];
					emp.address=address;
					emp.imagePath=imagePath;
					
				}	
				sqlite3_finalize(compiledStatement);
			}
		}
		sqlite3_close(database);
		
	}
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self getEmployeeDetails];
    self.segmentedViewControllers = [self segmentedViewControllerContent];
	
    NSArray * segmentTitles = nil;
	if ([emp.role isEqual:@"Doctor"]) {
		segmentTitles=[NSArray arrayWithObjects:@"Personal",@"Address",@"Patients",nil];
	}else {
		segmentTitles=[NSArray arrayWithObjects:@"Personal",@"Address",@"Tests",nil];
	}

	
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentTitles];
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    [self.segmentedControl addTarget:self
                              action:@selector(didChangeSegmentControl:)
                    forControlEvents:UIControlEventValueChanged];

    self.navigationItem.titleView = self.segmentedControl;
    [self.segmentedControl release];
    [self didChangeSegmentControl:self.segmentedControl]; // kick everything off
}



- (NSArray *)segmentedViewControllerContent {

    UIViewController * controller1 = [[PersonalProfile alloc] initWithNibName:nil bundle:nil];
	((PersonalProfile*)controller1).emp=emp;
	UIViewController * controller2 = [[AddressProfile alloc]  initWithNibName:nil bundle:nil];
	((PersonalProfile*)controller2).emp=emp;
	UIViewController * controller3=nil;
	if ([emp.role isEqual:@"Doctor"]) {
		controller3=[[PatientController alloc]  initWithNibName:nil bundle:nil];
	}else {
		controller3=[[TestController alloc]  initWithNibName:nil bundle:nil];
		((TestController*)controller3).rootView=self;
	}



	  //  UIViewController * controller2 = [[AustraliaViewControllerNew alloc] initWithParentViewController:self];
	//UIViewController * controller3 = [[AustraliaDetailViewController alloc] initWithNibName:nil bundle:nil];
			  
	NSArray * controllers = [NSArray arrayWithObjects:controller1, controller2,controller3, nil];

    [controller1 release];
    [controller2 release];
	[controller3 release];

    return controllers;
}

#pragma mark -
#pragma mark Segment control

- (void)didChangeSegmentControl:(UISegmentedControl *)control {
    if (self.activeViewController) {
        [self.activeViewController viewWillDisappear:NO];
        [self.activeViewController.view removeFromSuperview];
        [self.activeViewController viewDidDisappear:NO];
    }

    self.activeViewController = [self.segmentedViewControllers objectAtIndex:control.selectedSegmentIndex];

    [self.activeViewController viewWillAppear:NO];
    [self.view addSubview:self.activeViewController.view];
    [self.activeViewController viewDidAppear:NO];

    NSString * segmentTitle = [control titleForSegmentAtIndex:control.selectedSegmentIndex];
    self.navigationItem.backBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:segmentTitle style:UIBarButtonItemStylePlain target:nil action:nil];
}

#pragma mark -
#pragma mark View life cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.activeViewController viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.activeViewController viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.activeViewController viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.activeViewController viewDidDisappear:animated];
}

#pragma mark -
#pragma mark UINavigationControllerDelegate control

// Required to ensure we call viewDidAppear/viewWillAppear on ourselves (and the active view controller)
// inside of a navigation stack, since viewDidAppear/willAppear insn't invoked automatically. Without this
// selected table views don't know when to de-highlight the selected row.

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [viewController viewDidAppear:animated];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [viewController viewWillAppear:animated];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    for (UIViewController * viewController in self.segmentedViewControllers) {
        [viewController didReceiveMemoryWarning];
    }
}
- (void) dealloc
{
	[super dealloc];
	[emp release];
}

- (void)viewDidUnload {
    self.segmentedControl         = nil;
    self.segmentedViewControllers = nil;
    self.activeViewController     = nil;

    [super viewDidUnload];
}

@end
