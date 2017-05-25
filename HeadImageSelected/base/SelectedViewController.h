//
//  SelectedViewController.h
//  HeadImageSelected
//
//  Created by blazer on 16/4/5.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectedViewController;

@protocol SelectedViewControllerDelegate <NSObject>

- (void)selectedViewController:(SelectedViewController *)selectedViewController resultImage:(UIImage *)resultImage;

@end

@interface SelectedViewController : UIViewController

@property(nonatomic, strong) UIImage *imageOriginal;
@property(nonatomic, assign) CGSize sizeClip;
@property(nonatomic, weak) id<SelectedViewControllerDelegate>delegate;

@end
