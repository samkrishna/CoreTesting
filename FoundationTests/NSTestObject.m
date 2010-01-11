//
//  NSTestObject.m
//  FoundationTests
//
//  Created by Sam Krishna on 1/7/10.
//  Copyright 2010 Sector Mobile. All rights reserved.
//

#import "NSTestObject.h"


@implementation NSTestObject

- (void)dealloc
{
  [NSException raise:@"Firing -dealloc exception" format:@"Raised as expected."];
  [super dealloc];
}

@end
