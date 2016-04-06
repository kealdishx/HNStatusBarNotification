//
//  HNStatusNotiConfig.h
//  HNStatusBarNotification
//
//  Created by 许浩男 on 16/4/5.
//  Copyright © 2016年 Zakariyya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HNStatusNotiConfig : NSObject

// notification text font name.default is systemFont
@property (nonatomic,strong,nullable) NSString *textFontName;

// notification view's backgroundColor,default is black
@property (nonatomic,strong,nullable) UIColor *backColor;

// notification text color,default is white
@property (nonatomic,strong,nullable) UIColor *textColor;

// progressView's tintColor,default is white
@property (nonatomic,strong,nullable) UIColor *progressViewTintColor;

// progressView's trackTintColor,default is clearColor
@property (nonatomic,strong,nullable) UIColor *progressViewTrackTintColor;






@end
