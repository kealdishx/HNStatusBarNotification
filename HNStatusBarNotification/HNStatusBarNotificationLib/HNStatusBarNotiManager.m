//
//  HNStatusBarNotiManager.m
//  HNStatusBarNotification
//
//  Created by 许浩男 on 16/4/4.
//  Copyright © 2016年 Zakariyya. All rights reserved.
//

#import "HNStatusBarNotiManager.h"
#import "HNStatusBarView.h"
#import <CoreText/CoreText.h>


@interface HNStatusBarNotiManager()

@property (nonatomic,strong) HNStatusBarView *statusView;

@property (nonatomic,assign) CGSize textSize;

@property (nonatomic,strong) NSTimer *dismissTimer;

@property (nonatomic,strong) completionBlock completion;

@end

@implementation HNStatusBarNotiManager

#pragma mark - singleton
+ (instancetype)sharedManager{
    static HNStatusBarNotiManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HNStatusBarNotiManager alloc] init];
    });
    return manager;
}

#pragma mark - class method
+ (void)showStatusWithText:(NSString *)title{
    [[self sharedManager] showStatusWithText:title duration:0 completion:nil config:nil];
}

+ (void)showStatusWithText:(NSString *)title config:(HNStatusNotiConfig *)config{
    [[self sharedManager] showStatusWithText:title duration:0 completion:nil config:config];
}

+ (void)showStatusWithText:(NSString *)title duration:(NSTimeInterval)duration completion:(completionBlock)completion config:(HNStatusNotiConfig *)config{
    [[self sharedManager] showStatusWithText:title duration:duration completion:completion config:config];
}

+ (void)showIndicatorViewWithStyle:(UIActivityIndicatorViewStyle)style{
    [[self sharedManager] showIndicatorViewWithStyle:style];
}

+ (void)showProgress:(CGFloat)progress{
    [[self sharedManager] showProgress:progress];
}

+ (void)dismissWithCompletion:(completionBlock)completion{
    [[self sharedManager] dismissAfterInterval:0 completion:completion];
}

+ (void)dismissAfterInterval:(NSTimeInterval)interval completion:(completionBlock)completion{
    [[self sharedManager] dismissAfterInterval:interval completion:completion];
}

#pragma mark - Implementation
- (HNStatusBarView *)statusView{
    if (!_statusView) {
        _statusView = [[HNStatusBarView alloc] init];
    }
    return _statusView;
}

- (void)showStatusWithText:(NSString *)title duration:(NSTimeInterval)duration completion:(completionBlock)completion config:(HNStatusNotiConfig *)config{
    HNStatusNotiConfig *statusConfig = config;
    if (!config) {
        statusConfig = [[HNStatusNotiConfig alloc] init];
    }
    self.statusView.backgroundColor = statusConfig.backColor;
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:title];
    [attributedText addAttributes:@{NSFontAttributeName : [UIFont fontWithName:statusConfig.textFontName size:[self calculateFontSizeWithText:attributedText fontName:config.textFontName]],NSForegroundColorAttributeName : statusConfig.textColor} range:NSMakeRange(0, title.length - 1)];
    self.statusView.titleLayer.string = attributedText;
    self.statusView.progressView.tintColor = statusConfig.progressViewTintColor;
    self.statusView.progressView.trackTintColor = statusConfig.progressViewTrackTintColor;
    _textSize = [title sizeWithAttributes:@{NSFontAttributeName : [UIFont fontWithName:statusConfig.textFontName size:[self calculateFontSizeWithText:attributedText fontName:config.textFontName]]}];
    if (![UIApplication sharedApplication].statusBarHidden) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.statusView];
        [self makeTranslationWithStatusBar:-statusHeight completion:^{
            [UIView animateWithDuration:0.3f animations:^{
                self.statusView.transform = CGAffineTransformMakeTranslation(0, statusHeight);
            }];
        }];
    }
    else{
        [UIView animateWithDuration:0.3f animations:^{
            self.statusView.transform = CGAffineTransformMakeTranslation(0, statusHeight);
        }];
    }
    duration == 0 ? : [self dismissAfterInterval:duration completion:completion];
    
}

- (CGFloat)calculateFontSizeWithText:(NSMutableAttributedString *)text fontName:(NSString *)name{
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)text);
    CGRect columnRect = CGRectMake(0, 0 , ScreenWidth, statusHeight);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, columnRect);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRange frameRange = CTFrameGetVisibleStringRange(frame);
    CGFloat fontSize = 14.0f;
    while(text.string.length > frameRange.length){
        fontSize -= 0.5;
        CFStringRef fontName = (__bridge CFStringRef)name;
        CTFontRef font = CTFontCreateWithName(fontName, fontSize, NULL);
        [text addAttribute:(NSString *)kCTFontAttributeName
                          value:(__bridge id)font
                          range:NSMakeRange(0, text.string.length)];
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)text);
        CGRect columnRect = CGRectMake(0, 0 , ScreenWidth, statusHeight);
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, columnRect);
        CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
        frameRange = CTFrameGetVisibleStringRange(frame);
    }
    return fontSize;
}

- (void)makeTranslationWithStatusBar:(CGFloat)y completion:(completionBlock)completion{
    UIWindow *statusBarWindow = (UIWindow *)[[UIApplication sharedApplication] valueForKey:[NSString stringWithFormat: @"stat%@indow",@"usBarW"]];
    [UIView animateWithDuration:0.2f animations:^{
        statusBarWindow.transform = CGAffineTransformMakeTranslation(0, y);
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
        
    }];

}

- (void)showIndicatorViewWithStyle:(UIActivityIndicatorViewStyle)style{
    if (_textSize.width > (ScreenWidth - 20 * 2)) {
        return;
    }
    self.statusView.indicatorView.frame = CGRectMake((ScreenWidth - _textSize.width) * 0.5 - 20, 5, 10, 10);
    self.statusView.indicatorView.activityIndicatorViewStyle = style;
    [self.statusView.indicatorView startAnimating];
}

- (void)showProgress:(CGFloat)progress{
    if (progress < 0 || progress > 1.0f || !self.statusView.progressView) {
        return;
    }
    self.statusView.progressView.hidden = NO;
    [self.statusView.progressView setProgress:progress];
}

- (void)setDismissTimerWithInterval:(NSTimeInterval)interval{
    [self.dismissTimer invalidate];
    self.dismissTimer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(dismiss) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:self.dismissTimer forMode:NSRunLoopCommonModes];
}

- (void)dismissAfterInterval:(NSTimeInterval)interval completion:(completionBlock)completion{
    [self setDismissTimerWithInterval:interval];
    self.completion = completion;
}

- (void)dismiss{
    [self.dismissTimer invalidate];
    self.dismissTimer = nil;
    [UIView animateWithDuration:0.3f animations:^{
        self.statusView.transform = CGAffineTransformMakeTranslation(0, -statusHeight);
    } completion:^(BOOL finished) {
        if (![UIApplication sharedApplication].statusBarHidden) {
            [self makeTranslationWithStatusBar:0 completion:^{
                [self.statusView.layer removeAllAnimations];
                [self.statusView removeFromSuperview];
                self.statusView = nil;
                if (self.completion) {
                    self.completion();
                }
            }];
        }
        else{
            [self.statusView.layer removeAllAnimations];
            [self.statusView removeFromSuperview];
            self.statusView = nil;
            if (self.completion) {
                self.completion();
            }
            
        }
    }];

}




@end
