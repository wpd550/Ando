//
//  IKButton.m
//  iKIGAI_Download
//
//  Created by dong on 2020/7/8.
//  Copyright © 2020 IKDong. All rights reserved.
//
#import "IKButton.h"


typedef NS_ENUM(NSInteger,MouseState){
    MouseNormal,
    MouseTint,
    MouseDown,
    MouseDisable
};


@interface IKButton () <CALayerDelegate>
{
    BOOL _enableClick;
}

@property (nonatomic, strong) CAShapeLayer *imageLayer;
@property (nonatomic, strong) CATextLayer *titleLayer;
@property (nonatomic, assign) BOOL mouseDown;
@property (nonatomic, assign)MouseState mouseState;

@end

@implementation IKButton

#pragma mark - Lifecycle

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
        [self setupImageLayer];
        [self setupTitleLayer];
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        [self setup];
        [self setupImageLayer];
        [self setupTitleLayer];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addTrackingArea:[[NSTrackingArea alloc] initWithRect:self.bounds options:NSTrackingActiveAlways|NSTrackingInVisibleRect|NSTrackingMouseEnteredAndExited owner:self userInfo:nil]];
    self.enabled = self.enabled;
//    [self resetWidthFrame];
}

//- (void)viewWillDraw{
//    [self resetWidthFrame];
//}

- (void)updataFrameofWidth{
    if(self.widthOfContraint){
        [self sizeToFit];
        
        if(self.widthOfContraint.constant < NSWidth(self.frame)){
            self.widthOfContraint.constant = NSWidth(self.frame);
        }
    }
}

#pragma mark - Drawing method

- (void)drawRect:(NSRect)dirtyRect {
    // Do nothing
}

- (BOOL)layer:(CALayer *)layer shouldInheritContentsScale:(CGFloat)newScale fromWindow:(NSWindow *)window {
    return YES;
}

#pragma mark - Setup method

- (void)setup {
    // Setup layer
    self.wantsLayer = YES;
    self.layer.masksToBounds = YES;
    self.layer.delegate = self;
    self.layer.backgroundColor = [NSColor redColor].CGColor;
    self.alphaValue = self.isEnabled ? 1.0 : 0.5;
    _enableClick = YES;
    _mouseState = MouseNormal;
   
}

- (void)setupImageLayer {
    // Ignore image layer if has no image or imagePosition equal to NSNoImage
    if (!self.image || self.imagePosition == NSNoImage) {
        [self.imageLayer removeFromSuperlayer];
        return;
    }
    
    CGSize buttonSize = self.frame.size;
  
    CGSize imageSize = self.image.size;
//    if(self.imageSize.width)
    {
        imageSize = CGSizeMake(18, 18);
    }
    CGSize titleSize = [self.title sizeWithAttributes:@{NSFontAttributeName: self.font}];
    CGFloat x = 0.0; // Image's origin x
    CGFloat y = 0.0; // Image's origin y
    
    // Caculate the image's and title's position depends on button's imagePosition and imageHugsTitle property
    switch (self.imagePosition) {
        case NSNoImage:
            return;
            break;
        case NSImageOnly: {
            x = (buttonSize.width - imageSize.width) / 2.0;
            y = (buttonSize.height - imageSize.height) / 2.0;
            break;
        }
        case NSImageOverlaps: {
            x = (buttonSize.width - imageSize.width) / 2.0;
            y = (buttonSize.height - imageSize.height) / 2.0;
            break;
        }
        case NSImageLeading:
        case NSImageLeft: {
//            x = self.imageHugsTitle ? ((buttonSize.width - imageSize.width - titleSize.width) / 2.0 - self.spacing) : self.spacing;
            x = self.spacing;
            y = (buttonSize.height - imageSize.height) / 2.0;
            break;
        }
        case NSImageTrailing:
        case NSImageRight: {
            if (@available(macOS 10.12, *)) {
                x = self.imageHugsTitle ? ((buttonSize.width - imageSize.width + titleSize.width) / 2.0 + self.spacing) : (buttonSize.width - imageSize.width - self.spacing);
            } else {
                // Fallback on earlier versions
            }
            y = (buttonSize.height - imageSize.height) / 2.0;
            break;
        }
        case NSImageAbove: {
            x = (buttonSize.width - imageSize.width) / 2.0;
            if (@available(macOS 10.12, *)) {
                y = self.imageHugsTitle ? ((buttonSize.height - imageSize.height - titleSize.height) / 2.0 - self.spacing) : self.spacing;
            } else {
                // Fallback on earlier versions
            }
            break;
        }
        case NSImageBelow: {
            x = (buttonSize.width - imageSize.width) / 2.0;
            if (@available(macOS 10.12, *)) {
                y = self.imageHugsTitle ? ((buttonSize.height - imageSize.height + titleSize.height) / 2.0 + self.spacing) : (buttonSize.height - imageSize.height - self.spacing);
            } else {
                // Fallback on earlier versions
            }
            break;
        }
        default: {
            break;
        }
    }
    
    // Setup image layer
    self.imageLayer.frame = self.bounds;
    self.imageLayer.mask = ({
        CALayer *layer = [CALayer layer];
        NSRect rect = NSMakeRect(round(x), round(y), imageSize.width, imageSize.height);
        layer.frame = rect;
        layer.contents = (__bridge id _Nullable)[self.image CGImageForProposedRect:&rect context:nil hints:nil];
        layer;
    });
    [self.layer addSublayer:self.imageLayer];
}

