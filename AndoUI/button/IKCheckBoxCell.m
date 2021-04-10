//
//  IKClipTextField.h
//  iKIGAI_Download
//
//  Created by dong on 2020/6/15.
//  Copyright © 2020 IKDong. All rights reserved.
//

#import "IKCheckBoxCell.h"

@implementation IKCheckBoxCell
@synthesize detaY = _detaY;
@synthesize bgColor = _bgColor;
@synthesize boxFillColor = _boxFillColor;
@synthesize boxTickColor = _boxTickColor;
@synthesize boxBorderColor = _boxBorderColor;

#pragma mark - Override Methods
-(instancetype)init{
    self = [super init];
    if (self) {
        [self __initializeTUICheckboxCell];
    }
    return self;
}

-(instancetype) initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self __initializeTUICheckboxCell];
    }
    return self;
}

-(instancetype)initWithFrame:(NSRect)frameRect{
    self = [super init];
    if (self) {
        [self __initializeTUICheckboxCell];
    }
    return self;
}

- (void)setNextState{
    [super setNextState];
}

- (void)drawImage:(NSImage*)image withFrame:(NSRect)frame inView:(NSView*)controlView{
    if (self.imagePosition != NSImageOnly)
            _detaY = 3;
    frame.origin.y += _detaY;
    frame = NSMakeRect(frame.origin.x, frame.origin.y, image.size.width, image.size.height);
    [super drawImage:[self __drawStatusImage:image.size] withFrame:frame inView:controlView];
}

#pragma mark - Private methods

-(void)__initializeTUICheckboxCell{

    [self setButtonType:NSSwitchButton];
}


-(NSImage *)__drawStatusImage:(NSSize)size {
    NSImage *image = nil;
    switch (_boxStyle) {
        case style_0:
            image =[self drawStyle_0:size];
            break;
        case style_1:
            image =[self drawStyle_1:size];
            break;
        default:
            break;
    }
    return image;
}

-(NSImage *)drawStyle_0:(NSSize)size
{
    size.height -= 2;
    size.width -= 2;
    NSImage *image = [[NSImage alloc] initWithSize:size];
    NSRect rctBorder = NSMakeRect(0, 0, image.size.width,image.size.height);
    
    NSBezierPath *borderPath = [NSBezierPath bezierPathWithRoundedRect:NSInsetRect(rctBorder, 0.5, 0.5)  xRadius:_radius yRadius:_radius];
    NSBezierPath *checkPath = [NSBezierPath bezierPath];
    [checkPath moveToPoint: NSMakePoint(3, 8)];
    [checkPath curveToPoint: NSMakePoint(7, 5) controlPoint1: NSMakePoint(7, 5) controlPoint2: NSMakePoint(7, 5)];
    [checkPath lineToPoint: NSMakePoint(13, 13)];
    
    NSBezierPath *mixedPath = [NSBezierPath bezierPath];
    [mixedPath moveToPoint:NSMakePoint(6, size.height/2)];
    [mixedPath lineToPoint:NSMakePoint(10, size.height/2)];
    
    if (NSEqualSizes(image.size, NSZeroSize)) {
        return nil;
    }
    [image lockFocus];
    [NSGraphicsContext saveGraphicsState];
    
    [_boxBorderColor setStroke];
    borderPath.lineWidth = 1;
    borderPath.lineJoinStyle = NSBevelLineJoinStyle;
    [borderPath stroke];
    
    int status = [((NSNumber *)self.objectValue) intValue];
    if(-1 == status)
    {
        [_boxFillColor set];
        [borderPath fill];
        
        [_boxTickColor setStroke];
        [mixedPath setLineWidth:4.0];
        mixedPath.lineCapStyle = NSButtLineCapStyle;
        mixedPath.lineJoinStyle = NSRoundLineJoinStyle;
        [mixedPath stroke];
        
    }
    else if(1 == status)
    {
        [_boxFillColor set];
        [borderPath fill];
        [_boxTickColor setStroke];
        [checkPath setLineWidth:2.5];
        checkPath.lineCapStyle = NSButtLineCapStyle;
        checkPath.lineJoinStyle = NSMiterLineJoinStyle;
        [checkPath stroke];
    }
    else
    {
        [_bgColor set];
        [borderPath fill];
    }
    
    [NSGraphicsContext restoreGraphicsState];
    [image unlockFocus];
    return image;
   
}

-(NSImage *)drawStyle_1:(NSSize)size
{
    size.height -= 4;
    size.width -= 4;
    NSImage *image = [[NSImage alloc] initWithSize:size];
    NSRect rctBorder = NSMakeRect(0, 0, image.size.width,image.size.height);
    
    NSBezierPath *borderPath = [NSBezierPath bezierPathWithRoundedRect:NSInsetRect(rctBorder, 0.5, 0.5)  xRadius:_radius yRadius:_radius];
    NSBezierPath *checkPath = [NSBezierPath bezierPath];
    [checkPath moveToPoint: NSMakePoint(4, 8)];
    [checkPath curveToPoint: NSMakePoint(6, 3) controlPoint1: NSMakePoint(6, 3) controlPoint2: NSMakePoint(6, 3)];
    [checkPath lineToPoint: NSMakePoint(12, 11.5)];
    
    NSBezierPath *mixedPath = [NSBezierPath bezierPath];
    [mixedPath moveToPoint:NSMakePoint(2, size.height/2)];
    [mixedPath lineToPoint:NSMakePoint(12, size.height/2)];
    
    if (NSEqualSizes(image.size, NSZeroSize)) {
        return nil;
    }
    [image lockFocus];
    [NSGraphicsContext saveGraphicsState];
    
    [_boxBorderColor setStroke];
    borderPath.lineWidth = 1;
    borderPath.lineJoinStyle = NSBevelLineJoinStyle;
    [borderPath stroke];
    
    int status = [((NSNumber *)self.objectValue) intValue];
    if(-1 == status)
    {
        [_boxFillColor set];
        [borderPath fill];
        
        [_boxTickColor setStroke];
        [mixedPath setLineWidth:2.0];
        mixedPath.lineCapStyle = NSRoundLineCapStyle;
        mixedPath.lineJoinStyle = NSRoundLineJoinStyle;
        [mixedPath stroke];
        
    }
    else if(1 == status)
    {
        [_boxFillColor set];
        [borderPath fill];
        [_boxTickColor setStroke];
        [checkPath setLineWidth:2.0];
        checkPath.lineCapStyle = NSRoundLineCapStyle;
        checkPath.lineJoinStyle = NSRoundLineJoinStyle;
        [checkPath stroke];
    }
    else
    {
        if(!_bgColor)
           [[NSColor whiteColor] set];
        else
           [_bgColor set];
        [borderPath fill];
    }
    
    [NSGraphicsContext restoreGraphicsState];
    [image unlockFocus];
    return image;
}
@end
