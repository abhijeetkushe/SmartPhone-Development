//
//  FinalProjectAppDelegate.h
//  FinalProject
//
//  Created by Snow Leopard User on 14/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinalProjectAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	NSString* databasePath;
	NSString* databaseName;
	NSMutableArray *testList;
	NSMutableArray *categoryCountList;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic,retain) NSString* databasePath;
@property (nonatomic,retain) NSString* databaseName;
@property (nonatomic, retain,readwrite) NSMutableArray *testList;
@property (nonatomic, retain) NSMutableArray *categoryCountList;
-(void) checkAndCreateDatabaseAt:(NSString*)dbasePath databaseName:(NSString*)dbName;

@end

