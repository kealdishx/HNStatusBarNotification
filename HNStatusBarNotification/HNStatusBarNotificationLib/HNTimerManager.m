//
//  HNTimerManager.m
//  HNStatusBarNotification
//
//  Created by 许浩男 on 16/4/5.
//  Copyright © 2016年 Zakariyya. All rights reserved.
//

#import "HNTimerManager.h"

@interface HNTimerManager()

@property (nonatomic,strong) NSMutableDictionary *timerDict;

@end

@implementation HNTimerManager

+ (instancetype)sharedInstance{
    static HNTimerManager *timerManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timerManager = [[HNTimerManager alloc] init];
    });
    return timerManager;
}


#pragma mark - class method
+ (void)scheduledTimerWithName:(NSString *)name duration:(NSTimeInterval)duration queue:(dispatch_queue_t)queue repeat:(BOOL)repeat action:(dispatch_block_t)action{
    [[self sharedInstance] scheduledTimerWithName:name duration:duration queue:queue repeat:repeat action:action];
}

+ (void)cancelTimerWithName:(NSString *)name{
    [[self sharedInstance] cancelTimerWithName:name];
}

+ (void)cancelAllTimers{
    [[self sharedInstance] cancelAllTimers];
}

#pragma mark - Implementation
- (NSMutableDictionary *)timerDict{
    if (!_timerDict) {
        _timerDict = [[NSMutableDictionary alloc] init];
    }
    return _timerDict;
}

- (void)scheduledTimerWithName:(NSString *)name interval:(NSTimeInterval)interval queue:(dispatch_queue_t)queue repeat:(BOOL)repeat action:(dispatch_block_t)action{
    if (!name) {
        return;
    }
    queue = (queue == nil) ? dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) : queue;
    dispatch_source_t timer = [self.timerDict valueForKey:name];
    if (!timer) {
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_resume(timer);
    }
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, interval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(timer, ^{
        action();
        repeat == YES ? : [weakSelf cancelTimerWithName:name];
    });
    
}

- (void)cancelTimerWithName:(NSString *)name{
    dispatch_source_t timer = [self.timerDict valueForKey:name];
    if (!timer) {
        return;
    }
    dispatch_source_cancel(timer);
    [self.timerDict removeObjectForKey:name];
    
}

- (void)cancelAllTimers{
    [self.timerDict enumerateKeysAndObjectsUsingBlock:^(NSString *name, dispatch_source_t timer, BOOL *_Nonnull stop) {
        dispatch_source_cancel(timer);
        [self.timerDict removeObjectForKey:name];
    }];
}

@end
