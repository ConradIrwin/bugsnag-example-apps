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
    [Bugsnag startBugsnagWithApiKey:@"ad5eb405d9f5b28b42fe62c43abb87bc"];
    [[Bugsnag notifier] beforeNotify:^BOOL(BugsnagEvent *event) {
        NSLog(@"before Notify!");
        return NO;
    }];
    [self.button setTarget:self];
    [self.button setAction:@selector(buttonClick:)];
}

- (void) buttonClick:(NSButton*) button {
    @throw [NSException exceptionWithName:@"className" reason:@"message" userInfo:nil];
}

@end
