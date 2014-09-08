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
		NSMutableString *newSortedLine;
		NSString * numberString;
		int topCounter = 0;
		int counter = 1;
		int lineNumber = 0;
		int topWordLocation = 0;
		NSMutableArray * sortedCharacters = [[NSMutableArray alloc] init];
		NSMutableArray * originalArray = [[NSMutableArray alloc] init];
		
		for (NSString * line in [file componentsSeparatedByString:@"\n"]) {
			
			[originalArray addObject:line];
			
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
			newSortedLine = [NSMutableString stringWithFormat:@"%@%d", sortedLine, lineNumber];
			lineNumber++;
			[sortedCharacters addObject:newSortedLine];
		}
		
		NSArray * sortedWords = [sortedCharacters sortedArrayUsingSelector:@selector(compare:)];

		for (int i=0; i<[sortedWords count]; i++){
			
			NSString * substring1;
			NSString * substring2;
			if(i+1<[sortedWords count]){
				
				NSScanner * scanner1 = [NSScanner scannerWithString:sortedWords[i]];
				NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
				[scanner1 scanUpToCharactersFromSet:numbers intoString:&substring1];
				NSScanner * scanner2 = [NSScanner scannerWithString:sortedWords[i+1]];
				[scanner2 scanUpToCharactersFromSet:numbers intoString:&substring2];

				if([substring1 isEqualToString:substring2]){
					counter+=1;
				}
				else
					counter = 1;
				if(topCounter < counter){
					topCounter = counter;
					topWordLocation = i+1;
					counter = 1;
				}
			}
		}
		
		NSLog(@"The anagram with the largest set is:");
		
		for(int i=topWordLocation; i>topWordLocation-topCounter; i--){
			
			NSScanner * scanner = [NSScanner scannerWithString:sortedWords[i]];
			NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
			[scanner scanUpToCharactersFromSet:numbers intoString:NULL];
			[scanner scanCharactersFromSet:numbers intoString:&numberString];
			long numberLocation = [numberString integerValue];
			NSLog(@"%@", originalArray[numberLocation]);
		}
		
		NSTimeInterval timeInterval = -[start timeIntervalSinceNow];
		NSLog(@"It took %f seconds to calculate.", timeInterval);
	}   

	return 0;
}



