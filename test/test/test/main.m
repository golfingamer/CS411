//
//  main.m
//  test
//
//  Created by Michael Daigh on 8/27/14.
//  Copyright (c) 2014 Michael Daigh. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

	@autoreleasepool {
	    
		NSArray *blah = [NSArray arrayWithObjects:@"top", @"act", @"cat", @"opt", @"tac", @"pot", nil];
		
		NSHashTable *hashTable = [NSHashTable hashTableWithOptions:NSPointerFunctionsCopyIn];
		
		for(NSString *aString in blah)
		{
			NSLog(@"First: %@", [hashTable anyObject]);
			[hashTable addObject:aString];

		}
		
		NSLog(@"Members: %@", [hashTable anyObject]);

	}
    return 0;
}

