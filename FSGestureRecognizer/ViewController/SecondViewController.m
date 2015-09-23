//
//  SecondViewController.m
//  GestureRecognizer
//
//  Created by 王方帅 on 15/6/28.
//  Copyright (c) 2015年 王方帅. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes:)];
    tapGes.delegate = self;
    [_imageView addGestureRecognizer:tapGes];
    
    UITapGestureRecognizer *doubleTapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGes:)];
    doubleTapGes.delegate = self;
    doubleTapGes.numberOfTapsRequired = 2;
    [_imageView addGestureRecognizer:doubleTapGes];
    
    [tapGes requireGestureRecognizerToFail:doubleTapGes];
    
    UILongPressGestureRecognizer *longPressGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGes:)];
    longPressGes.delegate = self;
    [_imageView addGestureRecognizer:longPressGes];
    
    UIPinchGestureRecognizer *pinchGes = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGes:)];
    pinchGes.delegate = self;
    [_imageView addGestureRecognizer:pinchGes];
    
    [tapGes requireGestureRecognizerToFail:pinchGes];
    
    UIRotationGestureRecognizer *rotationGes = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGes:)];
    rotationGes.delegate = self;
    [_imageView addGestureRecognizer:rotationGes];
}

-(void)tapGes:(UITapGestureRecognizer *)tap
{
    NSLog(@"tapGes---%@",tap);
    if (self.navigationController.navigationBarHidden == YES)
    {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    else
    {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

-(void)doubleTapGes:(UITapGestureRecognizer *)tap
{
    NSLog(@"doubleTapGes---%@",tap);
    CGPoint location = [tap locationInView:self.view];
    
    [UIView animateWithDuration:0.2 animations:^{
        if (_ismagnifyStatus)
        {
            _imageView.frame = self.view.bounds;
            _ismagnifyStatus = NO;
        }
        else
        {
            CGRect rect = _imageView.frame;
            rect.size.width *= 2;
            rect.size.height *= 2;
            rect.origin.x -= location.x;
            rect.origin.y -= location.y;
            _imageView.frame = rect;
            _ismagnifyStatus = YES;
        }
    }];
}

-(void)longPressGes:(UILongPressGestureRecognizer *)ges
{
    NSLog(@"longPressGes---%@",ges);
    if (!_sheet)
    {
        _sheet = [[UIActionSheet alloc] initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存到相册", nil];
        [_sheet showInView:self.view];
    }
}

-(void)pinchGes:(UIPinchGestureRecognizer *)ges
{
    NSLog(@"pinchGes---%@",ges);
    //手势改变时
    if (ges.state == UIGestureRecognizerStateChanged)
    {
        //捏合手势中scale属性记录的缩放比例
        _imageView.transform = CGAffineTransformScale(_imageView.transform,ges.scale, ges.scale);
        ges.scale = 1;
    }
    
    //结束后恢复
    if(ges.state==UIGestureRecognizerStateEnded && _imageView.frame.size.width < self.view.bounds.size.width)
    {
        [UIView animateWithDuration:0.2 animations:^{
            _imageView.transform = CGAffineTransformIdentity;//取消一切形变
            _imageView.frame = self.view.bounds;
        }];
    }
}

-(void)rotationGes:(UIRotationGestureRecognizer *)ges
{
    NSLog(@"rotationGes---%@",ges);
    CGPoint location = [ges locationInView:self.view];
    ges.view.center = CGPointMake(location.x, location.y);
    if ([ges state] == UIGestureRecognizerStateEnded) {
        if(ges.state==UIGestureRecognizerStateEnded && _imageView.frame.size.width < self.view.bounds.size.width)
        {
            [UIView animateWithDuration:0.2 animations:^{
                _imageView.transform = CGAffineTransformIdentity;//取消一切形变
                _imageView.frame = self.view.bounds;
            }];
        }
        self.lastRotation = 0;
        return;
    }
    CGAffineTransform currentTransform = _imageView.transform;
    CGFloat rotation = (ges.rotation - self.lastRotation);
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, rotation);
    _imageView.transform = newTransform;
    self.lastRotation = ges.rotation;
}

#pragma mark -UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.firstOtherButtonIndex == buttonIndex)
    {
        UIImageWriteToSavedPhotosAlbum(_imageView.image, nil, nil, nil);
    }
    _sheet = nil;
}

#pragma mark -UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
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
