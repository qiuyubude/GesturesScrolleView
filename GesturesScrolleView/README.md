# WebView与ScrollView滑动交互
>  由于项目当中涉及webView与scrollView的滑动交互，一开始是通过计算webView的高度并且禁用webView的滑动，然后改变scrollView的contentSize去实现滑动操作，但这种做法当webView加载的内容里图片过多时会造成内存爆满，所以换了一种做法去实现。

#### # 效果如下：

![](http://ww1.sinaimg.cn/large/ed0bfc02gy1g4epyh5f98g20a006ojx3.gif)

## 代码处理

##  1、scrollView的处理
#####    （1）首先需要创建一个响应多手势的LQScrollView类
响应多手势的方法

```
/**
 让ScrollView响应多手势
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    
    return YES;
}
```
#####  （2）在controller中创建一个继承于LQScrollView的scrollView，同时创建一个isCanScroll BOOL属性用于控制scrollView是否可以滑动

```
/** scrollView是否可滑动 */
@property (nonatomic, assign) BOOL isCanScroll;

/** scrollV */
@property (nonatomic, strong) LQScrollView *scrollV;
```


## 2、webView的处理

##### （1）首先需要创建一个LQWebView类，由于webView中ScrollView的代理方法也是- (void)scrollViewDidScroll:(UIScrollView *)scrollView，所以为了更好的区分代理方法实现，在这个应该创建一个LQWebView用于控制滑动代理方法

##### （2）创建一个BOOL属性（isWebCanScroll）用于控制webView是否可以滑动
```
/** 是否可以滑动 */
@property (nonatomic, assign) BOOL isWebCanScroll;
```
##### （3）处理webView中ScrollView的滑动代理
通过isWebCanScroll属性来控制是否可滑动，通用设置webView中ScrollView的contentOffset来实现webView不可滑动，当webView可滑动并且滑动到顶部的时候，此时改变webView的isWebCanScroll属性重新让webView不可滑，并且将这种状态用通知发送出去。
```
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
```

## 3、Controller中的处理
##### （1）处理ScrollView的代理
```
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
                self.scrollV.contentOffset = CGPointMake(0, TopViewHeight);
                
            }
        }
    }
    
    
}

```
##### （2）处理通知事件
```
/**
 接收webView不可滑的通知 scrollView设置为可滑
 */
- (void)webViewScrollToTop:(NSNotification *)nofi{
     self.isCanScroll = YES;
}
```
*补充说明：*

*该处理方式不仅试用于webView与scrollView也试用于tableView于ScrollView的交互。处理方式是一样的，都是通过BOOL 属性去控制是否可滑动，而是否可滑动的处理是通过在ScrollView的代理方法scrollViewDidScroll去控制ScrollView的contentOffset实现的。*

Demo地址：https://github.com/qiuyubude/GesturesScrolleView
