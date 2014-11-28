//
//  Address.h
//  Assignment3
//
//  Created by Snow Leopard User on 09/02/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//


@interface Address : NSObject <NSCoding> {
	NSString* street;
	NSString* aptNum;
	NSString* city;
	NSString* stateCode;
	NSString* zipCode;
	NSString* country;
	NSInteger addID;
	
}
@property(readwrite,nonatomic,retain) NSString* street;
@property(readwrite,nonatomic,retain) NSString* aptNum;
@property(readwrite,nonatomic,retain) NSString* city;
@property(readwrite,nonatomic,retain) NSString* stateCode;
@property(readwrite,nonatomic,retain) NSString* zipCode;
@property(readwrite,nonatomic,retain) NSString* country;
@property(readwrite,nonatomic) NSInteger addID;

- (id) initWithStreet:(NSString*)streetAddr andAptNum:(NSString*)aptNumAddr andCity:(NSString*)cityAddr andStateCode:(NSString*)stateAddr andZipCode:(NSString*)zCode andCountry:(NSString*) countryAddr;

@end