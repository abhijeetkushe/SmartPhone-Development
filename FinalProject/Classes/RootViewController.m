//
//  RootViewController.m
//  FinalProject
//
//  Created by Snow Leopard User on 14/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "FinalAction.h"
#import "LoginPage.h"
#import "AddUserController.h"

@implementation RootViewController
@synthesize options;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Home";
	if (options==nil) {
		options=[[NSMutableArray alloc] initWithObjects:
		 [FinalAction actionWithType:@"" description:@"Login" image:nil],
		 [FinalAction actionWithType:@"" description:@"Create User" image:nil],
		 [FinalAction actionWithType:@"" description:@"About Us" image:nil], nil];
		
	}
	/*
	 [FinalAction actionWithType:@"" description:@"Contact Us" image:nil],
	 [FinalAction actionWithType:@"" description:@"Feedback" image:nil],*/
	
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

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self options] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	NSInteger row = [indexPath row];
	FinalAction *act=(FinalAction*)[self.options objectAtIndex:row];
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	cell.textLabel.text = act.description;
	//cell.detailTextLabel.text =@" this a test description";
	//cell.imageView.image = [UIImage imageNamed:@"blueFlower.png"];  
	

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
    
	NSInteger section =  [indexPath section];
	NSInteger row = [indexPath row];
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	NSString *title = cell.textLabel.text;
	switch (row) {
		case 0:
			{
				LoginPage *loginPage=[[LoginPage alloc] initWithNibName:@"LoginPage" bundle:nil];
				[self.navigationController pushViewController:loginPage animated:YES];	
				[loginPage release];
				break;
			}
		case 1:
		{
			AddUserController *addUser=[[AddUserController alloc] initWithNibName:@"AddUserController" bundle:nil];
			[self.navigationController pushViewController:addUser animated:YES];	
			//UIBarButtonItem *addButton=[[UIBarButtonItem alloc]initWithTitle:@"Submit" style:UIBarButtonSystemItemDone target:addUser action:@selector(addAction:)];
			//[[addUser navigationItem]setRightBarButtonItem:addButton];
			[addUser release];
		//	[addButton release];
			break;
		}	
		default:
			break;
	}
		
}
- (void) addAction:(id) sender{
	
}	

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[options release];
}


@end

