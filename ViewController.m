//
//  ViewController.m
//  chooseImageDemo
//
//  Created by lixiang on 2017/2/8.
//  Copyright © 2017年 chaoshenglu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(90, 90, 90, 90)];
    [btn setTitleColor:[UIColor blueColor] forState:0];
    [btn setTitle:@"选取照片" forState:0];
    [btn addTarget:self action:@selector(click2chooseImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 190, 300, 300)];
    self.imgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.imgView.layer.borderWidth = 0.5;
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imgView];
}

- (void)click2chooseImage {
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"相机", nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self chooseInAlbum];
    } else if (buttonIndex == 1) {
        [self takePhoto];
    }
}

- (void)takePhoto {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePickerController.allowsEditing = YES;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
    }
}

- (void)chooseInAlbum {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.imagePickerController.allowsEditing = NO;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        if (image == nil){
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        self.imgView.image = image;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (UIImagePickerController *)imagePickerController {
    if (_imagePickerController == nil) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
    }
    return _imagePickerController;
}

@end





