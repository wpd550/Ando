//
//  IKClipTextField.h
//  iKIGAI_Download
//
//  Created by dong on 2020/6/15.
//  Copyright © 2020 IKDong. All rights reserved.
//

#import "IKCheckBox.h"
#import "IKCheckBoxCell.h"

@implementation IKCheckBox
@synthesize underLined = _underLined;
@synthesize detaY = _detaY;
@synthesize bgColor = _bgColor;
@synthesize titleColor = _titleColor;
@synthesize boxFillColor = _boxFillColor;
@synthesize boxTickColor = _boxTickColor;
@synthesize boxBorderColor = _boxBorderColor;
@synthesize font = _font;
@synthesize attributedTitle = _attributedTitle;

#pragma mark - Override Methods
+(Class)cellClass{
    return [IKCheckBoxCell class];
}


-(instancetype)init{
    if (self = [super init]) {
        [self __initializeTUICheckbox];
    }
    return self;
}

-(instancetype) initWithCoder:(NSCoder *)coder
{
    
    /*BOOL sub = YES;
    
    sub = sub && [coder isKindOfClass: [NSKeyedUnarchiver class]]; // no support for 10.1 nibs
    sub = sub && ![self isMemberOfClass: [NSControl class]]; // no raw NSControls
    sub = sub && [[self superclass] cellClass] != nil; // need to have something to substitute
    sub = sub && [[self superclass] cellClass] != [[self class] cellClass]; // pointless if same
    
    if( !sub )
    {
        self = [super initWithCoder: coder];
    }
    else
    {
        NSKeyedUnarchiver *Newcoder = (id)coder;
        
        // gather info about the superclass's cell and save the archiver's old mapping
        Class superCell = [[self superclass] cellClass];
        NSString *oldClassName = NSStringFromClass( superCell );
        Class oldClass = [Newcoder classForClassName: oldClassName];
        if( !oldClass )
            oldClass = superCell;
        
        // override what comes out of the unarchiver
        [Newcoder setClass: [[self class] cellClass] forClassName: oldClassName];
        
        // unarchive
        self = [super initWithCoder: coder];
        
        // set it back
        [Newcoder setClass: oldClass forClassName: oldClassName];
    }
*/
    if (self = [super initWithCoder:coder]) {
        [self __initializeTUICheckbox];
    }
    return self;
}

-(instancetype)initWithFrame:(NSRect)frameRect{
    if (self = [super initWithFrame:frameRect]) {
        [self __initializeTUICheckbox];
    }
    return self;
}

#pragma mark - Public Methods

-(NSInteger)detaY{
    IKCheckBoxCell *cell = [self cell];
    return [cell detaY];
}

-(void)setDetaY:(NSInteger)nValue{
    IKCheckBoxCell *cell = [self cell];
    [cell setDetaY:nValue];
    [self setNeedsDisplay:YES];
}

-(void)setTitle:(NSString *)title{
    [super setTitle:title];
    _buttonFlags.isNormalStringValue = YES;
    _attributedTitle = nil;
    [self __updateLookup];
}

-(NSString *)title{
    return [super title];
}

-(void)setTitleColor:(NSColor *)titleColor{
    _titleColor = titleColor;
    _buttonFlags.isNormalStringValue = YES;
    [self __updateLookup];
}

-(void)setBoxstyle:(NSUInteger)boxstyle
{
    _boxstyle = boxstyle;
    IKCheckBoxCell *cell = [self cell];
    cell.boxStyle = boxstyle;
//    self.bezelStyle
}

-(void)setBgColor:(NSColor *)bgColor
{
    _bgColor = [bgColor copy];
    IKCheckBoxCell *cell = [self cell];
    cell.bgColor = bgColor;
}

-(void)setBoxFillColor:(NSColor *)boxFillColor
{
    _boxFillColor = [boxFillColor copy];
    
    IKCheckBoxCell *cell = [self cell];
    cell.boxFillColor = boxFillColor;
}


- (void)setRadius:(CGFloat)radius
{
    _radius = radius;
    IKCheckBoxCell *cell = [self cell];
    cell.radius = radius;
}

-(void)setBoxTickColor:(NSColor *)boxTickColor
{
    _boxTickColor = [boxTickColor copy];
    
    IKCheckBoxCell *cell = [self cell];
    cell.boxTickColor = boxTickColor;
}

-(void)setBoxBorderColor:(NSColor *)boxBorderColor
{
    _boxBorderColor = [boxBorderColor copy];
    
    IKCheckBoxCell *cell = [self cell];
    cell.boxBorderColor = boxBorderColor;
}

-(NSColor *)titleColor{
    return _titleColor;
}

-(void)setFont:(NSFont *)font{
    _font = font;
    _buttonFlags.isNormalStringValue = YES;
    [self __updateLookup];
}

-(NSFont *)font{
    return _font;
}

-(void)setUnderLined:(BOOL)underLined{
    _buttonFlags.isUnderLined = underLined;
    _buttonFlags.isNormalStringValue = YES;
    [self __updateLookup];
}

-(BOOL)isUnderLined{
    return _buttonFlags.isUnderLined;
}

-(void)setAttributedTitle:(NSAttributedString *)attributedTitle{
    _attributedTitle = attributedTitle;
    _buttonFlags.isNormalStringValue = NO;
    [super setTitle:@""];
    [self __updateLookup];
}

-(NSAttributedString *)attributedTitle{
    return [super attributedTitle];
}

#pragma mark - Private Methods

-(void)__initializeTUICheckbox{
    _buttonFlags.isNormalStringValue = YES;
    _buttonFlags.isUnderLined = NO;
    _titleColor = [NSColor blackColor];
    self.boxFillColor = [NSColor blueColor];
    self.boxTickColor = [NSColor redColor];
    self.boxBorderColor = [NSColor grayColor];
    self.bgColor = [NSColor whiteColor];
    self.font = [NSFont fontWithName:@"Helvetica Neue" size:14];
}

-(void)__updateLookup{
    if (_buttonFlags.isNormalStringValue) {
        [super setAttributedTitle:[self createLookUpAttributeString]];
    }else{
        [super setAttributedTitle:_attributedTitle];
    }
    [self setNeedsDisplay];
}

-(NSAttributedString *)createLookUpAttributeString{
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc]initWithString: super.title];
    [attrString beginEditing];

    NSUInteger nLen = [attrString length];
    NSColor *stringColor = _titleColor;
    [attrString addAttribute:NSForegroundColorAttributeName value:stringColor range:NSMakeRange(0, nLen)];
    [attrString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, nLen)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    [paragraphStyle setAlignment:self.alignment];
    if (nil != paragraphStyle) {
        [attrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,nLen)];
    }

    [attrString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:(_buttonFlags.isUnderLined  ? NSUnderlineStyleSingle : NSUnderlineStyleNone)] range:NSMakeRange(0, nLen)];

    [attrString endEditing];
    return attrString;
}

@end
