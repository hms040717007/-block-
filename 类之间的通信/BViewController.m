//
//  BViewController.m
//  类之间的通信
//
//  Created by apple on 2018/12/17.
//  Copyright © 2018 HuangMS. All rights reserved.
//

#import "BViewController.h"

@interface BViewController ()
/**
 测试按钮
 */
@property (nonatomic, strong) UIButton *testBtn;

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"B类";
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.testBtn];
}

- (void)clickWithButton:(UIButton *)btn {
    if ([self.sendStr isEqualToString:@"block"]) {
        if (self.myBlock) {
            self.myBlock(self.sendStr);
        }
    }
    
    if ([self.sendStr isEqualToString:@"notification"]) {
        //通知:无参数
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"notification"
//                                                        object:nil];
        
//        //通知:有参数object
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"notification"
//                                                           object:[NSString stringWithFormat:@"%@有参数object",self.sendStr]];
        
        //通知:有参数userInfo(NSDictionary类型的)
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSString stringWithFormat:@"%@有参数userInfo",self.sendStr]
                 forKey:@"key"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"notification"
                                                           object:nil
                                                         userInfo:dict];
    }
    
    if ([self.sendStr isEqualToString:@"delegate"]) {
        if ([self.delegate respondsToSelector:@selector(bViewControllerSendTitle:)]) {
            [self.delegate bViewControllerSendTitle:@"delegate"];
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIButton *)testBtn {
    if (!_testBtn) {
        _testBtn = [self creatBtnWithTitle:@"通信传至"];
        _testBtn.frame = CGRectMake(50, 100, 280, 59);
    }
    
    return _testBtn;
}

- (UIButton *)creatBtnWithTitle:(NSString *)title {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.blackColor
              forState:UIControlStateNormal];
    
    btn.layer.borderWidth = 2.0;
    btn.layer.borderColor = UIColor.blackColor.CGColor;
    [self.view addSubview:btn];
    
    [btn addTarget:self
            action:@selector(clickWithButton:)
  forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

@end
