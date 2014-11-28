//
//  TestDetail.h
//  XML
//
//  Created by Snow Leopard User on 27/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Test1,Question;
@interface TestDetail : UIViewController {
	IBOutlet UILabel *questionIndex;
	IBOutlet UITextView *question;
	IBOutlet UITextView *option1;
	IBOutlet UITextView *option2;
	IBOutlet UITextView *option3;
	IBOutlet UITextView *option4;
	IBOutlet UIButton *radio1;
	IBOutlet UIButton *radio2;
	IBOutlet UIButton *radio3;
	IBOutlet UIButton *radio4;
	IBOutlet UIProgressView *progressView;
	NSInteger selectedTestIndex;
	NSInteger pageIndex;
	Test1 *selectedTest;
	Question *questionItem;
	NSMutableArray* testResults;
	
}

@property(nonatomic,readwrite) NSInteger selectedTestIndex;
@property(nonatomic,readwrite) NSInteger pageIndex;
@property(nonatomic,readwrite,retain) NSMutableArray* testResults;

- (IBAction)checkboxButton:(UIButton *)button;
@end
