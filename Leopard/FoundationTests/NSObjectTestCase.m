//
//  NSObjectTestCase.m
//  FoundationTests
//
//  Created by Sam Krishna on 5/5/09.
//  Copyright 2009 Chaordium Software. All rights reserved.
//

#import "NSObjectTestCase.h"
#import "MyTestOfNSObject.h"
#import "MLog.h"

@implementation NSObjectTestCase

- (void)setUp
{
  delayFlag_ = YES;
}

- (void)testInitialize
{
    [MyTestOfNSObject initialize];
}

- (void)testAllocWithZone
{
  MyTestOfNSObject *testObject = [[MyTestOfNSObject allocWithZone:NSDefaultMallocZone()] init];
  STAssertNotNil(testObject, @"testObject should be allocated.");
  [testObject release];
  testObject = nil;
}

- (void)testAlloc
{
  MyTestOfNSObject *testObject = [[MyTestOfNSObject alloc] init];
  STAssertNotNil(testObject, @"testObject should be allocated.");
  [testObject release];
  testObject = nil;
}

- (void)testCancelPreviousPerformRequestsWithTarget
{
  // Not sure how to write this one.
  // If anyone has any suggestions, now would be a great time....
  
  MyTestOfNSObject *testObject = [[MyTestOfNSObject alloc] init];
  // test something here....
  STAssertTrue(NO, @"I have no idea how to test this method.");

  // Here was one attempt
//  MSLog(@"Registering for notification...");
//  int firingCount = 0;
//  [[NSNotificationCenter defaultCenter] addObserver:self 
//                                           selector:@selector(selectorFiredNotification:) name:FiringSelectorNotificationKey 
//                                             object:testObject];
//  
//  while (delayFlag_) {
//    if (firingCount == 0) {
//      MSLog(@"Entering if-block...");
//      [testObject performSelector:@selector(firingDelayedSelector) 
//                       withObject:nil
//                       afterDelay:0.25];
//      firingCount++;
//      MSLog(@"Exiting if-block...");
//    }
//  }
//  

//  MSLog(@"Deregistering for notification");
//  [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                  name:FiringSelectorNotificationKey 
//                                                object:testObject];

  [testObject release];
  testObject = nil;
}

- (void)testCancelPreviousPerformRequestsWithTargetSelectorObject
{
  MyTestOfNSObject *testObject = [[MyTestOfNSObject alloc] init];

  // test something here....
  STAssertTrue(NO, @"I have no idea how to test this method.");

  [testObject release];
  testObject = nil;
}

- (void)testClass
{
  STAssertTrue([self class] == [NSObjectTestCase class], 
               @"+class is broken!");
}

- (void)testClassFallbacksForKeyedArchiver
{
  MyTestOfNSObject *testObject = [[MyTestOfNSObject alloc] init];

  // test something here....
  STAssertTrue(NO, @"I have no idea how to test this method.");
  
  [testObject release];
  testObject = nil;
}

- (void)testClassForKeyedUnarchiver
{
  // test something here....
  STAssertTrue([NSObject class] == [NSObject classForKeyedUnarchiver], 
               @"+classForKeyedUnarchiver has a real problem here.");
}

- (void)testConformsToProtocol
{
  // test something here....
  STAssertTrue([NSObject conformsToProtocol:@protocol(NSObject)], @"NSObject is out-of-conformance....");
}

- (void)testCopyWithZone
{  
  // test something here....
  STAssertTrue([[NSObjectTestCase copyWithZone:[self zone]] class] == [NSObjectTestCase class], @"+copyWithZone may have some issues.");
}

@end
