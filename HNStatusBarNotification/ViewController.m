//
//  ViewController.m
//  HNStatusBarNotification
//
//  Created by 许浩男 on 16/4/4.
//  Copyright © 2016年 Zakariyya. All rights reserved.
//

#import "ViewController.h"
#import "HNStatusBarNotiManager.h"

@interface ViewController ()

@property (nonatomic,strong) NSTimer *progressTimer;

@property (nonatomic,assign) CGFloat progress;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)pushNotification {
    [HNStatusBarNotiManager showStatusWithText:@"这是一条消息!"];
    [HNStatusBarNotiManager showIndicatorViewWithStyle:UIActivityIndicatorViewStyleWhite];
    [HNStatusBarNotiManager dismissAfterInterval:3.0f completion:nil];

}

- (IBAction)loadOnClick {
    [HNStatusBarNotiManager showStatusWithText:@"正在加载中..."];
    [HNStatusBarNotiManager showIndicatorViewWithStyle:UIActivityIndicatorViewStyleWhite];
    [HNStatusBarNotiManager dismissAfterInterval:2.0f completion:nil];
}


- (IBAction)uploadOnClick {
    [HNStatusBarNotiManager showStatusWithText:@"正在上传中..."];
    [self startProgress];
}

- (void)startProgress{
    [HNStatusBarNotiManager showProgress:self.progress];
    [self.progressTimer invalidate];
    self.progressTimer = nil;
    if (self.progress < 1.0f) {
        self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(startProgress) userInfo:nil repeats:NO];
        self.progress += 0.1;
    }
    else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [HNStatusBarNotiManager showProgress:0.0f];
            [HNStatusBarNotiManager dismissWithCompletion:nil];
        });
    }
}

@end
