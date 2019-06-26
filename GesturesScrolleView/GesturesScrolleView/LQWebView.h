//
//  LQWebView.h
//  GesturesScrolleView
//
//  Created by YSZ on 2019/6/26.
//  Copyright © 2019 YSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LQWebView : WKWebView

/** 是否可以滑动 */
@property (nonatomic, assign) BOOL isWebCanScroll;

@end

NS_ASSUME_NONNULL_END
