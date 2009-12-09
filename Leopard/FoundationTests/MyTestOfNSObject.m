//
//  MyTestOfNSObject.m
//  FoundationTests
//
//  Created by Sam Krishna on 5/5/09.
//  Copyright 2009 Chaordium Software. All rights reserved.
//

#import "MyTestOfNSObject.h"
#import "MLog.h"

static NSString *const descriptionKey = @"Welcome to MyTestOfNSObject!";
NSString *const FiringSelectorNotificationKey = @"Firing Selector Notification";

@implementation MyTestOfNSObject

+ (void)initialize
{
    MSLog(@"Firing +initialize");
    [super initialize];
}

- (NSString *)description
{
  MSLog(@"Firing -description");
  return descriptionKey;
}

- (void)firingDelayedSelector
{
  MSLog(@"Firing -firingDelayedSelector");
  [[NSNotificationCenter defaultCenter] postNotificationName:FiringSelectorNotificationKey 
                                                      object:self];
}

@end
