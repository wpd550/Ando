//
//  IKClipTextField.m
//  iKIGAI_Download
//
//  Created by dong on 2020/6/15.
//  Copyright © 2020 IKDong. All rights reserved.
//

#import "IKClipTextField.h"
#import "NSColor+Custom.h"

@implementation IKClipTextField


- (instancetype)initWithCoder:(NSCoder *)coder
{
    if(self = [super initWithCoder:coder])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ApplicationAction) name:NSApplicationWillBecomeActiveNotification object:nil];
//        [self setup];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setup
{
//    self.bezelStyle = NSTextFieldRoundedBezel;
//    [self setWantsLayer:YES];
//    self.layer.cornerRadius = 8.0;
//    self.layer.backgroundColor = [NSColor redColor].CGColor;
    
}


- (void)ApplicationAction
{
    NSPasteboard *pastboard = [NSPasteboard generalPasteboard];
    NSArray *types = [pastboard types];
       if ([types containsObject:NSPasteboardTypeString]) {
           NSString *s = [pastboard stringForType:NSPasteboardTypeString];
           if([self.stringValue isNotEqualTo:@""])
           {
               return;
           }
           if([s hasPrefix:@"http"] || [s hasPrefix:@"www"])
           {
               self.stringValue = s;
           }
       }}

- (void)drawRect:(NSRect)dirtyRect {
//    [super drawRect:dirtyRect];
    
    // Drawing code here.
    NSRect blackOutlineFrame = NSMakeRect(0.0, 0.0, [self bounds].size.width, [self bounds].size.height-1.0);
    [[NSColor colorWithHex:0xBFBFBF] set];
    [[NSBezierPath bezierPathWithRoundedRect:blackOutlineFrame xRadius:10 yRadius:10] stroke];
}

@end
