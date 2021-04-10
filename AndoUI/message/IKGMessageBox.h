//
//  IKGMessageBox.h
//  IKGUIKit
//
//  Created by dong on 2020/6/24.
//  Copyright © 2020 IKDong. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger,IKGModelRespode){
    IKGModalResponseClose = -1,
    IKGModalResponseOK,
    IKGModalResponseCancel,
    IKGModalResponseAlert
};

typedef NS_ENUM(NSInteger,IKGMessageImageType)
{
    IKGMessageImageError,
    IKGMessageImageWearing,
    IKGMessageImageOK
};

@interface IKGMessageBox : NSWindowController

+ (IKGModelRespode)runMessageBox:(IKGMessageImageType)imageType title:(NSString*)title firstButton:(NSString*)btnString;

+ (IKGModelRespode)runMessageBox:(IKGMessageImageType)imageType title:(NSString*)title firstButton:(NSString*)btnString1 secondButton:(NSString*)btnstring2;

+ (IKGModelRespode)runMessageBox:(IKGMessageImageType)imageType title:(NSString*)title firstButton:(NSString*)btnString1 secondButton:(nullable NSString*)btnString2 threeButton:(nullable NSString*)btnString3;




@end

NS_ASSUME_NONNULL_END
