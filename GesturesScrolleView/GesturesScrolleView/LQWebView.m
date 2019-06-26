//
//  LQWebView.m
//  GesturesScrolleView
//
//  Created by YSZ on 2019/6/26.
//  Copyright © 2019 YSZ. All rights reserved.
//

#import "LQWebView.h"

@interface LQWebView ()<UIScrollViewDelegate>

@end

@implementation LQWebView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isWebCanScroll = NO;
        
        [self loadData];
    }
    return self;
}

#pragma mark loadData
- (void)loadData{
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.jianshu.com/p/771a8cc91f2b"]]];
}


#pragma mark  UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.scrollView) {
        CGFloat offY = scrollView.contentOffset.y;
//        NSLog(@"offY == %lf",offY);
        
        if (!self.isWebCanScroll) {   //通过设置 contentOffset 让webView不可滑动
            self.scrollView.contentOffset = CGPointZero;
        }
        if (offY < 0) {   //当webView滑动顶部时 使webView不可滑 并且将该状态用通知发送出去
            self.isWebCanScroll = NO;
            self.scrollView.contentOffset = CGPointZero;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"WEBVIEWSCROLLTOTOP" object:nil];
        }
        
    }
    
}

@end
