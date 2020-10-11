//
//  CADisplayLink+CHDisplayLink.m
//  InterviewQuestions
//
//  Created by Changhao Li on 2020/9/14.
//  Copyright © 2020 Changhao Li. All rights reserved.
//

#import "CADisplayLink+CHDisplayLink.h"
#import "CHWeakProxy.h"

#import <objc/runtime.h>

@implementation CADisplayLink (CHDisplayLink)

#pragma mark - Public Method
+ (CADisplayLink *)ch_displayLinkWithTarget:(id)target selector:(SEL)sel {
    return [self displayLinkWithTarget:[CHWeakProxy proxyWithTarget:target] selector:sel];
}

+ (CADisplayLink *)ch_scheduledDisplayLinkWithTarget:(id)target selector:(SEL)sel {
    CADisplayLink *link = [self displayLinkWithTarget:[CHWeakProxy proxyWithTarget:target] selector:sel];

    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

    return link;
}

+ (CADisplayLink *)ch_scheduledDisplayLinkWithBlock:(CHDisplayLinkCallbackBlock)block {
    if (!block) {
        return nil;
    }

    CADisplayLink *link = [self ch_displayLinkWithTarget:self selector:@selector(_blockAction:)];

    objc_setAssociatedObject(link, @selector(_blockAction:), block, OBJC_ASSOCIATION_COPY);

    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

    return link;
}

#pragma mark - Private Method
+ (void)_blockAction:(CADisplayLink *)link {
    CHDisplayLinkCallbackBlock block = objc_getAssociatedObject(link, _cmd);
    !block ?: block(link);
}

@end