- (void)setupTitleLayer {
    // Ignore title layer if has no title or imagePosition equal to NSImageOnly
    if (!self.title || self.imagePosition == NSImageOnly) {
        [self.titleLayer removeFromSuperlayer];
        return;
    }
    
    CGSize buttonSize = self.frame.size;
    CGSize imageSize = self.image.size;
    CGSize titleSize = [self.title sizeWithAttributes:@{NSFontAttributeName: self.font}];
    CGFloat x = 0.0; // Title's origin x
    CGFloat y = 0.0; // Title's origin y
    
    // Caculate the image's and title's position depends on button's imagePosition and imageHugsTitle property
    switch (self.imagePosition) {
        case NSImageOnly: {
            return;
            break;
        }
        case NSNoImage: {
            x = (buttonSize.width - titleSize.width) / 2.0;
            y = (buttonSize.height - titleSize.height) / 2.0;
            break;
        }
        case NSImageOverlaps: {
            x = (buttonSize.width - titleSize.width) / 2.0;
            y = (buttonSize.height - titleSize.height) / 2.0;
            break;
        }
        case NSImageLeading:
        case NSImageLeft: {
//            x = self.imageHugsTitle ? ((buttonSize.width + imageSize.width - titleSize.width) / 2.0 + self.spacing) : (buttonSize.width - titleSize.width - self.spacing);
            x = (buttonSize.width - titleSize.width - imageSize.width -self.spacing)/2.0 + imageSize.width + self.spacing;
            y = (buttonSize.height - titleSize.height) / 2.0;
            break;
        }
        case NSImageTrailing:
        case NSImageRight: {
            if (@available(macOS 10.12, *)) {
                x = self.imageHugsTitle ? ((buttonSize.width - imageSize.width - titleSize.width) / 2.0 - self.spacing) : self.spacing;
            } else {
                // Fallback on earlier versions
            }
            y = (buttonSize.height - titleSize.height) / 2.0;
            break;
        }
        case NSImageAbove: {
            x = (buttonSize.width - titleSize.width) / 2.0;
            if (@available(macOS 10.12, *)) {
                y = self.imageHugsTitle ? ((buttonSize.height + imageSize.height - titleSize.height) / 2.0 + self.spacing) : (buttonSize.height - titleSize.height - self.spacing);
            } else {
                // Fallback on earlier versions
            }
            break;
        }
        case NSImageBelow: {
            if (@available(macOS 10.12, *)) {
                y = self.imageHugsTitle ? ((buttonSize.height - imageSize.height - titleSize.height) / 2.0 - self.spacing) : self.spacing;
            } else {
                // Fallback on earlier versions
            }
            x = (buttonSize.width - titleSize.width) / 2.0;
            break;
        }
        default: {
            break;
        }
    }
    
    // Setup title layer
    self.titleLayer.frame = NSMakeRect(round(x), round(y), ceil(titleSize.width), ceil(titleSize.height));
    self.titleLayer.string = self.title;
    self.titleLayer.font = (__bridge CFTypeRef _Nullable)(self.font);
    self.titleLayer.fontSize = self.font.pointSize;
    [self.layer addSublayer:self.titleLayer];
}

#pragma mark - Animation method

- (void)removeAllAnimations {
    [self.layer removeAllAnimations];
    [self.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull layer, NSUInteger index, BOOL * _Nonnull stop) {
        [layer removeAllAnimations];
    }];
}

