//
//  LoginPage.m
//  FinalProject
//
//  Created by Snow Leopard User on 14/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginPage.h"
#import "SegmentManagingViewController.h"
#import "FinalProjectAppDelegate.h"
#import <sqlite3.h>

@implementation LoginPage

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

-(int) validateLoginWithUserName:(NSString*) userName password:(NSString*) pwd{
	
	// Setup the database object
	sqlite3 *database;
	FinalProjectAppDelegate* appDelegate=(FinalProjectAppDelegate*) [[UIApplication sharedApplication] delegate];
	NSString* dbasePath=appDelegate.databasePath;
	
	int userID=0;
	
	// Open the database from the users filessytem
	if(sqlite3_open([dbasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select userID from userinfo WHERE upper(username)=? and upper(password)=?";
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			if((sqlite3_bind_text(compiledStatement, 1, [[userName uppercaseString] UTF8String], -1, NULL)+sqlite3_bind_text(compiledStatement, 2, [[pwd uppercaseString] UTF8String], -1, NULL))== SQLITE_OK){
				if(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
				userID=sqlite3_column_int(compiledStatement, 0);
			}	
			sqlite3_finalize(compiledStatement);
		}
	}
	sqlite3_close(database);
		
}
	return userID;
}// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	UIBarButtonItem *addButton=[[UIBarButtonItem alloc]initWithTitle:@"Submit" style:UIBarButtonSystemItemDone target:self action:@selector(submit:)];
	[[self navigationItem]setRightBarButtonItem:addButton];	
	[addButton release];
}

- (BOOL) textFieldShouldReturn: (UITextField*) textField{
	[textField resignFirstResponder];
	return YES;
}

- (void) submit:(id) sender{
	NSString* username=((UITextField*)[self.view viewWithTag:1]).text;
	NSString* password=((UITextField*)[self.view viewWithTag:2]).text;
	int userID=[self validateLoginWithUserName:username password:password];
	if (userID==0) {
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert View" message:@"No match found for username and password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.message=@"No match found for username and password";
		[alert show];
		[alert release];
	}else{	
		SegmentManagingViewController * segmentManagingViewController = [[SegmentManagingViewController alloc] init];
		segmentManagingViewController.userID=userID;
		[self.navigationController pushViewController:segmentManagingViewController animated:YES];
		[segmentManagingViewController release];
	}	
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
    [super dealloc];
}


@end
