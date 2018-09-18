//
//  NSMutableArray+SwizzleMethod.h
//  Swizz
//
//  Created by xiangzuhua on 2018/9/18.
//  Copyright © 2018年 xiangzuhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (SwizzleMethod)
/*
 * 改变可变数组的元素
 * 防止 objc为nil会导致crash
 * 防止 index越界
 */
-(void)mutableArray_addObject:(id)objc;
-(void)mutableArray_insertObject:(id)objc atIndex:(NSUInteger)index;



@end
