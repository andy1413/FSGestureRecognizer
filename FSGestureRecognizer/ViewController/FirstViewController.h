//
//  FirstViewController.h
//  GestureRecognizer
//
//  Created by 王方帅 on 15/6/28.
//  Copyright (c) 2015年 王方帅. All rights reserved.
//

#import <UIKit/UIKit.h>

enum Status
{
    Status_None = 0,
    
    Status_FirstLongPress = 11,
    Status_SecondLongPress = 12,
    Status_ThirdLongPress = 13,
    
    Status_FirstPan = 111,
    Status_SecondPan = 112,
    Status_ThirdPan = 113,
};

@interface FirstViewController : UIViewController<UIGestureRecognizerDelegate>
{
    IBOutlet UILabel        *_firstLabel;
    IBOutlet UILabel        *_secondLabel;
    IBOutlet UILabel        *_thirdLabel;
    IBOutlet UITextField    *_textField;
    
    CGRect                  _firstLabelFrame;
    CGRect                  _secondLabelFrame;
    CGRect                  _thirdLabelFrame;
    CGRect                  _textFrame;
    
    enum Status             _status;
    
    BOOL                    _isEntry;
}

@end
