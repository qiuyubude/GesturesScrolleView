//
//  ViewController.m
//  GesturesScrolleView
//
//  Created by YSZ on 2019/6/26.
//  Copyright © 2019 YSZ. All rights reserved.
//  GitHub地址：https://github.com/qiuyubude/GesturesScrolleView

#import "ViewController.h"
#import "LQWebView.h"
#import "LQScrollView.h"
@interface ViewController ()<UIScrollViewDelegate>

/** scrollView是否可滑动 */
@property (nonatomic, assign) BOOL isCanScroll;

/** scrollV */
@property (nonatomic, strong) LQScrollView *scrollV;

/** webV */
@property (nonatomic, strong) LQWebView *webV;
@end
#define TopViewHeight 200
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isCanScroll = YES;
  
    self.scrollV = [[LQScrollView alloc]init];
    self.scrollV.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.scrollV.delegate = self;
    self.scrollV.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*2);
    self.scrollV.backgroundColor = [UIColor blueColor];
    self.scrollV.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollV];
    
    
    UIView *topV = [[UIView alloc]initWithFrame:CGRectMake(20, 40, (self.view.frame.size.width - 40), TopViewHeight-80)];
    topV.backgroundColor = [UIColor greenColor];
    [self.scrollV addSubview:topV];
    
    self.webV = [[LQWebView alloc]initWithFrame:CGRectMake(0, TopViewHeight, self.view.frame.size.width, self.view.frame.size.height)];
    self.webV.backgroundColor = [UIColor redColor];
    [self.webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.jianshu.com/p/5ee0c074a04d"]]];
    [self.scrollV addSubview:self.webV];
    
    
    if (@available(iOS 11.0, *)) {
        self.scrollV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.webV.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(webViewScrollToTop:) name:@"WEBVIEWSCROLLTOTOP" object:nil];
    
    // Do any additional setup after loading the view.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WEBVIEWSCROLLTOTOP" object:nil];
}

/**
 接收webView不可滑的通知 scrollView设置为可滑
 */
- (void)webViewScrollToTop:(NSNotification *)nofi{
     self.isCanScroll = YES;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offY = scrollView.contentOffset.y;
    
    if (scrollView == self.scrollV) {
        if (offY >= TopViewHeight) {  //此时webView到达顶部 让scrollView不可滑 让webView可滑
            self.scrollV.contentOffset = CGPointMake(0, TopViewHeight);
            if (self.isCanScroll) {
                self.isCanScroll = NO;
                self.webV.isWebCanScroll = YES;
            }
        }else if (offY >= 0 && offY < 200){ //scrollView处于可滑动范围
            if (self.isCanScroll) {
                self.scrollV.contentOffset = CGPointMake(0, offY);
            }else{
                if (self.webV.isWebCanScroll && self.webV.scrollView.contentOffset.y == 0) { //解决临界值问题
                    self.isCanScroll = YES;
                    self.webV.isWebCanScroll = NO;
                } else {
                    self.scrollV.contentOffset = CGPointMake(0, TopViewHeight);
                }
                
            }
        }
    }
    
    
}

@end
