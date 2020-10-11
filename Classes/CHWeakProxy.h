//
//  CHWeakProxy.h
//  InterviewQuestions
//
//  Created by Changhao Li on 2020/9/14.
//  Copyright © 2020 Changhao Li. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CHWeakProxy : NSProxy

// weak target
@property (nonatomic, weak) id target;

// init proxy by target
+ (instancetype)proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
