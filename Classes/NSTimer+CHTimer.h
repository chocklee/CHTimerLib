//
//  NSTimer+CHTimer.h
//  InterviewQuestions
//
//  Created by Changhao Li on 2020/9/14.
//  Copyright © 2020 Changhao Li. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CHTimerCallbackBlock)(NSTimer *timer);

@interface NSTimer (CHTimer)

// 与系统同名方法一致，需要手动添加到 runloop 中，手动控制启动
+ (NSTimer *)ch_timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;

// 与系统同名方法一致，系统自动添加到 runloop 中，创建成功自动启动
+ (NSTimer *)ch_scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;

// block回调，不限制iOS最低版本，需要手动添加到 runloop 中，手动控制启动
+ (NSTimer *)ch_timerWithTimerInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(CHTimerCallbackBlock)block;

// block回调，不限制iOS最低版本，系统自动添加到 runloop  中，创建成功自动启动
+ (NSTimer *)ch_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(CHTimerCallbackBlock)block;

@end

NS_ASSUME_NONNULL_END
