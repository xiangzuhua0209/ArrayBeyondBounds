//
//  NSMutableArray+SwizzleMethod.m
//  Swizz
//
//  Created by xiangzuhua on 2018/9/18.
//  Copyright © 2018年 xiangzuhua. All rights reserved.
//

#import "NSMutableArray+SwizzleMethod.h"
#import "NSObject+SwizzleMethod.h"
#import <objc/runtime.h>
@implementation NSMutableArray (SwizzleMethod)

-(void)mutableArray_addObject:(id)objc{
    if (objc) {
        [self addObject:objc];
    }else{
        NSLog(@"试图在NSMutableArray中添加nil对象");
    }
}

-(void)mutableArray_insertObject:(id)objc atIndex:(NSUInteger)index{
    if (self.count > index && objc) {
        [self insertObject:objc atIndex:index];
    }else{
        NSLog(@"NSMutableArray插入元素越界或者插入元素为nil，index = %ld, count = %ld",index,self.count);
    }
}

+ (void)load{
    [super load];
    // 只交换一次方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 类方法中 用self 和 objc_getClass("__NSArrayM")效果一样，都是类对象，从而调用类方法。
        [objc_getClass("__NSArrayM") systemSelector:@selector(objectAtIndex:) swizzledSelector:@selector(zhM_objectAtIndex:) error:nil];
        [objc_getClass("__NSArrayM") systemSelector:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(zhM_objectAtIndexedSubscript:) error:nil];
        
    });
}
/*
 * 取可变数组的元素
 * 防止index越界
 */
-(id)zhM_objectAtIndex:(NSUInteger)index{
    if (self.count > index) {
        return [self zhM_objectAtIndex:index];
    } else {
        NSLog(@"NSMutableArray取值越界,index=%ld,count=%ld",index,self.count);
        return nil;
    }
}
/*
 * 取可变数组的元素
 * 防止index越界
 */
-(id)zhM_objectAtIndexedSubscript:(NSUInteger)index{
    if (self.count > index) {
        return [self zhM_objectAtIndexedSubscript:index];
    } else {
        NSLog(@"NSMutableArray取值越界,index=%ld,count=%ld",index,self.count);
        return nil;
    }
}

@end
