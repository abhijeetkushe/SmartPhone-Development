//
//  ResultsPage.h
//  XML
//
//  Created by Snow Leopard User on 27/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ResultsPage : UIViewController {
	IBOutlet UILabel *category;
	IBOutlet UILabel *testName;
	IBOutlet UILabel *testScore;
	IBOutlet UITextView *testResult;
	NSString* testN;
	NSString* testCat;
	NSInteger testS;
	NSString*  testRes;	
	NSInteger testID;
}
@property(readwrite,retain)NSString* testN;
@property(readwrite,retain)NSString* testCat;
@property(readwrite) NSInteger testS;
@property(readwrite) NSInteger testID;
@property(readwrite,retain) NSString* testRes;

@end
