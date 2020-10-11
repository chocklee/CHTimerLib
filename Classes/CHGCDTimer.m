//
//  CHGCDTimer.m
//  InterviewQuestions
//
//  Created by Changhao Li on 2020/9/14.
//  Copyright © 2020 Changhao Li. All rights reserved.
//

#import "CHGCDTimer.h"
#import "CHWeakProxy.h"

#import <objc/runtime.h>

@implementation CHGCDTimer

#pragma mark - Public Method

+ (CHGCDTimer *)ch_GCDTimerWithStartTime:(NSTimeInterval)start interval:(NSTimeInterval)interval queue:(dispatch_queue_t)queue repeats:(BOOL)repeats block:(CHGCDTimerCallbackBlock)block {
    if (!block || start < 0 || (interval <= 0 && repeats)) {
        return nil;
    }

    CHGCDTimer *gcdTimer = [[CHGCDTimer alloc] init];

    // queue
    dispatch_queue_t queue_t = queue ?: dispatch_get_main_queue();

    // create
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue_t);

    // set time
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0);

    objc_setAssociatedObject(gcdTimer, @selector(fire), timer, OBJC_ASSOCIATION_RETAIN);

    // call back
    dispatch_source_set_event_handler(timer, ^{
        block(gcdTimer);
        if (!repeats) {
            [gcdTimer invalidate];
        }
    });

    return gcdTimer;
}


+ (CHGCDTimer *)ch_scheduledGCDTimerWithStartTime:(NSTimeInterval)start interval:(NSTimeInterval)interval queue:(dispatch_queue_t)queue repeats:(BOOL)repeats block:(CHGCDTimerCallbackBlock)block {
    CHGCDTimer *gcdTimer = [self ch_GCDTimerWithStartTime:start interval:interval queue:queue repeats:repeats block:block];

    [gcdTimer fire];

    return gcdTimer;
}

+ (CHGCDTimer *)ch_GCDTimerWithTarget:(id)target selector:(SEL)selector startTime:(NSTimeInterval)start interval:(NSTimeInterval)interval queue:(dispatch_queue_t)queue repeats:(BOOL)repeats {
    CHWeakProxy *proxy = [CHWeakProxy proxyWithTarget:target];

    return [self ch_GCDTimerWithStartTime:start interval:interval queue:queue repeats:repeats block:^(CHGCDTimer *timer) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [proxy performSelector:selector];
        #pragma clang diagnostic pop
    }];
}

+ (CHGCDTimer *)ch_scheduledGCDTimerWithTarget:(id)target selector:(SEL)selector startTime:(NSTimeInterval)start interval:(NSTimeInterval)interval queue:(dispatch_queue_t)queue repeats:(BOOL)repeats  {
    CHWeakProxy *proxy = [CHWeakProxy proxyWithTarget:target];

    CHGCDTimer *gcdTimer = [self ch_GCDTimerWithStartTime:start interval:interval queue:queue repeats:repeats block:^(CHGCDTimer *timer) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [proxy performSelector:selector];
        #pragma clang diagnostic pop
    }];

    [gcdTimer fire];

    return gcdTimer;
}

- (void)fire {
    dispatch_source_t timer = objc_getAssociatedObject(self, _cmd);

    if (timer) {
        dispatch_resume(timer);
    };
}

- (void)invalidate{
    dispatch_source_t timer = objc_getAssociatedObject(self, @selector(fire));

    if (timer) {
        dispatch_source_cancel(timer);
    }

    objc_removeAssociatedObjects(self);
}

@end
