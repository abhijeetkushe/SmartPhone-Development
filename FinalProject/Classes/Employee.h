//
//  Employee.h
//  testObjC
//
//  Created by Snow Leopard User on 02/02/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//


@class Address;
@interface Employee:NSObject <NSCoding>
{
	NSInteger empId;
	NSString* firstname;
	NSString* lastName;
	NSString* email;
	NSDate* dob;
	NSString* phoneno;
	Address* address;
	NSString* imagePath;
	NSString* userName;
	NSString* password;
	NSString* role;
	
}

@property (readwrite,nonatomic,retain) NSString* firstname;
@property (readwrite,nonatomic,retain) NSString* lastName;
@property (readwrite,nonatomic,retain) NSString* email;
@property (readwrite,nonatomic,retain) NSDate* dob;
@property (readwrite,nonatomic,retain) NSString* phoneno;
@property (readwrite,nonatomic,retain) Address* address;
@property (readwrite,nonatomic,retain) NSString* imagePath;
@property (readwrite,nonatomic) NSInteger empId;
@property (readwrite,nonatomic,retain) NSString* userName;
@property (readwrite,nonatomic,retain) NSString* password;
@property (readwrite,nonatomic,retain) NSString* role;

- (id) initWithLast:(NSString*)lName andFirst:(NSString*)fname andEmail:(NSString*)email andDob:(NSDate*)dateOfBirth;
- (void) print;

@end
