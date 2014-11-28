//
//  TestDetail.m
//  XML
//
//  Created by Snow Leopard User on 27/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TestDetail.h"
#import "FinalProjectAppDelegate.h"
#import "Test1.h"
#import "Question.h"
#import "TestResult.h"
#import "ResultsPage.h"
#import "ScoreValue.h"


@implementation TestDetail
@synthesize selectedTestIndex,pageIndex,testResults;
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
	FinalProjectAppDelegate *appDelegate = (FinalProjectAppDelegate *)[[UIApplication sharedApplication] delegate];

	selectedTest=[appDelegate.testList objectAtIndex:selectedTestIndex];
	questionItem=[selectedTest.questionList objectAtIndex:pageIndex];
	questionIndex.text=[NSString stringWithFormat:@"%d",(pageIndex+1)];
	question.text=questionItem.question;
	option1.text=questionItem.option1;
	option2.text=questionItem.option2;
	option3.text=questionItem.option3;
	option4.text=questionItem.option4;
	
	[radio1 setImage:[UIImage imageNamed:@"radio_sel.jpg"] forState:UIControlStateSelected];
	[radio1 setImage:[UIImage imageNamed:@"radio_unsel.jpg"] forState:UIControlStateNormal];
	radio1.selected=NO;
	[radio2 setImage:[UIImage imageNamed:@"radio_sel.jpg"] forState:UIControlStateSelected];
	[radio2 setImage:[UIImage imageNamed:@"radio_unsel.jpg"] forState:UIControlStateNormal];
	radio2.selected=NO;
	[radio3 setImage:[UIImage imageNamed:@"radio_sel.jpg"] forState:UIControlStateSelected];
	[radio3 setImage:[UIImage imageNamed:@"radio_unsel.jpg"] forState:UIControlStateNormal];
	radio3.selected=NO;
	[radio4 setImage:[UIImage imageNamed:@"radio_sel.jpg"] forState:UIControlStateSelected];
	[radio4 setImage:[UIImage imageNamed:@"radio_unsel.jpg"] forState:UIControlStateNormal];
	radio4.selected=NO;
	[radio1 addTarget:self action:@selector(checkboxButton:) forControlEvents:UIControlEventTouchUpInside];
	[radio2 addTarget:self action:@selector(checkboxButton:) forControlEvents:UIControlEventTouchUpInside];
	[radio3 addTarget:self action:@selector(checkboxButton:) forControlEvents:UIControlEventTouchUpInside];
	[radio4 addTarget:self action:@selector(checkboxButton:) forControlEvents:UIControlEventTouchUpInside];
	double progressvalue=(1.0/([selectedTest.questionList count]))*pageIndex;
	progressView.progress=progressvalue;
	UIBarButtonItem *addButton=[[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonSystemItemDone target:self action:@selector(nextPage:)];
	[[self navigationItem] setRightBarButtonItem:addButton];
	[addButton release];
	
	
}

- (void) nextPage:(id)sender{
	if ([self validate]) {
		TestResult *result=[[TestResult alloc]init];
		result.question=(pageIndex+1);
		result.selectedOption=[self getAnswerSelected];
		BOOL replaced=NO;
		for(int i=0;i<[testResults count] ;i++){
			TestResult* temp=[testResults objectAtIndex:i];
			int tempq=temp.question;
			int resq=result.question;
			if (tempq==resq) {
				[testResults replaceObjectAtIndex:i withObject:result];
				replaced=YES;
				break;				
			}			
		}if (!replaced) {
			[testResults addObject:result];
		}		
		[result release];
		pageIndex++;
		if (pageIndex<[selectedTest.questionList count]) {
			[self viewDidLoad];
		}else {
			NSInteger score=[self getScore:testResults];
			NSString* res=[self findOuput:score];
			ResultsPage *rsPage=[[ResultsPage alloc] initWithNibName:@"ResultsPage" bundle:[NSBundle mainBundle]];
			rsPage.testRes=res;
			rsPage.testS=score;
			rsPage.testCat=selectedTest.testCategory;
			rsPage.testN=selectedTest.testName;
			rsPage.testID=selectedTest.testID;
			[self.navigationController pushViewController:rsPage animated:YES];
			[rsPage release];
			
		}
			
	}
	
}	

-(NSString*) findOuput:(NSInteger) score {
	NSMutableArray* resultLi=selectedTest.resultList;
	[resultLi sortUsingSelector:@selector(compare:)];
	for(int i=0;i<[resultLi count] ;i++){
		ScoreValue* scoreValue=[resultLi objectAtIndex:i];
		if (score<=scoreValue.score) {
			return scoreValue.result;
		}
	}	
	return @"Not Defined:Contact Doctor";;
}	

-(NSInteger) getAnswerSelected{
	if (radio1.selected==YES) {
		return 1;
	}else if (radio2.selected==YES) {
		return 2;
	}else if (radio3.selected==YES) {
		return 3;
	}else if(radio4.selected==YES){
		return 4;
	}else {
		return -1;
	}


}	

-(NSInteger) getScore:(NSMutableArray*) testRes{
	NSInteger score=0;
	for(int i=0;i<[testRes count] ;i++){
		TestResult* temp=[testRes objectAtIndex:i];
		int q=temp.question;
		Question* ques=[selectedTest.questionList objectAtIndex:(q-1)]; 	
		if (temp.selectedOption==1) {
			score+=ques.score1;
		}else if (temp.selectedOption==2) {
			score+=ques.score2;
		}else if (temp.selectedOption==3) {
			score+=ques.score3;
		}else {
			score+=ques.score4;

		}

	}
	return score;
}	

- (BOOL) validate{
	if (radio1.selected==YES) {
		return YES;
	}else if (radio2.selected==YES) {
		return YES;
	}else if (radio3.selected==YES) {
		return YES;
	}else if(radio4.selected==YES){
		return YES;
	}else{
		UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Alert View" message:@"Please Select An Option" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
	}	
}	
- (IBAction)checkboxButton:(UIButton *)button{
	if(![radio1 isEqual:button]){
		[radio1 setSelected:NO];
	}	
	if(![radio2 isEqual:button]){
		[radio2 setSelected:NO];
	}	
	if(![radio3 isEqual:button]){
		[radio3 setSelected:NO];
	}	
	if(![radio4 isEqual:button]){
		[radio4 setSelected:NO];
	}	
	if (!button.selected) {
		button.selected = !button.selected;
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
	[testResults release];
}


@end
