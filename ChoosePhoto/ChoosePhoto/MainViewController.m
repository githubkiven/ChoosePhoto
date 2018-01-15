//
//  MainViewController.m
//  ChoosePhoto
//
//  Created by smppw_zwq on 2018/1/11.
//  Copyright © 2018年 SMPPW. All rights reserved.
//

#import "MainViewController.h"
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height
// 获取屏幕宽度 即:整屏的宽度
#define kScreenWidth            [[UIScreen mainScreen] bounds].size.width

@interface MainViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UIButton * positiveButton;
@property(nonatomic,strong) UIButton * reverseButton;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"首页";
    
    self.automaticallyAdjustsScrollViewInsets= NO;
    
    [self creatMainView];
    



}

- (void)creatMainView{
    
    
    _positiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _positiveButton.frame = CGRectMake((kScreenWidth-320)/2, 80, 320, 185);
    [_positiveButton setImage:[UIImage imageNamed:@"身份证正面"] forState:UIControlStateNormal];
    _positiveButton.backgroundColor = [UIColor grayColor];
    [_positiveButton addTarget:self action:@selector(positiveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_positiveButton];
    
    
    
    _reverseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _reverseButton.frame = CGRectMake((kScreenWidth-320)/2, 80+185+50, 320, 185);
    [_reverseButton setImage:[UIImage imageNamed:@"身份证反面"] forState:UIControlStateNormal];
    _reverseButton.backgroundColor = [UIColor grayColor];
    [_reverseButton addTarget:self action:@selector(reverseButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_reverseButton];

    
}

- (void)positiveButtonClick{
    
    NSLog(@"正面照片");
    
    UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"从相册选择", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;

    
    [actionSheet showInView:self.view];
    
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex-----%zi",buttonIndex);
    
    if (buttonIndex==0) {
        
        NSLog(@"拍照");
        
        [self openCamera];
        
    }else if (buttonIndex==1){
        
        NSLog(@"从相册选择");

        [self openPhotoLibrary];
    }
    
    
    // button 点击处理（然后从上往下增加从0开始，注意与alertView 不一样！）
}

/**
 
 *  调用照相机
 
 */

- (void)openCamera

{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    
    picker.allowsEditing = YES; //可编辑
    
    //判断是否可以打开照相机
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        
        //摄像头
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }
    
    else
        
    {
        
        NSLog(@"没有摄像头");
        
    }
    
}


/**
 
 *  打开相册
 
 */

-(void)openPhotoLibrary

{
    
    // Supported orientations has no common orientation with the application, and [PUUIAlbumListViewController shouldAutorotate] is returning YES
    
    
    // 进入相册
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        
    {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        
        imagePicker.allowsEditing = YES;
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        imagePicker.delegate = self;
        
        [self presentViewController:imagePicker animated:YES completion:^{
            
            NSLog(@"打开相册");
            
        }];
        
    }
    
    else
        
    {
        
        NSLog(@"不能打开相册");
        
    }
    
}

#pragma mark - UIImagePickerControllerDelegate

// 拍照完成回调

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)

{
    
    NSLog(@"finish..");
    
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        
    {
        
        //图片存入相册
        [_positiveButton setImage:image forState:0];

        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        
    }
    if(picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary)
    {
        [_positiveButton setImage:image forState:0];

    }
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//进入拍摄页面点击取消按钮

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker

{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (void)reverseButtonClick{
    
    
    NSLog(@"反面照片");

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
