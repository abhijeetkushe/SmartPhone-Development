//
//  TestDetailTableController.m
//  XML
//
//  Created by Snow Leopard User on 27/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TestDetailTableController.h"
#import "XMLTestParser.h"
#import "Test1.h"
#import "FinalProjectAppDelegate.h"
#import "TestDetail.h"

@implementation TestDetailTableController
@synthesize selectedCategory,categoryTests;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	self.title=self.selectedCategory;
	NSMutableString* urlString=[[NSMutableString alloc]init];
	[urlString appendString:@"http://192.168.247.1:8080/SpringMVCFinal/smartphone/upload/test/"];
	[urlString appendString:self.selectedCategory]; 
	NSURL *url = [[NSURL alloc] initWithString:urlString];
	[urlString release];
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
	appDelegate = (FinalProjectAppDelegate *)[[UIApplication sharedApplication] delegate];
	
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
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [appDelegate.testList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*) indexPath {
    
    static NSString *CellIdentifier = @"Cell";        
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
	Test1 *test=[appDelegate.testList objectAtIndex:[indexPath row]];
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	cell.textLabel.text = test.testName;
	NSMutableString* temp=[[NSMutableString alloc]init];
	[temp appendFormat:@"%d",[test.questionList count]];
	[temp appendString:@" "];
	[temp appendString:@"Q(s) Time:"];
	[temp appendFormat:@"%.1f",([test.questionList count]/2.0)];
	[temp appendString:@"mins"];
	cell.detailTextLabel.text=[temp description];
	[temp release];
    // Configure the cell...
    
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
	TestDetail *testDetail=[[TestDetail alloc] initWithNibName:@"TestDetail" bundle:[NSBundle mainBundle]];
	NSInteger rowNum=indexPath.row;
	testDetail.selectedTestIndex=rowNum;
	testDetail.pageIndex=0;
	testDetail.testResults=[[[NSMutableArray alloc]init] autorelease];
	[self.navigationController pushViewController:testDetail animated:YES];
	[testDetail release];
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
}


@end

