//
//  TempView.m
//  Demo
//
//  Created by yingxin ye on 2017/5/9.
//  Copyright © 2017年 yingxin ye. All rights reserved.
//

#import "TempView.h"

@interface TempView()

@property (nonatomic, copy) NSString* (^completeBlock)(void);

@end


@implementation TempView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

-(void)openAndCompletedBlock:(NSString*(^)(void))completed
{
    [self performSelector:@selector(delayDo) withObject:nil afterDelay:1.0f];
    self.completeBlock = completed;
}

-(void)delayDo
{
    NSLog(@"inside======%@",self.completeBlock());
}


@end
