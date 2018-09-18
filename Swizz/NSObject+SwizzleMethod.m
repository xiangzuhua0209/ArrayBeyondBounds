//
//  NSObject+SwizzelMethod.m
//  Swizz
//
//  Created by xiangzuhua on 2018/9/18.
//  Copyright © 2018年 xiangzuhua. All rights reserved.
//

#import "NSObject+SwizzleMethod.h"
#import <objc/runtime.h>

@implementation NSObject (SwizzleMethod)

+ (BOOL)systemSelector:(SEL)systemSelector swizzledSelector:(SEL)swizzledSelector error:(NSError *)error{
    // 根据类名和实例方法名，获取实例方法的实现
    Method systemMethod = class_getInstanceMethod(self, systemSelector);
    if (!systemMethod) {
        return NO;
    }
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    if (!swizzledMethod) {
        return NO;
    }
    
    // 给类动态添加一个方法，添加成功会返回YES，但是如果systemSelector方法已经实现了，就会返回NO
    // method_getTypeEncoding(swizzledMethod)获取swizzledMethod方法的 type encode
    if (class_addMethod([self class], systemSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        // 如果添加成功，相当于systemSelector的实现已经改变，那就需要将swizzledSelector的实现改为systemMethod。这样亦相当于交换了方法
        class_replaceMethod([self class], swizzledSelector, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    } else {
        method_exchangeImplementations(systemMethod, swizzledMethod);
    }
    return YES;
}

@end
