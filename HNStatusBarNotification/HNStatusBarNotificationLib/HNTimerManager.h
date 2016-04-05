//
//  HNTimerManager.h
//  HNStatusBarNotification
//
//  Created by 许浩男 on 16/4/5.
//  Copyright © 2016年 Zakariyya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HNTimerManager : NSObject

+ (void)scheduledTimerWithName:(NSString *)name interval:(NSTimeInterval)interval queue:(dispatch_queue_t)queue repeat:(BOOL)repeat action:(dispatch_block_t)action;

+ (void)cancelTimerWithName:(NSString *)name;

+ (void)cancelAllTimers;

@end
