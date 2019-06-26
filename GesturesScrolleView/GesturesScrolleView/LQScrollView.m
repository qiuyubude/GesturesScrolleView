//
//  LQScrollView.m
//  GesturesScrolleView
//
//  Created by YSZ on 2019/6/26.
//  Copyright © 2019 YSZ. All rights reserved.
//  GitHub地址：https://github.com/qiuyubude/GesturesScrolleView

#import "LQScrollView.h"

@implementation LQScrollView

/**
 让ScrollView响应多手势
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    
    return YES;
}

@end