- (void)animateColorWithMouseState:(MouseState)mouseState{
    [self removeAllAnimations];
    CGFloat duration =  self.onAnimateDuration;
    NSColor *borderColor;
    NSColor *backgroundColor;
    NSColor *titleColor;
    NSColor *imageColor;
    
    switch (mouseState) {
        case MouseNormal:
        {
            borderColor     = self.borderNormalColor;
            backgroundColor = self.backgroundNormalColor;
            imageColor      = self.imageNormalColor;
            titleColor      = self.titleNormalColor;
        }break;
        case MouseTint:{
            borderColor     = self.borderTintColor;
            backgroundColor = self.backgroundTintColor;
            imageColor      = self.imageTintColor;
            titleColor      = self.titleTintColor;
        }break;
        case MouseDown:{
            borderColor     = self.borderHighlightColor;
            backgroundColor = self.backgroundHighlightColor;
            imageColor      = self.imageHighlightColor;
            titleColor      = self.titleHighlightColor;
        }break;
        case MouseDisable:{
            borderColor     = self.borderDisableColor;
            backgroundColor = self.backgroundDisableColor;
            imageColor      = self.imageDisableColor;
            titleColor      = self.titleDisableColor;
        }break;
        default:
        {
            borderColor     = self.borderNormalColor;
            backgroundColor = self.backgroundNormalColor;
            imageColor      = self.imageNormalColor;
            titleColor      = self.titleNormalColor;
        }
    }
    
    [self animateBackgroundColor:backgroundColor bordeColor:borderColor imageColor:imageColor titleColor:titleColor duration:duration];
}


- (void)animateColorWithState:(NSCellStateValue)state {
    [self removeAllAnimations];
    CGFloat duration = (state == NSOnState) ? self.onAnimateDuration : self.offAnimateDuration;
    NSColor *borderColor = (state == NSOnState) ? self.borderTintColor : self.borderNormalColor;
    NSColor *backgroundColor = (state == NSOnState) ? self.backgroundTintColor : self.backgroundNormalColor;
    NSColor *titleColor = (state == NSOnState) ? self.titleTintColor : self.titleNormalColor;
    NSColor *imageColor = (state == NSOnState) ? self.imageTintColor : self.imageNormalColor;
    [self animateBackgroundColor:backgroundColor bordeColor:borderColor imageColor:imageColor titleColor:titleColor duration:duration];
}

- (void)animateColorWithEnable:(BOOL)enable {
    [self removeAllAnimations];
    NSColor *borderColor = enable ? self.borderNormalColor : self.borderDisableColor;
    NSColor *backgroundColor = enable ? self.backgroundNormalColor : self.backgroundDisableColor;
    NSColor *titleColor = enable ? self.titleNormalColor : self.titleDisableColor;
    NSColor *imageColor =enable ? self.imageNormalColor : self.imageDisableColor;
    CGFloat duration = enable ? self.onAnimateDuration : self.offAnimateDuration;

    [self animateBackgroundColor:backgroundColor bordeColor:borderColor imageColor:imageColor titleColor:titleColor duration:duration];
}


- (void)animateBackgroundColor:(NSColor*)backgroundColor bordeColor:(NSColor*)borderColor imageColor:(NSColor*)imageColor titleColor:(NSColor*)titleColor duration:(CGFloat)duration{
    [self removeAllAnimations];
    [self animateLayer:self.layer color:borderColor keyPath:@"borderColor" duration:duration];
    [self animateLayer:self.layer color:backgroundColor keyPath:@"backgroundColor" duration:duration];
    [self animateLayer:self.imageLayer color:imageColor keyPath:@"backgroundColor" duration:duration];
    [self animateLayer:self.titleLayer color:titleColor keyPath:@"foregroundColor" duration:duration];
    
}



- (void)animateLayer:(CALayer *)layer color:(NSColor *)color keyPath:(NSString *)keyPath duration:(CGFloat)duration {
    CGColorRef oldColor = (__bridge CGColorRef)([layer valueForKeyPath:keyPath]);
    if (!(CGColorEqualToColor(oldColor, color.CGColor))) {
//        NSLog(@"change color");
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
        animation.fromValue = [layer valueForKeyPath:keyPath];
        animation.toValue = (id)color.CGColor;
        animation.duration = duration;
        animation.removedOnCompletion = NO;
        [layer addAnimation:animation forKey:keyPath];
        [layer setValue:(id)color.CGColor forKey:keyPath];
    }
}

#pragma mark - Event Response

