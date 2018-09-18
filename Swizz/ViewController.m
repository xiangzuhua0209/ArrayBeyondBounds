//
//  ViewController.m
//  Swizz
//
//  Created by xiangzuhua on 2018/9/18.
//  Copyright © 2018年 xiangzuhua. All rights reserved.
//

#import "ViewController.h"
#import "NSMutableArray+SwizzleMethod.h"
#import "NSArray+SwizzleMethod.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSArray *arr = [NSArray array];
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:@"2"];
    NSLog(@"%@",arr[1]);
    [arr mutableArray_insertObject:nil atIndex:0];
    [arr mutableArray_insertObject:@"4" atIndex:9];
    
    // Do any additional setup after loading the view, typically from a nib.
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
