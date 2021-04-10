//
//  AppDelegate.m
//  AndoUI
//
//  Created by dong on 2021/3/31.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (strong) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSButton *button;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    self.button.title = @"##12321312312321312##";
}

- (IBAction)ddd:(id)sender {
    NSLog(@"123");
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
