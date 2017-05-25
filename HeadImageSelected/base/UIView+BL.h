//
//  UIView+BL.h
//  HeadImageSelected
//
//  Created by blazer on 16/4/5.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BL)

//间隔x值
@property(nonatomic, assign) CGFloat x;

//间隔y值
@property(nonatomic, assign) CGFloat y;

//宽度
@property(nonatomic, assign) CGFloat width;

//高度
@property(nonatomic, assign) CGFloat height;

//中心点x值
@property(nonatomic, assign) CGFloat centerX;

//中心点y值
@property(nonatomic, assign) CGFloat centerY;

//尺寸大小
@property(nonatomic, assign) CGSize size;

//起始点
@property(nonatomic, assign) CGPoint origin;

//上 < Shortcut for frame.origin.y 剪短的y值
@property(nonatomic, assign) CGFloat top;

//下< Shortcut for frame.origin.y + frame.size.height
@property(nonatomic, assign) CGFloat bottom;

//左 < Shortcut for frame.origin.x.
@property(nonatomic, assign) CGFloat left;

//右 < Shortcut for frame.origin.x + frame.size.width
@property(nonatomic, assign) CGFloat right;

//设置镂空中间的视图
- (void)setHollowWithCenterFrame:(CGRect)centerFrame;

//获取屏幕的图片
- (UIImage *)imageFromSelfView;


@end
