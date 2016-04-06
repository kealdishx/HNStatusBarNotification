#HNStatusBarNotification
####支持三种状态的通知样式：
1.Normal Style
``` objective-c
[HNStatusBarNotiManager showStatusWithText:@"这是一条消息!"];
```
2.Show with activityIndicatorView
``` objective-c
[HNStatusBarNotiManager showIndicatorViewWithStyle:UIActivityIndicatorViewStyleWhite];
```
3.Show with UIProgressView
``` objective-c
[HNStatusBarNotiManager showProgress:self.progress];
```
####支持定时移除和Block
``` objective-c
[HNStatusBarNotiManager dismissAfterInterval:2.0f completion:nil];
```
####支持自定义StautusView样式:HNStatusNotiConfig

![](https://github.com/ZakariyyaSv/HNstatusBarNotification/raw/master/NotificationDemo.gif)
