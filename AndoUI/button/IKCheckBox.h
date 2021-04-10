//
//  IKClipTextField.h
//  iKIGAI_Download
//
//  Created by dong on 2020/6/15.
//  Copyright © 2020 IKDong. All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import "IKCheckBoxCell.h"

IB_DESIGNABLE
@interface IKCheckBox : NSButton
{
    BOOL _underLined;
    NSInteger _detaY;
    
    NSColor *_titleColor;
    NSColor *_boxFillColor;
    NSColor *_boxBorderColor;
    NSColor *_boxTickColor;
    NSColor *_bgColor;
    
    NSFont *_font;
    
    NSAttributedString  *_attributedTitle;
    
    struct {
        unsigned int isNormalStringValue:1;
        unsigned int isUnderLined:1;
    } _buttonFlags;
    
}

/**
 离按钮底部的距离
 */
@property (nonatomic,assign) NSInteger detaY;

@property (nonatomic,assign) IBInspectable NSUInteger boxstyle;

@property (nonatomic,copy) IBInspectable NSColor *bgColor;

@property (nonatomic,copy) IBInspectable NSColor *titleColor;

@property (nonatomic,copy) IBInspectable NSColor *boxFillColor;

@property (nonatomic,copy) IBInspectable NSColor *boxBorderColor;

@property (nonatomic, assign) IBInspectable CGFloat radius;

/**
 勾的颜色
 */
@property (nonatomic,copy) IBInspectable NSColor *boxTickColor;

@property (nonatomic,copy) NSFont *font;

@property (nonatomic,copy) IBInspectable NSAttributedString *attributedTitle;

@property (nonatomic,assign,getter=isUnerLined) BOOL underLined;
@end
