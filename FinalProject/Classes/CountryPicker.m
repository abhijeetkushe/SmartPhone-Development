//
//  CountryPicker.m
//  FinalProject
//
//  Created by Snow Leopard User on 15/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CountryPicker.h"


@implementation CountryPicker
@synthesize parentView,selectedValue,countryList;
-(IBAction) selectCountry:(id)sender {
	((UITextField*)[self.parentView viewWithTag:5]).text=self.selectedValue;
	[self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}	

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	NSInteger co=[self.countryList count];
	return  co;
}	

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	/*NSString* val=(NSString*)[self.countryList objectAtIndex:row];
	NSLocale* loc=[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ;
	//NSLocale* loc=[[NSLocale alloc] initWithLocaleIdentifier:val];
	//NSString* countryCode=[loc objectForKey:NSLocaleCountryCode]; 
	NSString* countryName=[loc displayNameForKey:NSLocaleCountryCode value:val];
	[loc release];*/
	NSString* countryName=[self.countryList objectAtIndex:row];
	return countryName;
	
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	/*NSString* val=(NSString*)[self.countryList objectAtIndex:row];
	NSLocale* loc=[[NSLocale alloc] initWithLocaleIdentifier:val];
	NSString* countryCode=[loc objectForKey:NSLocaleCountryCode]; 
	NSString* countryName=[loc displayNameForKey:NSLocaleCountryCode value:countryCode];
	[loc release];*/
	NSString* countryName=[self.countryList objectAtIndex:row];
	self.selectedValue=countryName;
}	
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.countryList=[[NSMutableArray alloc]init];
		NSArray* countryCodes=[NSLocale ISOCountryCodes];
		for (int i=0; i<countryCodes.count; i++) {
			NSString* code=[countryCodes objectAtIndex:i];
			NSLocale* loc=[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ;
			NSString* countryName=[loc displayNameForKey:NSLocaleCountryCode value:code];
			[loc release];
			[self.countryList addObject:countryName];			
		}
		[self.countryList sortUsingSelector:@selector(compare:)];
		
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
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
	[selectedValue release];
	[countryList release];
	[parentView release];
}


@end
