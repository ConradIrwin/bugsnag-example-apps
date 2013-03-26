//
//  AppDelegate.m
//  BugsnagTestOSX
//
//  Created by Simon Maynard on 3/19/13.
//  Copyright (c) 2013 Simon Maynard. All rights reserved.
//

#import "AppDelegate.h"
#import "Bugsnag.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [Bugsnag startBugsnagWithApiKey:@"de9c8cc8bfaab7d0f1f20d9a570bded8"];
    [Bugsnag notify:[NSException exceptionWithName:@"className" reason:@"message" userInfo:nil]];
}

@end
