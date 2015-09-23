//
//  FirstViewController.m
//  GestureRecognizer
//
//  Created by 王方帅 on 15/6/28.
//  Copyright (c) 2015年 王方帅. All rights reserved.
//

#import "FirstViewController.h"

#define kLabel1Tag  11
#define kLabel2Tag  12
#define kLabel3Tag  13

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //长按手势
    UILongPressGestureRecognizer *longPressGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(labelLongPress:)];
    longPressGes.delegate = self;
    [_firstLabel addGestureRecognizer:longPressGes];
    
    longPressGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(labelLongPress:)];
    longPressGes.delegate = self;
    [_secondLabel addGestureRecognizer:longPressGes];
    
    longPressGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(labelLongPress:)];
    longPressGes.delegate = self;
    [_thirdLabel addGestureRecognizer:longPressGes];
    
    //拖曳手势
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(labelPan:)];
    panGes.delegate = self;
    [_firstLabel addGestureRecognizer:panGes];
    
    panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(labelPan:)];
    panGes.delegate = self;
    [_secondLabel addGestureRecognizer:panGes];
    
    panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(labelPan:)];
    panGes.delegate = self;
    [_thirdLabel addGestureRecognizer:panGes];
    
    _firstLabelFrame = _firstLabel.frame;
    _secondLabelFrame = _secondLabel.frame;
    _thirdLabelFrame = _thirdLabel.frame;
    _textFrame = _textField.frame;
}

-(void)gesEndedWithLabel:(UILabel *)label
{
    [UIView animateWithDuration:0.2 animations:^{
        switch (label.tag)
        {
            case Status_FirstLongPress:
            {
                label.frame = _firstLabelFrame;
            }
                break;
            case Status_SecondLongPress:
            {
                label.frame = _secondLabelFrame;
            }
                break;
            case Status_ThirdLongPress:
            {
                label.frame = _thirdLabelFrame;
            }
                break;
                
            default:
                break;
        }
        _textField.frame = _textFrame;
    }];
    _status = Status_None;
}

-(void)labelLongPress:(UILongPressGestureRecognizer *)ges
{
    UILabel *label = (UILabel *)ges.view;
    
    if (ges.state == UIGestureRecognizerStateEnded)
    {
        [self gesEndedWithLabel:label];
        
        return;
    }
    
    if (_status == Status_None)
    {
        _status = (enum Status)(label.tag);
        CGRect rect = label.frame;
        rect.origin.x -= 10;
        rect.origin.y -= 10;
        rect.size.width += 20;
        rect.size.height += 20;
        [UIView animateWithDuration:0.2 animations:^{
            label.frame = rect;
        }];
    }
}

-(void)labelPan:(UIPanGestureRecognizer *)ges
{
    UILabel *label = (UILabel *)ges.view;
    
    if (ges.state == UIGestureRecognizerStateEnded)
    {
        if (_isEntry)
        {
            _textField.text = label.text;
            _isEntry = NO;
        }
        [self gesEndedWithLabel:label];
        return;
    }
    
    if (_status != Status_None)
    {
        _status = (enum Status)(label.tag + 100);
        CGPoint location = [ges locationInView:label.superview];
        label.center = location;
        
        BOOL centerXIsEntry = location.x > _textField.frame.origin.x && (location.x < _textField.frame.origin.x + _textField.frame.size.width);
        BOOL centerYIsEntry = location.y > _textField.frame.origin.y && (location.y < _textField.frame.origin.y + _textField.frame.size.height);
        if (centerXIsEntry && centerYIsEntry)
        {
            CGRect rect = _textFrame;
            rect.origin.x -= 10;
            rect.origin.y -= 10;
            rect.size.width += 20;
            rect.size.height += 20;
            
            [UIView animateWithDuration:0.2 animations:^{
                _textField.frame = rect;
            }];
            _isEntry = YES;
        }
        else
        {
            [UIView animateWithDuration:0.2 animations:^{
                _textField.frame = _textFrame;
            }];
            _isEntry = NO;
        }
    }
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
