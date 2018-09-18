//
//  NSArray+SwizzleMethod.m
//  Swizz
//
//  Created by xiangzuhua on 2018/9/18.
//  Copyright © 2018年 xiangzuhua. All rights reserved.
//

#import "NSArray+SwizzleMethod.h"
#import "NSObject+SwizzleMethod.h"
#import <objc/runtime.h>
@implementation NSArray (SwizzleMethod)

+ (void)load{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self systemSelector:@selector(objectAtIndex:) swizzledSelector:@selector(zh_objectAtIndex:) error:nil];
        [self systemSelector:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(zh_objectAtIndexedSubscript:) error:nil];
    });
}
/*
 * 取不可变数组的元素
 * 防止index越界
 */
-(id)zh_objectAtIndex:(NSUInteger)index{
    if (self.count > index) {
        return [self zh_objectAtIndex:index];
    } else {
        NSLog(@"NSArray取值越界,index=%ld,count=%ld",index,self.count);
        return nil;
    }
}
/*
 * 取不可变数组的元素
 * 防止index越界
 */
-(id)zh_objectAtIndexedSubscript:(NSUInteger)index{
    if (self.count > index) {
        return [self zh_objectAtIndexedSubscript:index];
    } else {
        NSLog(@"NSArray取值越界,index=%ld,count=%ld",index,self.count);
        return nil;
    }
}

@end
