//
//  MyTestOfNSObject.m
//  FoundationTests
//
//  Created by Sam Krishna on 5/5/09.
//  Copyright 2009 Chaordium Software. All rights reserved.
//

#import "MyTestOfNSObject.h"
#import "MLog.h"

@implementation MyTestOfNSObject

+ (void)initialize
{
    MSLog(@"Firing +initialize");
    [super initialize];
}

@end
