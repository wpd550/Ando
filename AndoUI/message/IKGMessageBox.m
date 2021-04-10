//
//  IKGMessageBox.m
//  IKGUIKit
//
//  Created by dong on 2020/6/24.
//  Copyright © 2020 IKDong. All rights reserved.
//

#import "IKGMessageBox.h"

@interface IKGMessageBox ()<NSWindowDelegate>
{
    
}

@property(assign) IKGModelRespode result;


@property(weak) IBOutlet NSImageView *imageView;
@property(weak) IBOutlet NSTextField *contentLabel;


@property(weak) IBOutlet NSButton *firstBtn;
@property(weak) IBOutlet NSButton *secondBtn;
@property(weak) IBOutlet NSButton *threeBtn;

@property(copy) NSString *contentString;
@property(assign) IKGMessageImageType imageType;

@property(strong) NSMutableArray *buttonInfoArray;


@end

@implementation IKGMessageBox


- (instancetype)initWithCoder:(NSCoder *)coder
{
    if(self = [super initWithCoder:coder])
    {
       
    }
    return self;
}


- (instancetype)initWithWindowNibName:(NSNibName)windowNibName owner:(id)owner
{
    if(self = [super initWithWindowNibName:windowNibName owner:owner])
    {
        _result = IKGModalResponseClose;
        _buttonInfoArray = [NSMutableArray arrayWithCapacity:3];
    }
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    


    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    
    for(int i = 0;i<[self.buttonInfoArray count];i++)
    {
        if(i == 0)
        {
            [self.firstBtn setHidden:NO];
            self.firstBtn.title = self.buttonInfoArray[i];
        }else if (1 == i)
        {
            [self.secondBtn setHidden:NO];
            self.secondBtn.title = self.buttonInfoArray[i];
        }else if(2 == i)
        {
            [self.threeBtn setHidden:NO];
            self.threeBtn.title = self.buttonInfoArray[i];
        }
    }
    
    self.contentLabel.stringValue = self.contentString;
//    [self setImageType:self.imageType];
}

- (void)windowWillClose:(NSNotification *)notification
{
    [NSApp stopModalWithCode: self.result];
}


- (IBAction)btnAction:(NSButton*)sender
{
    self.result = (IKGModelRespode)sender.tag;
    [self close];
}

+ (IKGModelRespode)runMessageBox:(IKGMessageImageType)imageType title:(NSString*)title firstButton:(NSString*)btnString
{
    return [IKGMessageBox runMessageBox:imageType title:title firstButton:btnString secondButton:nil threeButton:nil];
}

+ (IKGModelRespode)runMessageBox:(IKGMessageImageType)imageType title:(NSString*)title firstButton:(NSString*)btnString1 secondButton:(NSString*)btnstring2
{
    return [IKGMessageBox runMessageBox:imageType title:title firstButton:btnString1 secondButton:btnstring2 threeButton:nil];
}

+ (IKGModelRespode)runMessageBox:(IKGMessageImageType)imageType title:(NSString*)title firstButton:(NSString*)btnString1 secondButton:(NSString*)btnString2 threeButton:(NSString*)btnString3
{
    
    IKGMessageBox *box = [[IKGMessageBox alloc] initWithWindowNibName:[self className]];
    
    [box.buttonInfoArray addObject:btnString1];
    
    box.contentString = title;
    box.firstBtn.title = btnString1;
    if(btnString2)
    {
       [box.buttonInfoArray addObject:btnString2];
    }
    if(btnString3)
    {
        [box.buttonInfoArray addObject:btnString3];
    }
    [box.window center];
    
   return  [NSApp runModalForWindow:box.window];
    
}

- (void)setImageViewWith:(IKGMessageImageType)imagetype
{
    NSImage* image = nil;
    switch (imagetype) {
        case IKGMessageImageOK:
        {
            image = [NSImage imageNamed:@"IKGMessageImageOK"];
        }break;
        case IKGMessageImageError:
        {
            image = [NSImage imageNamed:@"IKGMessageImageError"];
        }break;
        case IKGMessageImageWearing:
        {
            image = [NSImage imageNamed:@"IKGMessageImageWearing"];
        }break;
        default:
        {
            image = [NSImage imageNamed:@"IKGMessageImageError"];
        }break;
    }
}

@end
