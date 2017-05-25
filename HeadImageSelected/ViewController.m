//
//  ViewController.m
//  HeadImageSelected
//
//  Created by blazer on 16/4/5.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "ViewController.h"
#import "SelectedViewController.h"

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, SelectedViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.headImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImageAction)]];
}

- (void)headImageAction{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"请选择..." preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            [self presentPickerViewController:UIImagePickerControllerSourceTypePhotoLibrary];
        }else{
            NSLog(@"相册暂无权限");
        }
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self presentPickerViewController:UIImagePickerControllerSourceTypeCamera];
        }else{
            NSLog(@"相机暂无权限");
        }
    }];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)presentPickerViewController:(UIImagePickerControllerSourceType)sourceType{
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    [pickerController setSourceType:sourceType];
    [pickerController setDelegate:self];
    [self presentViewController:pickerController animated:YES completion:nil];
}


#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        SelectedViewController *controller = [[SelectedViewController alloc] init];
        controller.imageOriginal = selectedImage;
        [controller setSizeClip:CGSizeMake(self.headImage.frame.size.width *2, self.headImage.frame.size.height *2)];
        controller.delegate = self;
        [self presentViewController:controller animated:YES completion:^{
            
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectedViewController:(SelectedViewController *)selectedViewController resultImage:(UIImage *)resultImage{
    self.headImage.image = resultImage;
}

@end
