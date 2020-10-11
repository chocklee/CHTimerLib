//
//  CHWeakProxy.m
//  InterviewQuestions
//
//  Created by Changhao Li on 2020/9/14.
//  Copyright © 2020 Changhao Li. All rights reserved.
//

#import "CHWeakProxy.h"

@implementation CHWeakProxy

+ (instancetype)proxyWithTarget:(id)target {

    if (!target) {
        return nil;
    }

    CHWeakProxy *proxy = [CHWeakProxy alloc];
    proxy.target = target;

    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end