- (NSView *)hitTest:(NSPoint)point {
    return self.isEnabled ? [super hitTest:point] : nil;
}

- (void)mouseDown:(NSEvent *)event {
    if ([event clickCount] > 1 || !self.enabled){
        return;
    }
    self.mouseDown = YES;
    self.mouseState = MouseDown;
}

- (void)mouseEntered:(NSEvent *)event {
    if (self.enabled) {
//        self.state = NSOnState;
        self.mouseState = MouseTint;
    }
}

- (void)mouseExited:(NSEvent *)event {
    if (self.enabled) {
//        self.state = NSOffState;
        self.mouseState = MouseNormal;
    }}

- (void)mouseUp:(NSEvent *)event {
    [super mouseUp:event];
    if ([event clickCount] > 1 || !self.enabled){
        return;
    }
    
    if (self.mouseDown) {
        self.mouseDown = NO;
        if (self.momentary) {
            self.mouseState = MouseNormal;
        }else{
            self.state = NSOnState;
        }
        
        if (_enableClick) {
            _enableClick = NO;
            [NSApp sendAction:self.action to:self.target from:self];
//            NSLog(@">>> sendAction: %@, %@", self.target,NSStringFromSelector(self.action));

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                self->_enableClick = YES;
            });
        }
    }
}

#pragma mark - Property method

- (void)setFrame:(NSRect)frame {
    [super setFrame:frame];
    [self setupTitleLayer];
}

- (void)setFont:(NSFont *)font {
    [super setFont:font];
    [self setupTitleLayer];
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    [self setupTitleLayer];
    [self updataFrameofWidth];
}

- (void)setImage:(NSImage *)image {
    [super setImage:image];
    [self setupImageLayer];
}

- (void)setState:(NSInteger)state {
    [super setState:state];
    [self animateColorWithState:state];
}

- (void)setMouseState:(MouseState)mouseState{
    _mouseState = mouseState;
    [self animateColorWithMouseState:mouseState];
    
}



- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    self.mouseState = enabled ? MouseNormal:MouseDisable;
}

- (void)setImagePosition:(NSCellImagePosition)imagePosition {
    [super setImagePosition:imagePosition];
    [self setupImageLayer];
    [self setupTitleLayer];
}

- (void)setMomentary:(BOOL)momentary {
    _momentary = momentary;
    [self animateColorWithState:self.state];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = _cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.layer.borderWidth = _borderWidth;
}

- (void)setSpacing:(CGFloat)spacing {
    _spacing = spacing;
    [self setupImageLayer];
    [self setupTitleLayer];
}

- (void)setBorderNormalColor:(NSColor *)borderNormalColor {
    _borderNormalColor = borderNormalColor;
    [self animateColorWithState:self.state];
}

- (void)setBorderHighlightColor:(NSColor *)borderHighlightColor {
    _borderHighlightColor = borderHighlightColor;
    [self animateColorWithState:self.state];
}

- (void)setBackgroundNormalColor:(NSColor *)backgroundNormalColor {
    _backgroundNormalColor = backgroundNormalColor;
    [self animateColorWithState:self.state];
}

- (void)setBackgroundHighlightColor:(NSColor *)backgroundHighlightColor {
    _backgroundHighlightColor = backgroundHighlightColor;
    [self animateColorWithState:self.state];
}

- (void)setImageNormalColor:(NSColor *)imageNormalColor {
    _imageNormalColor = imageNormalColor;
    [self animateColorWithState:self.state];
}

- (void)setImageHighlightColor:(NSColor *)imageHighlightColor {
    _imageHighlightColor = imageHighlightColor;
    [self animateColorWithState:self.state];
}

- (void)setTitleNormalColor:(NSColor *)titleNormalColor {
    _titleNormalColor = titleNormalColor;
    [self animateColorWithState:self.state];
}

- (void)setTitleHighlightColor:(NSColor *)titleHighlightColor {
    _titleHighlightColor = titleHighlightColor;
    [self animateColorWithState:self.state];
}

- (CAShapeLayer *)imageLayer {
    if (_imageLayer == nil) {
        _imageLayer = [[CAShapeLayer alloc] init];
        _imageLayer.delegate = self;
        _imageLayer.contentsGravity = kCAGravityCenter;
        }
    return _imageLayer;
}

- (CATextLayer *)titleLayer {
    if (_titleLayer == nil) {
        _titleLayer = [[CATextLayer alloc] init];
        _titleLayer.delegate = self;
    }
    return _titleLayer;
}

@end
