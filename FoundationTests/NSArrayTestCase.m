//
//  NSArrayTestCase.m
//  FoundationTests
//
//  Created by Sam Krishna on 1/11/10.
//  Copyright 2010 Sector Mobile. All rights reserved.
//

#import "NSArrayTestCase.h"
#import "MLog.h"

@implementation NSArrayTestCase

#if USE_APPLICATION_UNIT_TEST     // all code under test is in the iPhone Application

- (void) testAppDelegate {
    
    id yourApplicationDelegate = [[UIApplication sharedApplication] delegate];
    STAssertNotNil(yourApplicationDelegate, @"UIApplication failed to find the AppDelegate");
    
}

#else                           // all code under test must be linked into the Unit Test bundle

- (void) testMath {
    
    STAssertTrue((1+1)==2, @"Compiler isn't feeling well today :-(" );
    
}


#endif

#pragma mark -
#pragma mark Array Creation

/*
@interface NSArray (NSArrayCreation)

+ (id)array;
+ (id)arrayWithObject:(id)anObject;
+ (id)arrayWithObjects:(const id *)objects count:(NSUInteger)cnt;
+ (id)arrayWithObjects:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
+ (id)arrayWithArray:(NSArray *)array;

- (id)initWithObjects:(const id *)objects count:(NSUInteger)cnt;
- (id)initWithObjects:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
- (id)initWithArray:(NSArray *)array;
- (id)initWithArray:(NSArray *)array copyItems:(BOOL)flag AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER;

+ (id)arrayWithContentsOfFile:(NSString *)path;
+ (id)arrayWithContentsOfURL:(NSURL *)url;
- (id)initWithContentsOfFile:(NSString *)path;
- (id)initWithContentsOfURL:(NSURL *)url;

@end
*/

- (void)testArray
{
  NSArray *testObject = [NSArray array];

  // test something here....
  STAssertFalse(testObject == nil, @"The array doesn't exist!");
}

- (void)testArrayWithObject
{
  NSArray *testObject = [NSArray arrayWithObject:[[[NSObject alloc] init] autorelease]];

  // test something here....
  STAssertTrue([testObject count] == 1, @"The array doesn't have an object!");
}

- (void)testArrayWithObjectsCount
{
  NSString *strings[3];
  strings[0] = @"First";
  strings[1] = @"Second";
  strings[2] = @"Third";
  
  NSArray *testObject = [NSArray arrayWithObjects:strings count:2];

  // test something here....
  STAssertTrue([testObject count] == 2, @"The array doesn't contain 2 and only 2 objects!");
  STAssertTrue([[testObject objectAtIndex:0] isEqualToString:@"First"], @"The array doesn't have @\"First\" as its index 0 object!");
}

- (void)testArrayWithObjects
{
  NSArray *testObject = [NSArray arrayWithObjects:[NSDate date], @"Zippy", [NSDictionary dictionary], nil];

  // test something here....
  STAssertTrue([[testObject objectAtIndex:0] isKindOfClass:[NSDate class]], 
               @"First object should be a NSDate!");
  STAssertTrue([[testObject objectAtIndex:1] isKindOfClass:[NSString class]], 
               @"Second object should be a NSString!");
  STAssertTrue([[testObject objectAtIndex:2] isKindOfClass:[NSDictionary class]], 
               @"Third object should be a NSDictionary!");
}

- (void)testArrayWithArray
{
  NSArray *testArray = [NSArray arrayWithObjects:[NSDate date], @"Zippy", [NSDictionary dictionary], nil];
  NSArray *testObject = [NSArray arrayWithArray:testArray];

  // test something here....
  STAssertTrue([testObject count] == 3, @"Something really failed with the +arrayWithArray method!");
  STAssertTrue([[testObject objectAtIndex:0] isKindOfClass:[NSDate class]], 
               @"First object should be a NSDate!");
  STAssertTrue([[testObject objectAtIndex:1] isKindOfClass:[NSString class]], 
               @"Second object should be a NSString!");
  STAssertTrue([[testObject objectAtIndex:2] isKindOfClass:[NSDictionary class]], 
               @"Third object should be a NSDictionary!");
}

- (void)testArrayWithContentsOfFile
{
  NSArray *testObject = [NSArray arrayWithContentsOfFile:@"NSArrayTestCaseFile.plist"];

  // test something here....
  STAssertTrue([testObject count] == 3, @"We didn't load the file properly.");
  STAssertTrue([[testObject objectAtIndex:0] isKindOfClass:[NSDate class]], 
               @"First object should be a NSDate!");
  STAssertTrue([[testObject objectAtIndex:1] isKindOfClass:[NSString class]], 
               @"Second object should be a NSString!");
  STAssertTrue([NSStringFromClass([[testObject objectAtIndex:2] class]) isEqualToString:@"NSCFBoolean"],
               @"Third object should be a NSCFBoolean!");
  STAssertTrue([[testObject objectAtIndex:2] boolValue] == YES, @"Should be a YES!");
  MSLog(@"[[testObject objectAtIndex:2] class] = %@", NSStringFromClass([[testObject objectAtIndex:2] class]));
}

- (void)testArrayWithContentsOfURL
{
  // This one was a little tricky. Since I had to prefix the URL path string with
  // @"file://" I really had a hard time wrapping my head around what exactly
  // had to happen because it required an absolute file path.
  NSString *currentPath = [[NSFileManager defaultManager] currentDirectoryPath];
  NSString *filePath = [currentPath stringByAppendingPathComponent:@"NSArrayTestCaseFile.plist"];
  NSString *filePathURLString = [NSString stringWithFormat:@"file://%@", filePath];
  NSArray *testObject = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:filePathURLString]];
  STAssertTrue([testObject count] == 3, @"We didn't load the file properly.");
  STAssertTrue([[testObject objectAtIndex:0] isKindOfClass:[NSDate class]], 
               @"First object should be a NSDate!");
  STAssertTrue([[testObject objectAtIndex:1] isKindOfClass:[NSString class]], 
               @"Second object should be a NSString!");
  STAssertTrue([NSStringFromClass([[testObject objectAtIndex:2] class]) isEqualToString:@"NSCFBoolean"],
               @"Third object should be a NSCFBoolean!");
  STAssertTrue([[testObject objectAtIndex:2] boolValue] == YES, @"Should be a YES!");
}

@end
