//
//  MyTestOfNSObject.h
//  FoundationTests
//
//  Created by Sam Krishna on 5/5/09.
//  Copyright 2009 Chaordium Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString *const FiringSelectorNotificationKey;

@interface MyTestOfNSObject : NSObject {

}

- (void)firingDelayedSelector;

@end
