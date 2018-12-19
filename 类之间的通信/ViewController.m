//
//  ViewController.m
//  类之间的通信
//
//  Created by apple on 2018/12/17.
//  Copyright © 2018 HuangMS. All rights reserved.
//

#import "ViewController.h"

#import "AViewController.h"

/**
 类之间的通信:Block/通知/委托代理
 KVO/KVC/Timer
 */
@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"学习条目";
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 100, 280, 50);
    btn.layer.borderColor = [UIColor grayColor].CGColor;
    btn.layer.borderWidth = 2.0;
    [btn setTitle:@"类之间通信"
         forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.blackColor
              forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    [btn addTarget:self
            action:@selector(btnClick)
  forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)btnClick {
    AViewController *aVC = [[AViewController alloc]init];
    [self.navigationController pushViewController:aVC
                                         animated:YES];
}

@end
