//
//  LJW_CycleView.h
//  轮播
//
//  Created by 刘君威 on 2019/5/6.
//  Copyright © 2019 liujunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class LJW_CycleView;
@protocol LJW_CycleViewDelegate <NSObject>
// 点击事件
- (void)cycleView:(LJW_CycleView *)cycleView didSelectItemAtIndex:(NSInteger)index;

@end

@interface LJW_CycleView : UIView
// 默认图片
@property (nonatomic, strong) UIImage *placeholderImage;
// 图片数组
@property (nonatomic, copy) NSArray *images;
// 可以自定义 pageControl 的颜色
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, weak) id<LJW_CycleViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
