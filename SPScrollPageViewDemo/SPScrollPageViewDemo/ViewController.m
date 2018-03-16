//
//  ViewController.m
//  SPScrollPageViewDemo
//
//  Created by Tree on 2018/3/2.
//  Copyright © 2018年 Tr2e. All rights reserved.
//

#import "ViewController.h"
#import "SPScrollPageView.h"

#define  RANDOM_COLOR   [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

@interface ViewController ()<SPScrollPageViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // # How to use #
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    SPScrollPageView *pageView = [SPScrollPageView scrollPageViewWithPageCount:5
                                                                  initialIndex:4
                                                                         frame:(CGRect){CGPointZero,screenSize}];
    pageView.sp_delegete = self;
    [self.view addSubview:pageView];
    
    // # Test #
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [pageView jumpImmediatelyToIndex:1 animated:YES];
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [pageView jumpImmediatelyToIndex:3 animated:NO];
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [pageView jumpImmediatelyToIndex:4 animated:YES];
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(12 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [pageView jumpImmediatelyToIndex:0 animated:YES];
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [pageView jumpImmediatelyToIndex:1 animated:YES];
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(18 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [pageView jumpImmediatelyToIndex:4 animated:NO];
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(21 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [pageView jumpImmediatelyToIndex:1 animated:NO];
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(24 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [pageView jumpImmediatelyToIndex:4 animated:YES];
//    });
}

- (UIView *)scrollPageView:(SPScrollPageView *)pageView pageForIndex:(NSInteger)index{
    UIView *view = [pageView dequeuePageViewWithIndex:index];
    if (!view) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        UILabel *label = [UILabel new];
        label.text = [NSString stringWithFormat:@"%ld",index];
        label.font = [UIFont systemFontOfSize:30 weight:UIFontWeightBold];
        label.center = CGPointMake(screenSize.width/2.0, screenSize.width/2.0);
        [label sizeToFit];
        
        view = [[UIView alloc] init];
        view.backgroundColor = RANDOM_COLOR;
        [view addSubview:label];
        NSLog(@"Initialize");
    }else{
        NSLog(@"Reuse");
    }
    return view;
}

- (void)scrollPageDidEndBounceAtPage:(UIView *)stillPage index:(NSInteger)index
{
    NSLog(@"Current page number:%ld",index);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
