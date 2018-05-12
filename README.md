# SPScrollPageView
![](https://github.com/Tr2e/SPScrollPageView/raw/master/Pictures/SPScrollPageView.png)
![Version](https://img.shields.io/cocoapods/v/SPScrollPageView.svg)
![](https://img.shields.io/badge/language-objc-orange.svg)
![license](https://img.shields.io/github/license/mashape/apistatus.svg)

## SPScrollPageView

[掘金](https://juejin.im/post/5a9ce77a6fb9a028c9798c2f)
[简书](https://www.jianshu.com/p/667f3eaeb3bf)
[博客](http://tr2e.com.cn/)

### 作用
* 让横向页面切换更流畅顺滑，解决非相邻页面切换时带来的快速略过问题
* 避免非相邻页面**动画**切换时创建**非目标页面view**造成的性能损耗
* 可直接设置初始化目标位置
* 支持无动画的直接页面切换


**pod 0.0.5 updated**
* 增加页面刷新相关方法，详细请看 **怎么使用**

![跳转](https://user-gold-cdn.xitu.io/2018/3/4/161f0205c8c61af3?w=373&h=630&f=gif&s=38964)

![拖动](https://user-gold-cdn.xitu.io/2018/3/4/161f02319270b888?w=373&h=630&f=gif&s=202611)

### 怎么使用

* 使用快速构建类方法创建并设置代理`sp_delegate`

```
// # How to use #
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    SPScrollPageView *pageView = [SPScrollPageView scrollPageViewWithPageCount:5
                                                                  initialIndex:3
                                                                         frame:(CGRect){CGPointZero,screenSize}];
    pageView.sp_delegete = self;
    [self.view addSubview:pageView];
```
`pageCount`:总页面数
`initialIndex`:初始化页面所处的位置（0开始）

* 在代理方法中根据位置创建并返回目标View

```
- (UIView *)scrollPageView:(SPScrollPageView *)pageView pageForIndex:(NSInteger)index{
    UIView *view = [pageView dequeuePageViewWithIndex:index];
    if (!view) {
        if (index) {
            view = self.subscribed;
        }else{
            view = self.news;
        }
    }
    return view;
}
```

* 在代理方法中，获知当前显示的位置及View

```
- (void)scrollPageDidEndBounceAtPage:(UIView *)stillPage index:(NSInteger)index
{
    NSLog(@"Current page number:%ld",index);
}
```
**在这里，你可以控制页面的刷新，更新导航条位置等操作**

* 跳转，直接使用`- (void)jumpImmediatelyToIndex:(NSInteger)index animated:(BOOL)animated;`
`index`:目标位置 `animated`:是否使用动画

* 刷新页面功能（2018/05/12）

```
// 刷新全部页面，恢复初始状态
- (void)reloadData;
// 刷新固定位置的页面，并不会跳转
- (void)reloadDataForIndex:(NSInteger)index;
// 刷新固定位置的页面，可以设置是否跳转
- (void)reloadDataForIndex:(NSInteger)index show:(BOOL)toShow animated:(BOOL)animated;
```

### 怎么应用
1. `pod 'SPScrollPageView' ,'~> 0.0.5'`
2. 直接将*Gayhub*上项目中的**SPScrollPageView**文件夹拖入工程
> Gayhub：[SPScrollPageView](https://github.com/Tr2e/SPScrollPageView) 求个star ^-^

### 基本原理
1. 继承自`UIScrollView`
2. 设置`pagingEnabled`为`YES`,用于切换分页效果的实现
3. 借鉴`UITableview`的复用机制，只创建两个`Cell`用于承载数据源中获取的`View`,避免在滚动时出现无意义的视图创建
4. 根据位置缓存视图，管理展示视图，无需在`Controller`中进行冗余的处理
5. 使用`KVO`监听`contentOffset`的变化，控制页面的复用及相关数据的更新。这里多说一点，很多情况下利用现有的`UIScrollView`的`delegate`可以更容易获悉相关状态，但是笔者没有这么做，为什么呢？假如我们过分依赖原生代理方法，一但使用者想使用相关代理方法去重新设置了`delegate`，那么功能一定会出现问题。
6. 使用`UIScrollView`的`panGestureRecognizer`，结合*第5条*，监听处理手指拖动页面时的变化

### 写在最后
作为新年节后的恢复轮子，肯定有不妥或者不足的地方。如果大佬有任何意见，或者发现任何不足，希望大佬能留言或issue拍砖，野生鶸鸡在此拜谢

### 写在最后的最后
**“愿中国青年都摆脱冷气,只是向上走,不必听自暴自弃者流的话。”**


