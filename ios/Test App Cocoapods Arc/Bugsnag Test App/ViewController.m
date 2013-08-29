//
//  ViewController.m
//  Bugsnag Test App
//
//  Created by Simon Maynard on 1/18/13.
//  Copyright (c) 2013 Simon Maynard. All rights reserved.
//

#import "ViewController.h"
#import "Bugsnag.h"
#import "BugsnagEvent.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)generateException:(id)sender {
    [NSException raise:@"BugsnagException" format:@"Test exception."];
}

- (IBAction)generateSignal:(id)sender {
    raise(SIGSEGV);
}

- (IBAction)delayedException:(id)sender {
    [self performSelector:@selector(nonFatalException:) withObject:sender afterDelay:5];
}

- (IBAction)nonFatalException:(id)sender {
    [Bugsnag notify:[NSException exceptionWithName:@"ExceptionName" reason:@"Something bad happened" userInfo:nil] withData:nil];
}

- (IBAction)nonFatalWithMetadata:(id)sender {
    [Bugsnag notify:[NSException exceptionWithName:@"ExceptionName" reason:@"Something bad happened" userInfo:nil] withData:[NSDictionary dictionaryWithObjectsAndKeys:[NSDictionary dictionaryWithObjectsAndKeys:@"metaDataValue", @"metaDataKey", nil], @"metaDataTab", nil]];
}

- (IBAction)nonFatalWithCustomData:(id)sender {
    [Bugsnag notify:[NSException exceptionWithName:@"ExceptionName" reason:@"Something bad happened" userInfo:nil] withData:[NSDictionary dictionaryWithObject:@"customDataValue" forKey:@"customDataKey"]];
}

- (IBAction)addUser:(id)sender {
    [Bugsnag addAttribute:@"attributeNameUser" withValue:@"attributeValueUser" toTabWithName:@"user"];
}

- (IBAction)addDevice:(id)sender {
    [Bugsnag addAttribute:@"attributeNameDevice" withValue:@"attributeValueDevice" toTabWithName:@"device"];
}
@end
