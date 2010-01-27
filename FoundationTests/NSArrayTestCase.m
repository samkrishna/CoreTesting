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
#pragma mark Creating an Array

/*
@interface NSArray (NSArrayCreation)

+ (id)array;
+ (id)arrayWithObject:(id)anObject;
+ (id)arrayWithObjects:(const id *)objects count:(NSUInteger)cnt;
+ (id)arrayWithObjects:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
+ (id)arrayWithArray:(NSArray *)array;
+ (id)arrayWithContentsOfFile:(NSString *)path;
+ (id)arrayWithContentsOfURL:(NSURL *)url;

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

  // Software source code is a structural language for a process.
  // A Wisdom-based structural language commentary on the following lines of code
  
  // Create a String object of the current directory path
  NSString *currentPath = [[NSFileManager defaultManager] currentDirectoryPath];
  
  // Append the file named "NSArrayTestCaseFile.plist" to the current path
  NSString *filePath = [currentPath stringByAppendingPathComponent:@"NSArrayTestCaseFile.plist"];
  
  // Create a new string object that starts with "file://" and append the contents of the filePath string
  // (in this case: "/Volumes/elyon/achilles/Projects/CoreTesting/FoundationTests/NSArrayTestCaseFile.plist")
  // which will produce a string that reads as:
  // "file:///Volumes/elyon/achilles/Projects/CoreTesting/FoundationTests/NSArrayTestCaseFile.plist"
  //
  // This structure means the string now conforms to the URI specification RFC 3986.
  // You can read it here: http://labs.apache.org/webarch/uri/rfc/rfc3986.html
  NSString *filePathURLString = [NSString stringWithFormat:@"file://%@", filePath];
  
  // Finally, create an ordered array object with the contents of the file located at the
  // previously constructured URL path using an object that represents an URL.
  NSArray *testObject = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:filePathURLString]];
  
  STAssertTrue([testObject count] == 3, 
               @"We didn't load the file properly.");
  STAssertTrue([[testObject objectAtIndex:0] isKindOfClass:[NSDate class]], 
               @"First object should be a NSDate!");
  STAssertTrue([[testObject objectAtIndex:1] isKindOfClass:[NSString class]], 
               @"Second object should be a NSString!");
  STAssertTrue([NSStringFromClass([[testObject objectAtIndex:2] class]) isEqualToString:@"NSCFBoolean"],
               @"Third object should be a NSCFBoolean!");
  STAssertTrue([[testObject objectAtIndex:2] boolValue] == YES, @"Should be a YES!");
}

#pragma mark -
#pragma mark Initializing an Array

/*
- (id)initWithObjects:(const id *)objects count:(NSUInteger)cnt;
- (id)initWithObjects:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
- (id)initWithArray:(NSArray *)array;
- (id)initWithArray:(NSArray *)array copyItems:(BOOL)flag AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER;

- (id)initWithContentsOfFile:(NSString *)path;
- (id)initWithContentsOfURL:(NSURL *)url;
*/

- (void)testInitWithObjectsCount
{
  NSString *strings[3];
  strings[0] = @"First";
  strings[1] = @"Second";
  strings[2] = @"Third";

  NSArray *testObject = [[NSArray alloc] initWithObjects:strings count:2];

  // test something here....
  STAssertTrue([testObject count] == 2, 
               @"The array doesn't contain 2 and only 2 objects!");
  STAssertTrue([[testObject objectAtIndex:0] isEqualToString:@"First"], @"The array doesn't have @\"First\" as its index 0 object!");

  [testObject release];
  testObject = nil;
}

- (void)testInitWithObjects
{
  NSArray *testObject = [[NSArray alloc] initWithObjects:[NSDate date], @"Zippy", [NSDictionary dictionary], nil];

  // test something here....
  // test something here....
  STAssertTrue([[testObject objectAtIndex:0] isKindOfClass:[NSDate class]], 
               @"First object should be a NSDate!");
  STAssertTrue([[testObject objectAtIndex:1] isKindOfClass:[NSString class]], 
               @"Second object should be a NSString!");
  STAssertTrue([[testObject objectAtIndex:2] isKindOfClass:[NSDictionary class]], 
               @"Third object should be a NSDictionary!");
  
  [testObject release];
  testObject = nil;
}

- (void)testInitWithArray
{
  NSArray *testArray = [NSArray arrayWithObjects:[NSDate date], @"Zippy", [NSDictionary dictionary], nil];
  NSArray *testObject = [[NSArray alloc] initWithArray:testArray];

  // test something here....
  STAssertTrue([testObject count] == 3, @"Something really failed with the +arrayWithArray method!");
  STAssertTrue([[testObject objectAtIndex:0] isKindOfClass:[NSDate class]], 
               @"First object should be a NSDate!");
  STAssertTrue([[testObject objectAtIndex:1] isKindOfClass:[NSString class]], 
               @"Second object should be a NSString!");
  STAssertTrue([[testObject objectAtIndex:2] isKindOfClass:[NSDictionary class]], 
               @"Third object should be a NSDictionary!");
  
  [testObject release];
  testObject = nil;
}

