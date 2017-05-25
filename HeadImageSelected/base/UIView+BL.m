//
//  UIView+BL.m
//  HeadImageSelected
//
//  Created by blazer on 16/4/5.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "UIView+BL.h"

@implementation UIView (BL)

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (UIView * (^)(CGFloat x))setX{
    return ^(CGFloat x){
        self.x = x;
        return self;
    };
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setLeft:(CGFloat)left{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)left{
    return self.frame.origin.x;
}

- (void)setTop:(CGFloat)top{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)top{
    return self.frame.origin.y;
}

- (void)setRight:(CGFloat)right{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)right{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setBottom:(CGFloat)bottom{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)bottom{
    return self.frame.size.height + self.frame.origin.y;
}

- (UIView *(^)(UIColor *color))setColor{
    return ^(UIColor *color){
        self.backgroundColor = color;
        return self;
    };
}

- (UIView *(^)(CGRect frame))setFrame{
    return ^(CGRect frame){
        self.frame = frame;
        return self;
    };
}

- (UIView *(^)(CGSize size)) setSize{
    return ^(CGSize size){
        self.bounds = CGRectMake(0, 0, size.width, size.height);
        return self;
    };
}

- (UIView *(^)(CGPoint point)) setCenter{
    return ^(CGPoint point){
        self.center = point;
        return self;
    };
}

- (UIView *(^)(NSInteger tag)) setTag{
    return ^(NSInteger tag){
        self.tag = tag;
        return self;
    };
}

- (void)setHollowWithCenterFrame:(CGRect)centerFrame{
    //UIBezierPath是绘图类
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path appendPath:[UIBezierPath bezierPathWithRect:self.frame]]; //根据矩形画贝塞尔曲线
    [path appendPath:[UIBezierPath bezierPathWithRect:centerFrame].bezierPathByReversingPath];  //反方向绘制path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];  //继承CALayer 每个CAShapeLayer对象都代表着将要被渲染到屏幕上的一个任意的形状,具体形状由path来决定
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}

- (UIImage *)imageFromSelfView{
    return [self imageFromViewWithFrame:self.frame];
}

- (UIImage *)imageFromViewWithFrame:(CGRect)frame{
    UIGraphicsBeginImageContext(self.frame.size);  // 该函数会自动创建一个context,并把它push到上下文栈顶
          //UIGraphicsBeginImageContextWithOptions(CGSize size, BOOL opaque, CGFloat scale)  第一个参数表示所要创建的图片尺寸  第二个参数用来指定所生成图片的背景是否为不透明，一般使用NO 如果设置成YES而且把backgroupColor设置成nil的话，就是黑色  第三个参数指定生成图片的缩放因子，这个缩放因子与UIImage的scale属性所指的含义是一样的 传入0则表示让图片的缩放因子根据屏幕的分辨率而变化，所以我们得到的图片是在单分辨率还是视网膜屏上看起来都会很好    该函数会自动创建一个context,并把它push到上下文栈顶，坐标系也经处理和UIKit坐标系相同
    CGContextRef context = UIGraphicsGetCurrentContext();   //获取当前上下文栈顶context UIView系统已为其准备好context并存入在栈顶了
    CGContextSaveGState(context);  //是将当前的图形状态推入堆栈。之后，你对图片状态所做的修改会影响随后的描画操作，但不影响存储在堆栈中的拷贝。 在修改完成后，可以通过 CGContextRestoreGState(<#CGContextRef  _Nullable c#>)函数把堆栈顶部的状态弹出，返回到之前的图形状态。这种推入和弹出的方式是回到之前图形状态的快速方法，避免逐个撤消所有的状态修改；这也是将某些状态(比如裁剪路径)恢复到原有设置的唯一方式
    UIRectClip(frame);  //裁剪
    [self.layer renderInContext:context]; //将view绘制到图形的上下文中
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();//把当前的context的内容输出成一个UIImage图片
    UIGraphicsEndImageContext();  //上下文栈Pop出创建的context
    return theImage;
}


@end
