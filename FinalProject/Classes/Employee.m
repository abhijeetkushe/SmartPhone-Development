//
//  Employee.m
//  testObjC
//
//  Created by Snow Leopard User on 02/02/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Employee.h"
#import "Address.h"
@implementation Employee
@synthesize firstname,lastName,email,dob,phoneno,address,userName,imagePath,empId,password,role;
- (id) initWithLast:(NSString*)lName andFirst:(NSString*)fname andEmail:(NSString*)emailID andDob:(NSDate*)dateOfBirth
{
	self=[super init];
	if (self) {
		self.firstname=fname;
		self.email=emailID;
		self.lastName=lName;
		self.dob=dateOfBirth;
	}
	
	return self;
	
}

- (NSString*) description
{
	NSMutableString* empString=[[NSMutableString alloc] init];
	[empString appendString:self.firstname];
	[empString appendString:@" "];
	[empString appendString:self.lastName];
	[empString appendFormat:@"\nEmail ID :%@",self.email];
	[empString appendFormat:@"\nPhone Number :%@",self.phoneno];
  	NSDateFormatter* ndf=[[NSDateFormatter alloc] init];	
	[ndf setDateFormat:@"MM-dd-yyyy"];
	[empString appendFormat:@"\nDate of Birth :%@",[ndf stringFromDate:self.dob]];
	[empString appendString:@"\nAddress :"];
	[empString appendString:[self.address description]];
	[ndf release];
	return [empString autorelease];
}

- (void) print
{
	NSLog(@"Hello,");
	NSLog(@"%@ %@",firstname,lastName);
}

- (void) encodeWithCoder:(NSCoder *) coder{
	
	[coder encodeObject:self.firstname forKey:@"firstName"];
	[coder encodeObject:self.lastName forKey:@"lastName"];
	[coder encodeObject:self.email forKey:@"email"];
	[coder encodeObject:self.dob forKey:@"dob"];
	[coder encodeObject:self.phoneno forKey:@"phoneno"];
	[coder encodeObject:self.address forKey:@"address"];
	[coder encodeObject:self.userName forKey:@""];
	[coder encodeObject:self.password forKey:@"password"];
	[coder encodeObject:self.password forKey:@"role"];
	[coder encodeObject:self.imagePath forKey:@"imagePath"];
	[coder encodeObject:self.empId forKey:@"empId"];
}	

- (id) initWithCoder:(NSCoder *) aDecoder{
	NSString* fName=[aDecoder decodeObjectForKey:@"firstName"];
	NSString* lName=[aDecoder decodeObjectForKey:@"lastuserNameName"];
	NSString* emailID=[aDecoder decodeObjectForKey:@"email"];
	NSDate* dateOfBirth=[aDecoder decodeObjectForKey:@"dob"];
	NSString* phoneNum=[aDecoder decodeObjectForKey:@"phoneno"];
	Address* addr=[aDecoder decodeObjectForKey:@"address"];
    NSString* uName=[aDecoder decodeObjectForKey:@"userName"];
	NSString* image=[aDecoder decodeObjectForKey:@"imagePath"];
	NSInteger empID=[aDecoder decodeObjectForKey:@"empId"];
	[self initWithLast:lName andFirst:fName andEmail:emailID andDob:dateOfBirth];
	self.phoneno=phoneNum;
	self.address=addr;
	self.userName=uName;	
	self.imagePath=image;
	self.empId=empID;
	return self;
}	
- (void) dealloc
{
	[super dealloc];
	
}

@end