- (void)testInitWithArrayCopyItems
{
  NSDate *date = [[NSDate alloc] init];
  STAssertTrue([date retainCount] == 1, 
               @"There's something really screwy in the +alloc/-init code!");
  NSArray *targetArray = [NSArray arrayWithObject:date];
  STAssertTrue([date retainCount] == 2, 
               @"There's something really screwy in the -retain code!");
  
  NSArray *testObject = [[NSArray alloc] initWithArray:targetArray copyItems:YES];
  STAssertTrue([date retainCount] == 2, 
               @"Hey! This is supposed to yield only 2 owners! (This test class and the targetArray array)");
  STAssertTrue([[testObject lastObject] retainCount] == 1,
               @"Hey! This is supposed to yield only 1 owner! It actually is: [[testObject lastObject] retainCount] = %d", [[testObject lastObject] retainCount]);

  // Cleanup
  [testObject release];
  [date release];

  testObject = nil;
  date = nil;
}

- (void)testInitWithContentsOfFile
{
  NSArray *testObject = [[NSArray alloc ] initWithContentsOfFile:@"NSArrayTestCaseFile.plist"];

  // test something here....
  STAssertTrue([testObject count] == 3, @"We didn't load the file properly.");
  STAssertTrue([[testObject objectAtIndex:0] isKindOfClass:[NSDate class]], 
               @"First object should be a NSDate!");
  STAssertTrue([[testObject objectAtIndex:1] isKindOfClass:[NSString class]], 
               @"Second object should be a NSString!");
  STAssertTrue([NSStringFromClass([[testObject objectAtIndex:2] class]) isEqualToString:@"NSCFBoolean"],
               @"Third object should be a NSCFBoolean!");
  STAssertTrue([[testObject objectAtIndex:2] boolValue] == YES, @"Should be a YES!");
  
  [testObject release];
  testObject = nil;
}

- (void)testInitWithContentsOfURL
{
  // This one was a little tricky. Since I had to prefix the URL path string with
  // @"file://" I really had a hard time wrapping my head around what exactly
  // had to happen because it required an absolute file path.
  
  // Software source code is a structural language for a process.
  // A Wisdom-based structural language commentary on the following lines of code
  
  // Create a String object of the current directory path
  NSString *currentPath = [[NSFileManager defaultManager] currentDirectoryPath];
  
  // Append the file named "NSArrayTestCaseFile.plist" to the current path
  NSString *filePath = [currentPath stringByAppendingPathComponent:@"NSArrayTestCaseFile.plist"];
  
  // Create a new string object that starts with "file://" and append the contents of the filePath string
  // (in this case: "/Volumes/elyon/achilles/Projects/CoreTesting/FoundationTests/NSArrayTestCaseFile.plist")
  // which will produce a string that reads as:
  // "file:///Volumes/elyon/achilles/Projects/CoreTesting/FoundationTests/NSArrayTestCaseFile.plist"
  //
  // This structure means the string now conforms to the URI specification RFC 3986.
  // You can read it here: http://labs.apache.org/webarch/uri/rfc/rfc3986.html
  NSString *filePathURLString = [NSString stringWithFormat:@"file://%@", filePath];
  
  // Finally, create an ordered array object with the contents of the file located at the
  // previously constructured URL path using an object that represents an URL.
  NSArray *testObject = [[NSArray alloc ] initWithContentsOfURL:[NSURL URLWithString:filePathURLString]];
  
  STAssertTrue([testObject count] == 3, 
               @"We didn't load the file properly.");
  STAssertTrue([[testObject objectAtIndex:0] isKindOfClass:[NSDate class]], 
               @"First object should be a NSDate!");
  STAssertTrue([[testObject objectAtIndex:1] isKindOfClass:[NSString class]], 
               @"Second object should be a NSString!");
  STAssertTrue([NSStringFromClass([[testObject objectAtIndex:2] class]) isEqualToString:@"NSCFBoolean"],
               @"Third object should be a NSCFBoolean!");
  STAssertTrue([[testObject objectAtIndex:2] boolValue] == YES, @"Should be a YES!");
  
  [testObject release];
  testObject = nil;
}

#pragma mark -
#pragma mark Querying an Array

/*
– containsObject:  
– count  
– getObjects:  
– getObjects:range:  
– indexOfObject:  
– indexOfObject:inRange:  
– indexOfObjectIdenticalTo:  
– indexOfObjectIdenticalTo:inRange:  
– lastObject  
– objectAtIndex:  
– objectsAtIndexes:  
– objectEnumerator  
– reverseObjectEnumerator
*/

