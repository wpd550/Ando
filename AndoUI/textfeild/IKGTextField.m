//
//  IKGTextField.m
//  iKIGAI_Download
//
//  Created by dong on 2020/7/12.
//  Copyright © 2020 IKDong. All rights reserved.
//

#import "IKGTextField.h"
#import "NSColor+Custom.h"

@implementation IKGTextField

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if(self = [super initWithCoder:coder])
    {
//        [self setup];
    }
    return self;
}




- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    NSRect blackOutlineFrame = NSMakeRect(0.0, 0.0, [self bounds].size.width, [self bounds].size.height-1.0);
    [[NSColor colorWithHex:0xBFBFBF] set];
    [[NSBezierPath bezierPathWithRoundedRect:blackOutlineFrame xRadius:10 yRadius:10] stroke];
}



@end
