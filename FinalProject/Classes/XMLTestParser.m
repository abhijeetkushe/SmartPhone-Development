//
//  XMLTestParser.m
//  XML
//
//  Created by Snow Leopard User on 26/04/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "XMLTestParser.h"
#import "FinalProjectAppDelegate.h"
#import "Test1.h"
#import "Question.h"
#import "ScoreValue.h"
#import "CategoryCount.h"
@implementation XMLTestParser

- (XMLTestParser *) initXMLParser {
	
	[super init];
	
	appDelegate = (FinalProjectAppDelegate *)[[UIApplication sharedApplication] delegate];
	parentElementArray=[[NSMutableArray alloc] init];
	
	return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName 
	attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:@"SmartPhoneResponse"]) {
		return;
	}
	if([elementName isEqualToString:@"testList"]) {
		//Initialize the array.
		appDelegate.testList = [[NSMutableArray alloc] init];
	}
	else if([elementName isEqualToString:@"test"]) {
		test = [[Test1 alloc] init];
		[parentElementArray addObject:@"test"];
	}else if ([elementName isEqualToString:@"questionList"]) {
		test.questionList=[[NSMutableArray alloc] init];
	}else if ([elementName isEqualToString:@"testquestion"]) {
		question=[[Question alloc]init];
		[parentElementArray addObject:@"testquestion"]; 
	}else if ([elementName isEqualToString:@"resultList"]) {
		test.resultList=[[NSMutableArray alloc] init];
	}else if ([elementName isEqualToString:@"resultScore"]) {
		scoreVal=[[ScoreValue alloc]init];
		[parentElementArray addObject:@"scoreVal"]; 
	}else if([elementName isEqualToString:@"categoryCountList"]) {
		//Initialize the array.
		appDelegate.categoryCountList = [[NSMutableArray alloc] init];
	}else if ([elementName isEqualToString:@"categoryCount"]) {
		categoryCount=[[CategoryCount alloc]init];
		[parentElementArray addObject:@"categoryCount"]; 
	}
	
	NSLog(@"Processing Element: %@", elementName);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string { 
	
	if(!currentElementValue) 
		currentElementValue = [[NSMutableString alloc] initWithString:string];
	else
		[currentElementValue appendString:string];
	
	NSLog(@"Processing Value: %@", currentElementValue);
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:@"SmartPhoneResponse"]) {
		return;
	}else if([elementName isEqualToString:@"testList"]){
		return;
	}else if([elementName isEqualToString:@"test"]) {
		[appDelegate.testList addObject:test];	
		[parentElementArray removeLastObject];
		[test release];
		test = nil;
	}else if ([elementName isEqualToString:@"questionList"]) {
		return;
	}else if ([elementName isEqualToString:@"testquestion"]) {
		[test.questionList addObject:question];
		[parentElementArray removeLastObject];
		[question release];
		question=nil;
	}else if ([elementName isEqualToString:@"resultList"]) {
		return;
	}else if ([elementName isEqualToString:@"resultScore"]) {
		[test.resultList addObject:scoreVal];
		[parentElementArray removeLastObject];
		[scoreVal release];
		scoreVal=nil;
	}
	else if ([elementName isEqualToString:@"categoryCount"]) {
		[appDelegate.categoryCountList addObject:categoryCount];
		[parentElementArray removeLastObject];
		[categoryCount release];
		categoryCount=nil;
	}
	else{ 
		
		NSString *parentElement=[parentElementArray lastObject];
		if ([parentElement isEqualToString:@"test"]) {
			[test setValue:currentElementValue forKey:elementName];
		}else if ([parentElement isEqualToString:@"testquestion"]) {
			[question setValue:currentElementValue forKey:elementName];
		}else if ([parentElement isEqualToString:@"scoreVal"]) {
			[scoreVal setValue:currentElementValue forKey:elementName];
		}else if ([parentElement isEqualToString:@"categoryCount"]) {
			[categoryCount setValue:currentElementValue forKey:elementName];
		}
		
		
	}
	[currentElementValue release];
	currentElementValue = nil;
}

- (void) dealloc {
	[categoryCount release];
	[test release];
	[question release];
	[scoreVal release];
	[parentElementArray release];
	[currentElementValue release];
	[super dealloc];
}

@end
