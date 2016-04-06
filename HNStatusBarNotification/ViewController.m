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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)pushNotification {
    [HNStatusBarNotiManager showStatusWithText:@"你好分骄傲是ghkjhlhklhk快乐飞回家而乌克"];
    [HNStatusBarNotiManager showIndicatorViewWithStyle:UIActivityIndicatorViewStyleWhite];
    [HNStatusBarNotiManager showProgress:0.5f];
    [HNStatusBarNotiManager dismissAfterInterval:3.0f completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
