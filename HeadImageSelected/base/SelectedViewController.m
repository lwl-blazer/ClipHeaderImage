//
//  SelectedViewController.m
//  HeadImageSelected
//
//  Created by blazer on 16/4/5.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "SelectedViewController.h"
#import "UIView+BL.h"

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface SelectedViewController ()

@property(nonatomic, strong) UIView *viewOverlay;  //覆盖图
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIButton *buttonConfirm;
@property(nonatomic, strong) UIButton *buttonCancel;

@property(nonatomic, assign) CGRect rectClip;

@end

@implementation SelectedViewController

- (void)setSizeClip:(CGSize)sizeClip{
    _sizeClip = sizeClip;
    CGFloat clipW = sizeClip.width;
    CGFloat clipH = sizeClip.height;
    CGFloat clipX = ([UIScreen mainScreen].bounds.size.width - clipW) / 2;
    CGFloat clipY = ([UIScreen mainScreen].bounds.size.height - clipH) / 2;
    _rectClip = CGRectMake(clipX, clipY, clipW, clipH);
}

- (UIView *)viewOverlay{
    if (_viewOverlay == nil) {
        _viewOverlay = [[UIView alloc] initWithFrame:self.self.view.bounds];
        [_viewOverlay setBackgroundColor:[UIColor blackColor]];
        [_viewOverlay setAlpha:102.0/255];
    }
    return _viewOverlay;
}

- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
        [_imageView setUserInteractionEnabled:YES];
        [_imageView setMultipleTouchEnabled:YES];
    }
    return _imageView;
}

- (UIButton *)buttonCancel
{
    if (!_buttonCancel) {
        CGFloat buttonW = 40;
        CGFloat buttonH = 28;
        CGFloat buttonX = 16;
        CGFloat buttonY = [UIScreen mainScreen].bounds.size.height - buttonH - 16;
        _buttonCancel = [[UIButton alloc]initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        [_buttonCancel setBackgroundColor:RGBA(0, 0, 0, 50.0/255)];
        [_buttonCancel setTitle:@"取消" forState:UIControlStateNormal];
        [_buttonCancel setTitleColor:[UIColor whiteColor]
                            forState:UIControlStateNormal];
        [_buttonCancel.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        [_buttonCancel setClipsToBounds:YES];
        [_buttonCancel.layer setCornerRadius:2];
        [_buttonCancel.layer setBorderWidth:0.5];
        [_buttonCancel.layer setBorderColor:RGBA(255, 255, 255, 60.0/255).CGColor];
        [_buttonCancel addTarget:self
                          action:@selector(cancel)
                forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonCancel;
}
/** 3.确认按钮 */
- (UIButton *)buttonConfirm
{
    if (!_buttonConfirm) {
        CGFloat buttonW = 40;
        CGFloat buttonH = 28;
        CGFloat buttonX = [UIScreen mainScreen].bounds.size.width - buttonW - 16;
        CGFloat buttonY = [UIScreen mainScreen].bounds.size.height - buttonH - 16;
        _buttonConfirm = [[UIButton alloc]initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        [_buttonConfirm setBackgroundColor:RGBA(0, 0, 0, 50.0/255)];
        [_buttonConfirm setTitle:@"确定" forState:UIControlStateNormal];
        [_buttonConfirm setTitleColor:[UIColor whiteColor]
                             forState:UIControlStateNormal];
        [_buttonConfirm.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        [_buttonConfirm setClipsToBounds:YES];
        [_buttonConfirm.layer setCornerRadius:2];
        [_buttonConfirm.layer setBorderWidth:0.5];
        [_buttonConfirm.layer setBorderColor:RGBA(255, 255, 255, 60.0/255).CGColor];
        [_buttonConfirm addTarget:self
                           action:@selector(confirm)
                 forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonConfirm;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sizeClip = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.viewOverlay setHollowWithCenterFrame:self.rectClip];
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self.imageView setImage:self.imageOriginal];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.viewOverlay];
    [self.view addSubview:self.buttonCancel];
    [self.view addSubview:self.buttonConfirm];
    [self addAllGestureRecognizer:self.view];
}

- (void)addAllGestureRecognizer:(UIView *)view{
    [view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)]];  //拖动
    [view addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)]]; //缩放
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)panView:(UIPanGestureRecognizer *)panGestureRecognizer{
    UIView *view = self.imageView;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];  //返回在横坐标上和纵坐标上拖动了多少像素
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}]; //用view的center的值进行重新计算
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
}

- (void)pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer{
    UIView *view = self.imageView;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        pinchGestureRecognizer.scale = 1;
    }
}

- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)confirm{
    if ([self.delegate respondsToSelector:@selector(selectedViewController:resultImage:)]) {
        [self.delegate selectedViewController:self resultImage:[self getResultImage]];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)getResultImage{
    UIImage *image = [self.view imageFromSelfView];
    return [self croppedImage:self.rectClip image:image];
}

//根据尺寸来裁剪图片
- (UIImage *)croppedImage:(CGRect)bounds image:(UIImage *)oldImage{
    CGFloat scale = MAX(oldImage.scale, 1.0f);
    CGRect scaleBounds = CGRectMake(bounds.origin.x *scale, bounds.origin.y * scale, bounds.size.width *scale, bounds.size.height *scale);
    CGImageRef imageRef = CGImageCreateWithImageInRect([oldImage CGImage], scaleBounds);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef scale:oldImage.scale orientation:UIImageOrientationUp];
    CGImageRelease(imageRef);
    return croppedImage;
}
                                                               
@end
