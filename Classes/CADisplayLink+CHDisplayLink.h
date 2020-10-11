//
//  CADisplayLink+CHDisplayLink.h
//  InterviewQuestions
//
//  Created by Changhao Li on 2020/9/14.
//  Copyright © 2020 Changhao Li. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef void(^CHDisplayLinkCallbackBlock)(CADisplayLink * _Nonnull link);

NS_ASSUME_NONNULL_BEGIN

@interface CADisplayLink (CHDisplayLink)

// 同系统方法，仅解决循环引用问题
+ (CADisplayLink *)ch_displayLinkWithTarget:(id)target selector:(SEL)sel;

// SEL，auto run，runloop Mode: NSRunLoopCommonModes
+ (CADisplayLink *)ch_scheduledDisplayLinkWithTarget:(id)target selector:(SEL)sel;

// Block callback，auto run, runloop mode: NSRunLoopCommonModes
+ (CADisplayLink *)ch_scheduledDisplayLinkWithBlock:(CHDisplayLinkCallbackBlock)block;

@end

NS_ASSUME_NONNULL_END
