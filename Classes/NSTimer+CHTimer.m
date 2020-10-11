//
//  NSTimer+CHTimer.m
//  InterviewQuestions
//
//  Created by Changhao Li on 2020/9/14.
//  Copyright © 2020 Changhao Li. All rights reserved.
//

#import "NSTimer+CHTimer.h"
#import "CHWeakProxy.h"

#import <objc/runtime.h>

@implementation NSTimer (CHTimer)

#pragma mark - Public Method
+ (NSTimer *)ch_timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo {
    return [self timerWithTimeInterval:ti target:[CHWeakProxy proxyWithTarget:aTarget] selector:aSelector userInfo:userInfo repeats:yesOrNo];
}

+ (NSTimer *)ch_scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo {
    return [self scheduledTimerWithTimeInterval:ti target:[CHWeakProxy proxyWithTarget:aTarget] selector:aSelector userInfo:userInfo repeats:yesOrNo];
}

+ (NSTimer *)ch_timerWithTimerInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(CHTimerCallbackBlock)block {
    if (!block) {
        return nil;
    }

    NSTimer *timer = [self timerWithTimeInterval:interval target:[CHWeakProxy proxyWithTarget:self] selector:@selector(_blockAction:) userInfo:nil repeats:repeats];

    if (!timer) {
        return nil;
    }

    objc_setAssociatedObject(timer, @selector(_blockAction:), block, OBJC_ASSOCIATION_COPY);
    return timer;
}

+ (NSTimer *)ch_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(CHTimerCallbackBlock)block {
    if (!block) {
        return nil;
    }

    NSTimer *timer = [self scheduledTimerWithTimeInterval:interval target:[CHWeakProxy proxyWithTarget:self] selector:@selector(_blockAction:) userInfo:nil repeats:repeats];

    if (!timer) {
        return nil;
    }

    objc_setAssociatedObject(timer, @selector(_blockAction:), block, OBJC_ASSOCIATION_COPY);
    return timer;
}

#pragma mark - Private Method
+ (void)_blockAction:(NSTimer *)timer {
    CHTimerCallbackBlock block = objc_getAssociatedObject(timer, _cmd);

    !block ?: block(timer);
}

@end
