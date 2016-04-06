//
//  HNStatusBarNotiManager.h
//  HNStatusBarNotification
//
//  Created by 许浩男 on 16/4/4.
//  Copyright © 2016年 Zakariyya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HNStatusNotiConfig.h"

typedef void (^completionBlock)();

@interface HNStatusBarNotiManager : NSObject

#pragma mark - presentation

+ (void)showStatusWithText:(NSString *)title;

+ (void)showStatusWithText:(NSString *)title config:(HNStatusNotiConfig *)config;

+ (void)showStatusWithText:(NSString *)title duration:(NSTimeInterval)duration completion:(completionBlock)completion config:(HNStatusNotiConfig *)config;

+ (void)showIndicatorViewWithStyle:(UIActivityIndicatorViewStyle)style;

+ (void)showProgress:(CGFloat)progress;

#pragma mark - dismiss
+ (void)dismissWithCompletion:(completionBlock)completion;

+ (void)dismissAfterInterval:(NSTimeInterval)interval completion:(completionBlock)completion;

@end
