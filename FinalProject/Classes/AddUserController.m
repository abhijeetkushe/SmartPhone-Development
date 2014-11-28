//
//  addEmployeeController.m
//  Assignment7
//
//  Created by Snow Leopard User on 30/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AddUserController.h"
#import "CreateAddressController.h"
#import "DatePickerController.h"
#import "CountryPicker.h"


@implementation AddUserController
@synthesize radio1,radio2;

- (BOOL) textFieldShouldReturn: (UITextField*) textField{
	[textField resignFirstResponder];
	return YES;
}	

-(IBAction) toDatePicker:(id)sender {
	/*CountryPicker *countryController = [[CountryPicker alloc] initWithNibName:@"CountryPicker" bundle:nil];
	countryController.parentView=self.view;
	[self.navigationController pushViewController:countryController animated:YES];
	[countryController release];*/
	
	DatePickerController *dateController = [[DatePickerController alloc] initWithNibName:@"DatePickerController" bundle:nil];
	dateController.parentView=self.view;
	[self.navigationController pushViewController:dateController animated:YES];
	[dateController release];
}	
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil initialText:(NSString *)txt {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
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
	[radio1 setImage:[UIImage imageNamed:@"radio_sel.jpg"] forState:UIControlStateSelected];
	[radio1 setImage:[UIImage imageNamed:@"radio_unsel.jpg"] forState:UIControlStateNormal];
	radio1.selected=NO;
	[radio1 addTarget:self action:@selector(checkboxButton:) forControlEvents:UIControlEventTouchUpInside];
	[radio2 setImage:[UIImage imageNamed:@"radio_sel.jpg"] forState:UIControlStateSelected];
	[radio2 setImage:[UIImage imageNamed:@"radio_unsel.jpg"] forState:UIControlStateNormal];
	radio2.selected=NO;
	[radio2 addTarget:self action:@selector(checkboxButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)checkboxButton:(UIButton *)button{
	if(![radio1 isEqual:button]){
		[radio1 setSelected:NO];
	}	
	if(![radio2 isEqual:button]){
		[radio2 setSelected:NO];
	}	
	if (!button.selected) {
		button.selected = YES;
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
	[radio1 release];
	[radio2 release];
    [super dealloc];
}


- (IBAction) toAddressPage:(id)sender {	
	if ([self validateFirstView]) {
		CreateAddressController *addAddrController = [[CreateAddressController alloc] initWithNibName:@"CreateAddressController" bundle:nil ];
		addAddrController.parentView=self.view;
		if (radio1.selected) {
			addAddrController.selectedRole=@"Doctor";
		}else if (radio2.selected) {
			addAddrController.selectedRole=@"Patient";
		}
		
		[self.navigationController pushViewController:addAddrController animated:YES];
		[addAddrController release];
	}	
}

-(BOOL) validateNumberAndHiphenPhone:(NSString*) text{
	NSCharacterSet *nonNumberSet=[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
	//NSCharacterSet *nonhiphenCharacter=[NSCharacterSet characterSetWithCharactersInString:@"-"];
	NSString* trimmedString=[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	if ([trimmedString rangeOfCharacterFromSet:nonNumberSet].location==NSNotFound) {
		if ([trimmedString length]!=10) {
			return NO;
		}
		return YES;
	}
	else{
		NSError* error=NULL;
		NSRegularExpression* regex=[NSRegularExpression regularExpressionWithPattern:@"\\d{3}-\\d{3}-\\d{4}" options:NSRegularExpressionCaseInsensitive error:&error];
		NSUInteger numOfMatches=[regex numberOfMatchesInString:trimmedString options:0 range:NSMakeRange(0, [trimmedString length])];
		if (numOfMatches==1) {
			if ([trimmedString length]!=12) {
				return NO;
			}
			return YES;
		}
		return NO;
	}
	
}	

-(BOOL) validateEmail:(NSString*) text{
	NSError* error=NULL;
	NSRegularExpression* regex=[NSRegularExpression regularExpressionWithPattern:@"\\w+?@\\w+?" options:NSRegularExpressionCaseInsensitive error:&error];
	NSString* trimmedString=[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSUInteger numOfMatches=[regex numberOfMatchesInString:trimmedString options:0 range:NSMakeRange(0, [trimmedString length])];
	if (numOfMatches==1) {
			return YES;
		}
	return NO;
	
}	


-(BOOL) validateUserName:(NSString*) text{
	NSCharacterSet *nonAlphaNumSet=[[NSCharacterSet alphanumericCharacterSet] invertedSet];
	NSString* trimmedString=[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	if (([trimmedString rangeOfCharacterFromSet:nonAlphaNumSet].location==NSNotFound)) {
		if ([trimmedString length]>15) {
			return NO;
		}
		return YES;
	}
	else{
		return NO;
	}
}	

-(BOOL) validatePassword:(NSString*) text{
	NSMutableCharacterSet *inValidCharSet=[[NSMutableCharacterSet alloc]init];
	
	NSCharacterSet *nonAlphaNumSet=[NSCharacterSet alphanumericCharacterSet];
	NSCharacterSet *specialCharSet=[NSCharacterSet characterSetWithCharactersInString:@"-@"];
	[inValidCharSet formUnionWithCharacterSet:nonAlphaNumSet];
	[inValidCharSet formUnionWithCharacterSet:specialCharSet];
	inValidCharSet=[inValidCharSet invertedSet];
	//NSCharacterSet *nonhiphenCharacter=[NSCharacterSet characterSetWithCharactersInString:@"-"];
	NSString* trimmedString=[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	if (([trimmedString rangeOfCharacterFromSet:inValidCharSet].location==NSNotFound)) {
		if ([trimmedString length]>9) {
			return NO;
		}
		return YES;
	}
	else{
		return NO;
	}
}	


-(BOOL) validateFirstView{
	UIView* createView=self.view;
	
	NSString* fName=((UITextField*)[createView viewWithTag:1]).text;	
	
	if (fName==nil||[fName isEqualToString:@""]) {
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert View" message:@"Please enter the First Name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.message=@"Please enter the first name";
		[alert show];
		[alert release];
		return NO;
	}
	
	NSString* lName=((UITextField*)[createView viewWithTag:2]).text;
	if (lName==nil||[lName isEqualToString:@""]) {
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert View" message:@"Please enter the Last Name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
	}
	NSString* email=((UITextField*)[createView viewWithTag:3]).text;
	if (email==nil||[email isEqualToString:@""]) {
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert View" message:@"Please enter the SSN Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
	}
	
	if (![self validateEmail:email]) {
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert View" message:@"Email: XXXXXXXX@ABC.com" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
		
	}
	
	
	NSString *dob=((UITextField*)[createView viewWithTag:4]).text;
	if (dob==nil||[dob isEqualToString:@""]) {
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert View" message:@"Please enter the Date of Birth" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
	}
	NSDateFormatter* df=[[[NSDateFormatter alloc ]init] autorelease];
	[df setDateFormat:@"MM-dd-yyyy"];
	
	NSDate* dobDate=[df dateFromString:dob];
	if (dobDate==nil) {
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert View" message:@"Please enter the Date of Birth in MM-dd-yyyy format" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
	}
	
	NSString* phoneNum=((UITextField*)[createView viewWithTag:5]).text;
	if (phoneNum==nil||[phoneNum isEqualToString:@""]) {
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert View" message:@"Please enter the Phone Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
	}
	if (![self validateNumberAndHiphenPhone:phoneNum]) {
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert View" message:@"Phone Number: XXXXXXXXXX or XXX-XXX-XXXX format" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
		
	}
	
	NSString* userName=((UITextField*)[createView viewWithTag:6]).text;
	if (userName==nil||[userName isEqualToString:@""]) {
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert View" message:@"Please enter the User Name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
	}
	
	if (![self validateUserName:userName]) {
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert View" message:@"User Name: Only Numbers and letters allowed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
		
	}
	
	NSString* password=((UITextField*)[createView viewWithTag:7]).text;
	
	if (password==nil||[password isEqualToString:@""]) {
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert View" message:@"Please enter the Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
	}
	
	if (![self validatePassword:password]) {
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert View" message:@"Password: Only Numbers and letters allowed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
		
	}
	
	if (![self validateRole]) {
		return NO;
	}
	
	return YES;
}

- (BOOL) validateRole{
	if (radio1.selected==YES) {
		return YES;
	}else if (radio2.selected==YES) {
		return YES;
	}else{
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert View" message:@"Please Select An Option" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
	}	
}

@end
