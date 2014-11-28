//
//  PatientController.m
//  FinalProject
//
//  Created by Snow Leopard User on 22/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PatientController.h"
#import "Employee.h"
#import <sqlite3.h>
#import "FinalProjectAppDelegate.h"

@implementation PatientController
@synthesize patients,sections;

#pragma mark -
#pragma mark View lifecycle

-(void) getEmployeeDetails{
	sqlite3 *database;
	patients=[[NSMutableArray alloc]init];
	// Setup the database objectsqlite3 *database;
	FinalProjectAppDelegate* appDelegate=(FinalProjectAppDelegate*) [[UIApplication sharedApplication] delegate];
	NSString* dbasePath=appDelegate.databasePath;
	
	// Open the database from the users filessytem
	if(sqlite3_open([dbasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select userID,username,password,firstName,lastName,email,dateOfBirth,phoneNumber,role,streetLine1,aptNumber,city,state,country,zipCode,imagePath from userinfo WHERE role=?";
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			if(sqlite3_bind_text(compiledStatement, 1, [@"Patient" UTF8String],-1,NULL)== SQLITE_OK){
				while(sqlite3_step(compiledStatement) == SQLITE_ROW) { 
					int userID=sqlite3_column_int(compiledStatement, 0);
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
					Employee* emp=[[Employee alloc]initWithLast:lName andFirst:fName andEmail:email andDob:dob];
					emp.userName=uName;
					emp.password=pwd;
					emp.phoneno=phoneNum;
					emp.role=role;
					Address* address=[[[Address alloc] initWithStreet:streetLine1 andAptNum:aptNumber andCity:city andStateCode:state andZipCode:zipCode andCountry:country] autorelease];
					emp.address=address;
					emp.imagePath=imagePath;
					[patients addObject:emp];
					
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
	/*self.patients = [NSArray arrayWithObjects:[[Employee alloc]initWithLast:@"Kushe" andFirst:@"Abhijeet" andEmail:nil andDob:nil],
				  [[Employee alloc]initWithLast:@"Dave" andFirst:@"Mitesh" andEmail:nil andDob:nil],
				  [[Employee alloc]initWithLast:@"Kapoor" andFirst:@"Kareena" andEmail:nil andDob:nil],nil];*/
    self.sections = [[NSMutableDictionary alloc] init];
    
    BOOL found;
    
    // Loop through the patients and create our keys
    for (Employee *patient in self.patients)
    {        
        NSString *c = [patient.lastName substringToIndex:1];
        
        found = NO;
        
        for (NSString *str in [self.sections allKeys])
        {
            if ([str isEqualToString:c])
            {
                found = YES;
            }
        }
        
        if (!found)
        {     
            [self.sections setValue:[[NSMutableArray alloc] init] forKey:c];
        }
    }
	
    // Loop again and sort the books into their respective keys
    for (Employee *patient in self.patients)
    {
        [[self.sections objectForKey:[patient.lastName substringToIndex:1]] addObject:patient];
    }    
    
    // Sort each section array
    for (NSString *key in [self.sections allKeys])
    {
        [[self.sections objectForKey:key] sortUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES]]];
    }    
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.sections allKeys] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{    
    return [[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    Employee *emp = [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
	NSMutableString* temp=[[NSMutableString alloc]init];
	[temp appendString:emp.lastName ];
	[temp appendString:@", "];
	 [temp appendString:emp.firstname];
    cell.textLabel.text = [temp description];

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[patients release];
	[sections release];
}


@end

