//
//  Employee.m
//  testObjC
//
//  Created by Snow Leopard User on 02/02/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Address.h"
@implementation Address
@synthesize street,aptNum,city,stateCode,zipCode,country,addID;
- (id) initWithStreet:(NSString*)streetAddr andAptNum:(NSString*)aptNumAddr andCity:(NSString*)cityAddr andStateCode:(NSString*)stateAddr andZipCode:(NSString*)zCode andCountry:(NSString*) countryAddr
{
	self=[super init];
	if (self) {
		self.street=streetAddr;
		self.aptNum=aptNumAddr;
		self.city=cityAddr;
		self.stateCode=stateAddr;
		self.zipCode=zCode;
		self.country=countryAddr;
	}
	
	return self;
	
}


- (void) dealloc
{
	[super dealloc];	
}

- (NSString*) description
{
	NSMutableString* addrString=[[NSMutableString alloc] init];
	[addrString appendString:self.street];
	[addrString appendString:@","];
	[addrString appendString:self.aptNum];
	[addrString appendString:@"\n"];
	[addrString appendString:self.city];
	[addrString appendString:@","];
	[addrString appendString:self.stateCode];
	[addrString appendString:@","];
	[addrString appendString:self.country];
	[addrString appendFormat:@"- %@",self.zipCode];
	return [addrString autorelease];
}

- (void) encodeWithCoder:(NSCoder *) coder{	
	[coder encodeObject:self.street forKey:@"street"];
	[coder encodeObject:self.aptNum forKey:@"aptNum"];
	[coder encodeObject:self.city forKey:@"city"];
	[coder encodeObject:self.stateCode forKey:@"stateCode"];
	[coder encodeObject:self.zipCode forKey:@"zipCode"];
	[coder encodeObject:self.country forKey:@"country"];
}	

- (id) initWithCoder:(NSCoder *) aDecoder{
	NSString* sstreet=[aDecoder decodeObjectForKey:@"street"];
	NSString* aaptNum=[aDecoder decodeObjectForKey:@"aptNum"];
	NSString* ccity=[aDecoder decodeObjectForKey:@"city"];
	NSString* sstateCode=[aDecoder decodeObjectForKey:@"stateCode"];
	NSString* zzipCode=[aDecoder decodeObjectForKey:@"zipCode"];
	NSString* ccountry=[aDecoder decodeObjectForKey:@"country"];
	[self initWithStreet:sstreet andAptNum:aaptNum andCity:ccity andStateCode:sstateCode andZipCode:zzipCode andCountry:ccountry];
	return self;
}	


@end
