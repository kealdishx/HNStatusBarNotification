//
//  HNStatusBarView.m
//  HNStatusBarNotification
//
//  Created by 许浩男 on 16/4/4.
//  Copyright © 2016年 Zakariyya. All rights reserved.
//

#import "HNStatusBarView.h"

@implementation HNStatusBarView

- (instancetype)init{
    if (self = [super init]) {
        [self defaultConfig];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self defaultConfig];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self defaultConfig];
    }
    return self;
}

- (void)defaultConfig{
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor redColor];
    self.opaque = YES;
    self.frame = CGRectMake(0, -statusHeight, ScreenWidth, statusHeight);
}

#pragma mark - lazy load
- (UIActivityIndicatorView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _indicatorView.hidesWhenStopped = YES;
        _indicatorView.transform = CGAffineTransformMakeScale(0.7, 0.7);
        [self addSubview:_indicatorView];
    }
    return _indicatorView;
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = self.bounds;
        _progressView.tintColor = [UIColor blueColor];
        [_progressView setProgress:0.0f];
        [self addSubview:_progressView];
    }
    return _progressView;
}

- (CATextLayer *)titleLayer{
    if (!_titleLayer) {
        _titleLayer = [CATextLayer layer];
        _titleLayer.contentsScale = [UIScreen mainScreen].scale;
        _titleLayer.wrapped = YES;
        _titleLayer.foregroundColor = [UIColor blackColor].CGColor;
        _titleLayer.fontSize = 14.0f;
        _titleLayer.alignmentMode = kCAAlignmentCenter;
        _titleLayer.frame = self.bounds;
        _titleLayer.position = CGPointMake(ScreenWidth * 0.5, statusHeight * 0.6);
        [self.layer addSublayer:_titleLayer];
    }
    return _titleLayer;
}




@end
