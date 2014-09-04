//
//  main.m
//  Assignment2
//
//  Created by Michael Daigh on 9/3/14.
//  Copyright (c) 2014 Michael Daigh. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

	@autoreleasepool {
	    
		NSDate *start = [NSDate date];
		
		NSString * filePath = @"/Users/MDaigh/Dropbox/School/Fall 2014/CS 411/Assignment2/Assignment2/words.txt";
		NSError *error;
		NSString * file = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
		if(error)
		{
			NSLog(@"Error is %@", [error localizedDescription]);
		}
		
		NSString * sortedLine;
		NSString * topWord;
		int topCounter = 0;
		int counter = 1;
		NSMutableArray * sortedCharacters = [[NSMutableArray alloc] init];
		//NSMutableArray * original = [[NSMutableArray alloc] init];
		
		for (NSString * line in [file componentsSeparatedByString:@"\n"]) {
			//[original addObject:line];
			NSMutableArray *charArray = [NSMutableArray arrayWithCapacity:line.length];
			for (int i=0; i<line.length; i++) {
				NSString *charStr = [line substringWithRange:NSMakeRange(i, 1)];
				[charArray addObject:charStr];
			}
			[charArray sortUsingComparator:^(NSString *a, NSString *b){
				return [a caseInsensitiveCompare:b];
			}];
			sortedLine = [charArray componentsJoinedByString:@""];
			sortedLine = [sortedLine lowercaseString];
			[sortedCharacters addObject:sortedLine];
		}
		
		NSArray * sortedWords = [sortedCharacters sortedArrayUsingSelector:@selector(compare:)];
		
		for (int i=0; i<[sortedWords count]; i++){
			if(i+1<[sortedWords count] && [sortedWords[i] isEqualToString:sortedWords[i+1]]){
				counter+=1;
			}
			else
				counter = 1;
			if(topCounter < counter){
				topCounter = counter;
				topWord = sortedWords[i];
				counter = 1;
			}
		}
		
		NSTimeInterval timeInterval = -[start timeIntervalSinceNow];
		NSLog(@"The letters that give the most anagrams are: %@", topWord);
		NSLog(@"It took %f seconds to calculate.", timeInterval);
	}   

	return 0;
}



