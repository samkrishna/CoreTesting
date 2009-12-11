//
//  MLog.h
//
//  Created by Sam Krishna on 10/9/08.
//  Copyright 2008 Chaordium Software. All rights reserved.
//

// This code is slightly modified from AgentM's code at the following page:
// http://www.borkware.com/rants/agentm/mlog/

#import <Foundation/Foundation.h>

#define DEBUG 1

#if DEBUG
    #define MSLog(s,...) \
        [MLog logFile:__FILE__ lineNumber:__LINE__ format:(s), ##__VA_ARGS__]
#else
    #define MSLog(s,...)
#endif

@interface MLog : NSObject
{
}

+(void)logFile:(char*)sourceFile lineNumber:(int)lineNumber format:(NSString*)format, ...;
+(void)setLogOn:(BOOL)logOn;

@end