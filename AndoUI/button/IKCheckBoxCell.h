//
//  IKClipTextField.h
//  iKIGAI_Download
//
//  Created by dong on 2020/6/15.
//  Copyright © 2020 IKDong. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSInteger, CheckBoxStyle)
{
    style_0 = 0,
    style_1,
};

@interface IKCheckBoxCell : NSButtonCell
{
    NSInteger _detaY;
    
    NSColor *_bgColor;
    NSColor *_boxFillColor;
    NSColor *_boxBorderColor;
    NSColor *_boxTickColor;
}

@property (nonatomic,assign) NSInteger detaY;

@property (nonatomic,assign) CheckBoxStyle boxStyle;

@property (nonatomic,copy) NSColor *bgColor;

@property (nonatomic,copy) NSColor *boxFillColor;

@property (nonatomic,copy) NSColor *boxBorderColor;
@property (assign) CGFloat radius;

/**
 勾的颜色
 */
@property (nonatomic,copy) NSColor *boxTickColor;


@end
