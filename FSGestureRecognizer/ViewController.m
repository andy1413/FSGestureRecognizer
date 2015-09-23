//
//  ViewController.m
//  FSGestureRecognizer
//
//  Created by 王方帅 on 15/9/23.
//  Copyright (c) 2015年 王方帅. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -IBAction
-(IBAction)firstButtonTouchUp:(id)sender
{
    FirstViewController *firstC = [[FirstViewController alloc] init];
    [self.navigationController pushViewController:firstC animated:YES];
}

-(IBAction)secondButtonTouchUp:(id)sender
{
    SecondViewController *secondC = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
