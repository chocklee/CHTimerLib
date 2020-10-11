//
//  CHGCDTimer.h
//  InterviewQuestions
//
//  Created by Changhao Li on 2020/9/14.
//  Copyright © 2020 Changhao Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CHGCDTimer;
typedef void(^CHGCDTimerCallbackBlock)(CHGCDTimer * _Nonnull timer);

NS_ASSUME_NONNULL_BEGIN

@interface CHGCDTimer : NSObject


/// Create GCDTimer, but not fire（定时器创建但未启动）
/// @param start The number of seconds between timer first times callback since fire
/// @param interval The number of seconds between firings of the timer
/// @param queue Queue for timer run and callback, default is in main queue
/// @param repeats If YES, the timer will repeatedly reschedule itself until invalidated
/// @param block Timer callback handler
+ (CHGCDTimer *)ch_GCDTimerWithStartTime:(NSTimeInterval)start
                                interval:(NSTimeInterval)interval
                                   queue:(dispatch_queue_t)queue
                                 repeats:(BOOL)repeats
                                   block:(CHGCDTimerCallbackBlock)block;


/// Create GCDTimer and fire immdiately（定时器创建后马上启动）
/// @param start The number of seconds between timer first times callback since fire
/// @param interval The number of seconds between firings of the timer
/// @param queue Queue for timer run and callback, default is in main queue
/// @param repeats If YES, the timer will repeatedly reschedule itself until invalidated
/// @param block Timer callback handler
+ (CHGCDTimer *)ch_scheduledGCDTimerWithStartTime:(NSTimeInterval)start
                                        interval:(NSTimeInterval)interval
                                           queue:(dispatch_queue_t)queue
                                         repeats:(BOOL)repeats
                                           block:(CHGCDTimerCallbackBlock)block;


/// Create GCDTimer, but not fire（定时器创建但未启动）
/// @param target target description
/// @param selector selector description
/// @param start The number of seconds between timer first times callback since fire
/// @param interval The number of seconds between firings of the timer
/// @param queue Queue for timer run and callback, default is in main queue
/// @param repeats If YES, the timer will repeatedly reschedule itself until invalidated
+ (CHGCDTimer *)ch_GCDTimerWithTarget:(id)target
                             selector:(SEL)selector
                            startTime:(NSTimeInterval)start
                             interval:(NSTimeInterval)interval
                                queue:(dispatch_queue_t)queue
                              repeats:(BOOL)repeats;


/// Create GCDTimer and fire immdiately（定时器创建后马上启动）
/// @param target target description
/// @param selector selector description
/// @param start The number of seconds between timer first times callback since fire
/// @param interval The number of seconds between firings of the timer
/// @param queue Queue for timer run and callback, default is in main queue
/// @param repeats If YES, the timer will repeatedly reschedule itself until invalidated
+ (CHGCDTimer *)ch_scheduledGCDTimerWithTarget:(id)target
                                      selector:(SEL)selector
                                     startTime:(NSTimeInterval)start
                                      interval:(NSTimeInterval)interval
                                         queue:(dispatch_queue_t)queue
                                       repeats:(BOOL)repeats;

/** start */
- (void)fire;

/** stop */
- (void)invalidate;

@end

NS_ASSUME_NONNULL_END
