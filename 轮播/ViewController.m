//
//  ViewController.m
//  轮播
//
//  Created by 刘君威 on 2019/5/6.
//  Copyright © 2019 liujunwei. All rights reserved.
//

#import "ViewController.h"
#import "LJW_CycleView.h"

@interface ViewController () <LJW_CycleViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    LJW_CycleView *cycleView = [[LJW_CycleView alloc] initWithFrame:CGRectMake(0, 90, self.view.bounds.size.width, 200)];
    cycleView.delegate = self;
    // 设置默认图片,当images赋值后不显示
    cycleView.placeholderImage = [UIImage imageNamed:@"1"];
    cycleView.images = @[[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"],[UIImage imageNamed:@"5"]];
    // 设置 pageControl 的颜色
    cycleView.pageControl.currentPageIndicatorTintColor = UIColor.orangeColor;
    cycleView.pageControl.pageIndicatorTintColor = UIColor.grayColor;
    [self.view addSubview:cycleView];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(30, 350, self.view.bounds.size.width - 60, 100)];
    [self.view addSubview:textView];
    textView.text = @"jsadhfasdfjabfnbfdsajkfbfdsajbv xcbviaurhwuhrkjasdfjkdshfjkahjaksdhfjdkashfajkshjksabfjbadsfbasnmfbmsanbfmasndbfmasnbfnmasdb,bfmndasbfsbam,sxcbviaurhwuhrkjasdfjkdshfjkahjaksdhfjdkashfajkshjksabfjbadsfbasnmfbmsanbfmasndbfmasnbfnmasdb,bfmndasbfsbam,sxcbviaurhwuhrkjasdfjkdshfjkahjaksdhfjdkashfajkshjksabfjbadsfbasnmfbmsanbfmasndbfmasnbfnmasdb,bfmndasbfsbam,sxcbviaurhwuhrkjasdfjkdshfjkahjaksdhfjdkashfajkshjksabfjbadsfbasnmfbmsanbfmasndbfmasnbfnmasdb,bfmndasbfsbam,sxcbviaurhwuhrkjasdfjkdshfjkahjaksdhfjdkashfajkshjksabfjbadsfbasnmfbmsanbfmasndbfmasnbfnmasdb,bfmndasbfsbam,sxcbviaurhwuhrkjasdfjkdshfjkahjaksdhfjdkashfajkshjksabfjbadsfbasnmfbmsanbfmasndbfmasnbfnmasdb,bfmndasbfsbam,sxcbviaurhwuhrkjasdfjkdshfjkahjaksdhfjdkashfajkshjksabfjbadsfbasnmfbmsanbfmasndbfmasnbfnmasdb,bfmndasbfsbam,s";
}

- (void)cycleView:(LJW_CycleView *)cycleView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"选中第%d个",(int)index);
}


@end
