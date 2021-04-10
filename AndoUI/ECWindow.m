//
//  ECWindow.m
//  AndoUI
//
//  Created by dong on 2021/3/31.
//

#import "ECWindow.h"

@interface ECWindow()
{
    
}

@property(weak) NSButton* closeButton;

@property(weak) NSButton* miniButton;

@property(weak) NSButton* maxButton;

@end

@implementation ECWindow

- (void)awakeFromNib{
//    [self commonInitialize];
//    [super awakeFromNib];
//    NSArray *subviews = self.contentView.superview.subviews;
//    for (NSView *view in subviews) {
//        if ([view isKindOfClass:NSClassFromString(@"NSTitlebarContainerView")]) {
////            [view removeFromSuperview];
//            view.hidden = YES;
//        }
//    }
//    self.movableByWindowBackground = YES;
    
}


- (BOOL)canBecomeKeyWindow{
    return YES;
}

- (BOOL)canBecomeMainWindow{
    return YES;
}


- (void)commonInitialize {
    
   
    self.closeButton = [NSWindow standardWindowButton:NSWindowCloseButton forStyleMask:3];
    self.closeButton.frame = NSMakeRect(10, 0, self.closeButton.bounds.size.width, self.closeButton.bounds.size.height);
    
    self.miniButton = [NSWindow standardWindowButton:NSWindowMiniaturizeButton forStyleMask:3];
    self.miniButton.frame = NSMakeRect(30, 0, self.miniButton.bounds.size.width, self.miniButton.bounds.size.height);
    
    self.maxButton = [NSWindow standardWindowButton:NSWindowZoomButton forStyleMask:3];
    self.maxButton.frame = NSMakeRect(50, 0, self.maxButton.bounds.size.width, self.maxButton.bounds.size.height);

    [self.contentView addSubview:self.closeButton];
    [self.contentView addSubview:self.miniButton];
    [self.contentView addSubview:self.maxButton];
    [self becomeKeyWindow];
}
@end
