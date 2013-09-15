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
    [Bugsnag startBugsnagWithApiKey:@"f7fb91dfa7601dc30818ac9d23400958"];
    [Bugsnag configuration].notifyEndpoint = @"http://localhost:8000";
    [self.button setTarget:self];
    [self.button setAction:@selector(buttonClick:)];
}

- (void) buttonClick:(NSButton*) button {
    [Bugsnag notify:[NSException exceptionWithName:@"className" reason:@"message" userInfo:nil]];
}

@end
