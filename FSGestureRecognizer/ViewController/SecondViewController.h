//
//  SecondViewController.h
//  GestureRecognizer
//
//  Created by 王方帅 on 15/6/28.
//  Copyright (c) 2015年 王方帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController<UIGestureRecognizerDelegate,UIActionSheetDelegate>
{
    IBOutlet UIImageView        *_imageView;
    BOOL                        _ismagnifyStatus;
    UIActionSheet               *_sheet;
}

@property (nonatomic) CGFloat   lastRotation;

@end