- (void)testContainsObject
{
  NSDate *date = [NSDate date];
  NSArray *originalDateArray = [NSArray arrayWithObject:date];
  NSArray *copyDateArray = [[NSArray alloc] initWithArray:originalDateArray copyItems:YES];

  STAssertTrue([originalDateArray containsObject:date], 
               @"We may be having an identity crisis!");
  // This next result threw me because I mistakenly thought -hash guaranteed uniqueness no matter what.
  // [copyDateArray lastObject] has a retainCount = 1.
  // [originalDateArray lastObject] has a retainCount = 2.
  // However, -hash returns the same number for both.
  // I'll go ahead and assent, even though in my mind they are clearly *not* identical.
  // But I can accept Apple's POV and will let it stand in the test.
  // (Also see the notes at -indexOfObjectIdenticalTo:)
  STAssertTrue([copyDateArray containsObject:date], 
               @"We are definitely having an identity crisis!");
  
  [copyDateArray release];
  copyDateArray = nil;
}

- (void)testCount
{
  NSDate *date = [NSDate date];
  NSArray *testArray = [NSArray arrayWithObjects:date, date, date, nil];
  
  STAssertTrue([testArray count] == 3, @"We definitely have an issue with +arrayWithObjects.");
}

- (void)testGetObjects
{
  NSDate *dates[3];
  NSDate *date = [NSDate date];
  NSArray *testArray = [NSArray arrayWithObjects:date, date, date, nil];
  [testArray getObjects:dates];
  
  STAssertNotNil(dates[2], @"There should be something here!");
}

- (void)testGetObjectsRange
{
  // If we do:
  // NSDate *dates[3];
  // then
  // STAssertNil(dates[2], @"There should be nothing here!");
  // fails b/c the dates array isn't initialized to nil.
  NSDate *dates[3] = {nil, nil, nil};
  NSDate *date = [NSDate date];
  NSArray *testArray = [NSArray arrayWithObjects:date, date, date, date, nil];
  [testArray getObjects:dates range:NSMakeRange(0, 2)];
  
  STAssertNil(dates[2], @"There should be nothing here!");
  STAssertNotNil(dates[1], @"There should be something here!");
}

- (void)testIndexOfObject
{
  NSDate *dateZero = [NSDate date];
  NSDate *dateOne = [NSDate distantPast];
  NSDate *dateTwo = [NSDate distantFuture];
  NSArray *testObject = [NSArray arrayWithObjects:dateZero, dateOne, dateTwo, nil];

  // test something here....
  STAssertTrue([testObject indexOfObject:dateZero] == 0, @"dateZero isn't here. We are doomed!");
  STAssertTrue([testObject indexOfObject:dateOne] == 1, @"dateOne isn't here. We are doomed!");
  STAssertTrue([testObject indexOfObject:dateTwo] == 2, @"dateTwo isn't here. We are doomed!");
}

- (void)testIndexOfObjectInRange
{
  NSDate *dateZero = [NSDate date];
  NSDate *dateOne = [NSDate distantPast];
  NSDate *dateTwo = [NSDate distantFuture];
  NSArray *testObject = [NSArray arrayWithObjects:dateZero, dateOne, dateZero, dateTwo, dateTwo, dateZero, nil];
  
  // test something here....
  STAssertTrue([testObject indexOfObject:dateZero inRange:NSMakeRange(1, 4)] == 2, @"We're doomed!");
  STAssertTrue([testObject indexOfObject:dateTwo inRange:NSMakeRange(1, 4)] == 3, @"We're doomed!");
  STAssertFalse([testObject indexOfObject:dateZero inRange:NSMakeRange(1, 4)] == 0, @"We're doomed!");
  STAssertTrue([testObject indexOfObject:dateTwo inRange:NSMakeRange(0, 3)] == NSNotFound, @"We're doomed!");
}

- (void)testIndexOfObjectIdenticalTo
{
  NSDate *dateZero = [NSDate date];
  NSDate *dateOne = [NSDate distantPast];
  NSDate *dateTwo = [NSDate distantFuture];
  NSDate *dateIdenticalToDateTwo = dateTwo;
  NSArray *testObject = [NSArray arrayWithObjects:dateZero, dateOne, dateZero, dateTwo, dateTwo, dateZero, nil];
  
  // test something here....
  STAssertTrue([testObject indexOfObjectIdenticalTo:dateZero] == 0, @"We're doomed!");
  STAssertTrue([testObject indexOfObjectIdenticalTo:dateIdenticalToDateTwo] == 3, @"We're doomed!");
}

@end
