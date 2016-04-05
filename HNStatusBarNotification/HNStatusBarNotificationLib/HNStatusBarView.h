//
//  HNStatusBarView.h
//  HNStatusBarNotification
//
//  Created by 许浩男 on 16/4/4.
//  Copyright © 2016年 Zakariyya. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

static const CGFloat statusHeight = 20.0f;

@interface HNStatusBarView : UIView

@property (nonatomic,strong) CATextLayer *titleLayer;

@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic,strong) UIProgressView *progressView;

@end
