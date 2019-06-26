//
//  LQScrollView.m
//  GesturesScrolleView
//
//  Created by YSZ on 2019/6/26.
//  Copyright © 2019 YSZ. All rights reserved.
//

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
