//
//  HNStatusNotiConfig.m
//  HNStatusBarNotification
//
//  Created by 许浩男 on 16/4/5.
//  Copyright © 2016年 Zakariyya. All rights reserved.
//

#import "HNStatusNotiConfig.h"

@implementation HNStatusNotiConfig

- (instancetype)init{
    if (self = [super init]) {
        _textFontName = [[NSUserDefaults standardUserDefaults] objectForKey:@"font"];
        _backColor = [UIColor blackColor];
        _textColor = [UIColor whiteColor];
        _progressViewTintColor = [UIColor whiteColor];
        _progressViewTrackTintColor = [UIColor clearColor];
    }
    return self;
}

@end
