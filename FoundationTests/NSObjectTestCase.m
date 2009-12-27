//
//  NSObjectTestCase.m
//  FoundationTests
//
//  Created by Sam Krishna on 5/5/09.
//  Copyright 2009 Chaordium Software. All rights reserved.
//

#import "NSObjectTestCase.h"
#import "MLog.h"
#import <Foundation/NSObjCRuntime.h>
#import <objc/runtime.h>

@implementation NSObjectTestCase

#pragma mark -
#pragma mark Class Methods

- (void)testAllocWithZone
{
  NSObject *testObject = [[NSObject allocWithZone:NSDefaultMallocZone()] init];
  STAssertNotNil(testObject, @"testObject should be allocated.");
  [testObject release];
  testObject = nil;
}

- (void)testAlloc
{
  NSObject *testObject = [[NSObject alloc] init];
  STAssertNotNil(testObject, @"testObject should be allocated.");
  [testObject release];
  testObject = nil;
}

- (void)testCancelPreviousPerformRequestsWithTarget
{
  // Not sure how to write this one.
  // If anyone has any suggestions, now would be a great time....
  
  NSObject *testObject = [[NSObject alloc] init];
  // test something here....
#warning No idea how to +cancelPreviousPerformRequestsWithTarget:
//  STAssertTrue(NO, @"I have no idea how to test this method.");

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
  NSObject *testObject = [[NSObject alloc] init];

  // test something here....
#warning No idea how to test +cancelPreviousPerformRequestsWithTarget:selector:object:
  //  STAssertTrue(NO, @"I have no idea how to test this method.");

  [testObject release];
  testObject = nil;
}

- (void)testClass
{
  STAssertTrue([NSObject class] == NSClassFromString(@"NSObject"),
               @"+class is broken!");
}

- (void)testClassFallbacksForKeyedArchiver
{
  NSObject *testObject = [[NSObject alloc] init];

  // test something here....
#warning No idea how to test +classFallbacksForKeyedArchiver
//  STAssertTrue(NO, @"I have no idea how to test this method.");
  
  [testObject release];
  testObject = nil;
}

- (void)testClassForKeyedUnarchiver
{
  // test something here....
#warning No idea how to test +classForKeyedUnarchiver
//  STAssertTrue([NSObject class] == [NSObject classForKeyedUnarchiver], 
//               @"+classForKeyedUnarchiver has a real problem here.");
}

- (void)testConformsToProtocol
{
  // test something here....
  STAssertTrue([NSObject conformsToProtocol:@protocol(NSObject)], @"NSObject is out-of-conformance....");
}

- (void)testCopyWithZone
{  
  // test something here....
  STAssertTrue([[NSObject copyWithZone:[self zone]] class] == [NSObject class], @"+copyWithZone may have some issues.");
}

- (void)testClassDescription
{
  // test something here....
  STAssertTrue([[NSObject description] isEqualToString:@"NSObject"], @"I have no idea how to test this method: %@", [NSObject description]);
}

- (void)testInitialize
{
#warning No idea how to test +initialize
}

- (void)testInstanceMethodForSelector
{
	IMP descriptionIMP = [NSObject instanceMethodForSelector:@selector(description)];
	IMP secondaryIMP = class_getMethodImplementation([NSObject class], @selector(description));
	STAssertTrue(descriptionIMP == secondaryIMP, @"IMPs are not equivalent!!");
}

- (void)testMethodForSelector
{
	IMP descriptionIMP = [[NSObject class] methodForSelector:@selector(description)];
	STAssertTrue(descriptionIMP != NULL, @"IMP is NULL!!");
}

- (void)testInstanceMethodSignatureForSelector
{
	NSMethodSignature *sig = [NSObject instanceMethodSignatureForSelector:@selector(init)];
	STAssertNotNil(sig, @"sig = %@", sig);
	STAssertTrue([sig numberOfArguments] == 2, 
							 @"The number of arguments for init should be 2!!! "
							 @"[[sig numberOfArgments] == %d", [sig numberOfArguments]);
}

- (void)testInstancesRespondToSelector
{
	STAssertTrue([NSObject instancesRespondToSelector:@selector(init)], @"-init is unavailable!");
	STAssertTrue([NSObject instancesRespondToSelector:@selector(description)], @"-description is unavailable!");
	STAssertTrue([NSObject instancesRespondToSelector:@selector(dealloc)], @"-dealloc is unavailable!");
	STAssertFalse([NSObject instancesRespondToSelector:@selector(sortedArrayUsingSelector:)], @"-sortedArrayUsingSelector: is unavailable!");
}

- (void)testIsSubclassOfClass
{
	STAssertFalse([NSObject isSubclassOfClass:[NSArray class]], @"There's something broken about this hierarchy!");
	STAssertTrue([NSArray isSubclassOfClass:[NSObject class]], @"There's something wrong about this heirarchy!!");
}

- (void)testLoad
{
#warning No idea how to test +load
}

- (void)testMutableCopyWithZone
{
	NSZone *defaultZone = NSDefaultMallocZone();
	NSObject *mutableCopy = [NSObject mutableCopyWithZone:defaultZone];
	STAssertNotNil(mutableCopy, @"There was no mutable copy produced!!");
	// This is going to return an NSDictionary class object, not an NSMutableDictionary class object
	Class mutableDictionary = [NSDictionary mutableCopyWithZone:defaultZone];
	STAssertFalse([mutableDictionary class] == [NSMutableDictionary class],
							 @"[mutableDictionary class] = %@ and "
							 @"[NSMutableDictionary class] = %@",
							 NSStringFromClass([mutableDictionary class]),
							 NSStringFromClass([NSMutableDictionary class]));
	STAssertTrue([mutableDictionary class] == [NSDictionary class], @"the identity is broken!!");
	NSZoneFree(defaultZone, mutableCopy);
	NSZoneFree(defaultZone, mutableDictionary);
}

- (void)testNew
{
	NSObject *testObject = [NSObject new];
	STAssertNotNil(testObject, @"Object wasn't allocated and initialized!!");
	[testObject release];
	testObject = nil;
}

- (void)testResolveClassMethod
{
#warning Am skipping testing of +resolveClassMethod: for now....
}

- (void)testResolveInstanceMethod
{
#warning Am skipping the testing of +resolveInstanceMethod: for now....
}

- (void)testSetVersion
{
#warning Am skipping the testing of +setVersion: for now
}

- (void)testSuperclass
{
	STAssertNil([NSObject superclass], @"NSObject has a superclass?!! Are you batshit insane!!?");
}

- (void)testVersion
{
#warning Am skipping the testing of +version for now
}

#pragma mark -
#pragma mark Instance Methods

- (void)testAwakeFromCoder
{
	NSObject *testObject = [[NSObject new] awakeAfterUsingCoder:[[NSCoder new] autorelease]];
	STAssertNotNil(testObject, @"The object wasn't awaken!");
	STAssertTrue([testObject class] == [NSObject class], @"The identity test succeeded!");
	[testObject release];
	testObject = nil;
}

- (void)testClassForCoder
{
	NSObject *testObject = [[NSObject alloc] init];
	Class resultClass = [testObject classForCoder];
	STAssertTrue(resultClass == [NSObject class], @"Coder's class identity is broken!");
	[testObject release];
	testObject = nil;
}

@end
