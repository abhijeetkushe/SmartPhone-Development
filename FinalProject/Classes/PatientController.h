//
//  PatientController.h
//  FinalProject
//
//  Created by Snow Leopard User on 22/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PatientController : UITableViewController<UITableViewDelegate,UITableViewDataSource> {
	NSMutableArray *patients;
    NSMutableDictionary *sections;  
}
@property (nonatomic,retain) NSMutableArray *patients;
@property (nonatomic,retain) NSMutableDictionary *sections;
@end
