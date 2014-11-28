//
//  CreateAddressController.m
//  Assignment7
//
//  Created by Snow Leopard User on 31/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CreateAddressController.h"
#import "Employee.h"
#import "Address.h"
#import "FinalProjectAppDelegate.h"
#import "CountryPicker.h"
#import "SegmentManagingViewController.h"
#import <sqlite3.h>

@implementation CreateAddressController
@synthesize parentView,imageArray,selectedRole;
- (BOOL) textFieldShouldReturn: (UITextField*) textField{
	[textField resignFirstResponder];
	return YES;
}	

-(int) getMaxCount{
	
	// Setup the database object
	sqlite3 *database;
	FinalProjectAppDelegate* appDelegate=(FinalProjectAppDelegate*) [[UIApplication sharedApplication] delegate];
	NSString* dbasePath=appDelegate.databasePath;

	int userID=0;
	
	// Open the database from the users filessytem
	if(sqlite3_open([dbasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select max(userID) from userinfo";
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
				if(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
					userID=sqlite3_column_int(compiledStatement, 0);
				}	
				sqlite3_finalize(compiledStatement);
			}
		}
		sqlite3_close(database);
return userID;
}



-(void) saveEmployeeArray:(Employee*) employee{
	FinalProjectAppDelegate* appDelegate=(FinalProjectAppDelegate*) [[UIApplication sharedApplication] delegate];
	NSString* dbasePath=appDelegate.databasePath;
	//[appDelegate checkAndCreateDatabaseAt:dbasePath databaseName:appDelegate.databaseName];
	// Setup the database object
	sqlite3 *database;
	

	// Open the database from the users filessytem
	if(sqlite3_open([dbasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *dmlEmpStatement = "insert into userinfo(userID,username,password,firstName,lastName,email,dateOfBirth,phoneNumber,role,streetLine1,aptNumber,city,state,country,zipCode,imagePath) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

		//const char *sqlStatement = "select * from employee";
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, dmlEmpStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			int result=sqlite3_bind_int(compiledStatement, 1 , employee.empId )+
			sqlite3_bind_text(compiledStatement, 2,[employee.userName UTF8String], -1, NULL)+
			sqlite3_bind_text(compiledStatement, 3,[employee.password UTF8String], -1, NULL)+
			sqlite3_bind_text(compiledStatement, 4,[employee.firstname UTF8String], -1, NULL)+
			sqlite3_bind_text(compiledStatement, 5, [employee.lastName UTF8String], -1, NULL)+
			sqlite3_bind_text(compiledStatement, 6, [employee.email UTF8String], -1, NULL)+
			sqlite3_bind_double(compiledStatement, 7, [employee.dob timeIntervalSince1970])+
			sqlite3_bind_text(compiledStatement, 8, [employee.phoneno UTF8String], -1, NULL)+
			sqlite3_bind_text(compiledStatement, 9, [employee.role UTF8String], -1, NULL)+
			sqlite3_bind_text(compiledStatement, 10, [employee.address.street UTF8String], -1, NULL)+
			sqlite3_bind_text(compiledStatement, 11, [employee.address.aptNum UTF8String], -1, NULL)+
			sqlite3_bind_text(compiledStatement, 12, [employee.address.city UTF8String], -1, NULL)+
			sqlite3_bind_text(compiledStatement, 13, [employee.address.stateCode UTF8String], -1, NULL)+
			sqlite3_bind_text(compiledStatement, 14, [employee.address.country UTF8String], -1, NULL)+
			sqlite3_bind_text(compiledStatement, 15, [employee.address.zipCode UTF8String], -1, NULL)+
			sqlite3_bind_text(compiledStatement, 16, [employee.imagePath UTF8String], -1, NULL);
			if(result == SQLITE_OK) {
				sqlite3_step(compiledStatement);
				sqlite3_reset(compiledStatement);
			}
			sqlite3_finalize(compiledStatement);
		}
		
	}
sqlite3_close(database);

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.imageArray=[[NSMutableArray alloc]initWithObjects:@"personal.jpg",@"Anushka_Sharma_300.jpg",@"employee-engagement.jpg",nil];
	
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
	[imageArray release];
	[selectedRole release];
}

-(IBAction) toCountryPicker:(id)sender {
	CountryPicker *countryController = [[CountryPicker alloc] initWithNibName:@"CountryPicker" bundle:nil];
	countryController.parentView=self.view;
	[self.navigationController pushViewController:countryController animated:YES];
	[countryController release];
}

-(BOOL) validateUSZipCode:(NSString*) text{
	NSCharacterSet *nonNumberSet=[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
	NSString* trimmedString=[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	if ([trimmedString rangeOfCharacterFromSet:nonNumberSet].location==NSNotFound) {
		if ([trimmedString length]!=5) {
			return NO;
		}
		return YES;
	}else {		
		return NO;
	}

		
}	

- (IBAction) submitEmployee:(id)sender {
	UIView* createView=self.parentView;
	UIView* addrView=self.view;
	NSString* fName=((UITextField*)[createView viewWithTag:1]).text;	
	NSString* lName=((UITextField*)[createView viewWithTag:2]).text;
	NSString* email=((UITextField*)[createView viewWithTag:3]).text;
	((UITextField*)[createView viewWithTag:1]).text=@"";
	((UITextField*)[createView viewWithTag:2]).text=@"";
	((UITextField*)[createView viewWithTag:3]).text=@"";
	
	NSDateFormatter* df=[[NSDateFormatter alloc ]init];
	[df setDateFormat:@"MM-dd-yyyy"];
	NSDate* dobDate=[df dateFromString:((UITextField*)[createView viewWithTag:4]).text];
	[df release];
	
	((UITextField*)[createView viewWithTag:4]).text=@"";
	NSString* phoneNum=((UITextField*)[createView viewWithTag:5]).text;
	NSString* userName=((UITextField*)[createView viewWithTag:6]).text;
	NSString* password=((UITextField*)[createView viewWithTag:7]).text;
	
	
	((UITextField*)[createView viewWithTag:5]).text=@"";
	((UITextField*)[createView viewWithTag:6]).text=@"";
	((UITextField*)[createView viewWithTag:7]).text=@"";
	
	UIButton* radio1=(UIButton*)[createView viewWithTag:8];
	UIButton* radio2=(UIButton*)[createView viewWithTag:9];
	
	
	Employee* employee=[[[Employee alloc] initWithLast:lName andFirst:fName andEmail:email andDob:dobDate] autorelease];
	employee.phoneno=phoneNum;
	employee.userName=userName;
	employee.password=password;
	employee.role=selectedRole;
	
	if ([self validateAddrView]) {
		
		NSString* streetNameS=((UITextField*)[addrView viewWithTag:1]).text;	
		NSString* aptNumStr=((UITextField*)[addrView viewWithTag:2]).text;
		NSString* cityStr=((UITextField*)[addrView viewWithTag:3]).text;
		NSString* stateStr=((UITextField*)[addrView viewWithTag:4]).text;
		NSString* zipStr=((UITextField*)[addrView viewWithTag:6]).text;
		NSString* countryStr=((UITextField*)[addrView viewWithTag:5]).text;
		
		((UITextField*)[addrView viewWithTag:1]).text=@"";
		((UITextField*)[addrView viewWithTag:2]).text=@"";
		((UITextField*)[addrView viewWithTag:3]).text=@"";
		((UITextField*)[addrView viewWithTag:4]).text=@"";
		((UITextField*)[addrView viewWithTag:5]).text=@"";
		((UITextField*)[addrView viewWithTag:6]).text=@"";
		
		Address* address=[[[Address alloc] initWithStreet:streetNameS andAptNum:aptNumStr andCity:cityStr andStateCode:stateStr andZipCode:zipStr andCountry:countryStr] autorelease];
		employee.address=address;
		int count=[self getMaxCount];
		employee.imagePath=[self.imageArray objectAtIndex:(count%[self.imageArray count])];
		employee.empId=++count;
		address.addID=1;
		[self saveEmployeeArray:employee];
		SegmentManagingViewController * segmentManagingViewController = [[SegmentManagingViewController alloc] init];
		segmentManagingViewController.userID=employee.empId;
		[self.navigationController pushViewController:segmentManagingViewController animated:YES];
		[segmentManagingViewController release];
	}
}


-(BOOL) validateAddrView{
	UIView* addrView=self.view;
	NSString* streetNameS=((UITextField*)[addrView viewWithTag:1]).text;	
	NSString* aptNumStr=((UITextField*)[addrView viewWithTag:2]).text;
	NSString* cityStr=((UITextField*)[addrView viewWithTag:3]).text;
	NSString* stateStr=((UITextField*)[addrView viewWithTag:4]).text;
	NSString* zipStr=((UITextField*)[addrView viewWithTag:6]).text;
	NSString* countryStr=((UITextField*)[addrView viewWithTag:5]).text;
	
	
	if (streetNameS==nil||[streetNameS isEqualToString:@""]) {
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert View" message:@"Please enter the Street Number and NAme" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
	}
	
	if (aptNumStr==nil||[aptNumStr isEqualToString:@""]) {
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert View" message:@"Please enter the Apartment Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
	}
	
	if (cityStr==nil||[cityStr isEqualToString:@""]) {
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert View" message:@"Please enter the City" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
	}
	
	
	if (stateStr==nil||[stateStr isEqualToString:@""]) {
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert View" message:@"Please enter the State" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
	}
	
	if (zipStr==nil||[zipStr isEqualToString:@""]) {
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert View" message:@"Please enter the Zip Code" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
	}
	
	if (![self validateUSZipCode:zipStr]) {
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert View" message:@"Zip Code-XXXXX" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
	}
	
	if (countryStr==nil||[countryStr isEqualToString:@""]) {
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert View" message:@"Please enter the Country" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
	}
	return YES;
}


@end
