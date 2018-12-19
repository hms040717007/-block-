//
//  AViewController.m
//  类之间的通信
//
//  Created by apple on 2018/12/17.
//  Copyright © 2018 HuangMS. All rights reserved.
//

#import "AViewController.h"

#import "BViewController.h"

@interface AViewController ()<BViewControllerDelegate>

/**
 block
 */
@property (nonatomic, strong) UIButton *blockBtn;

/**
 通知
 */
@property (nonatomic, strong) UIButton *notificationBtn;

/**
 代理
 */
@property (nonatomic, strong) UIButton *delegateBtn;

@end

@implementation AViewController

#pragma mark - life cycle(生命周期)
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"A类";
    self.view.backgroundColor = UIColor.whiteColor;
    
    /**
     通知 无参数接收

     @param notificationWithParameterless 通知实现方法
     @namet 通知唯一标识字符串
     */
//    [[NSNotificationCenter defaultCenter]addObserver:self
//                                            selector:@selector(notificationWithParameterless) name:@"notification"
//                                              object:nil];
    /**
     通知 参数object
     
     @param notificationWithParameterless 通知实现方法
     @namet 通知唯一标识字符串
     */
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(notificationWithParameterlessWithStr:)
                                                name:@"notification"
                                              object:nil];
    //添加子视图
    [self addSubViews];
}

#pragma mark - deallc移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - delegate(代理方法)
#pragma mark - 代理:方法(进行传值或改变)
- (void)bViewControllerSendTitle:(NSString *)title {
    [self.delegateBtn setTitle:title
                      forState:UIControlStateNormal];
    [self.delegateBtn setTitleColor:UIColor.redColor
                           forState:UIControlStateNormal];
    self.delegateBtn.layer.borderColor = UIColor.yellowColor.CGColor;
}

#pragma mark - private method(私有方法)
#pragma mark - 通知:方法(无参数)
//- (void)notificationWithParameterless {
//    [self.notificationBtn setTitle:@"notification传值成功"
//                           forState:UIControlStateNormal];
//    [self.notificationBtn setTitleColor:UIColor.redColor
//                               forState:UIControlStateNormal];
//    self.notificationBtn.layer.borderColor = UIColor.yellowColor.CGColor;
//}

//#pragma mark - 通知:方法 参数:object
//- (void)notificationWithParameterlessWithStr:(NSNotification *)notification {
//    //数据类型是什么就用什么接收
//    NSString *title = [notification object];
//    [self.notificationBtn setTitle:[NSString stringWithFormat: @"%@传值成功",title]
//                          forState:UIControlStateNormal];
//    [self.notificationBtn setTitleColor:UIColor.redColor
//                               forState:UIControlStateNormal];
//    self.notificationBtn.layer.borderColor = UIColor.yellowColor.CGColor;
//}

#pragma mark - 通知:方法 参数:userInfo
- (void)notificationWithParameterlessWithStr:(NSNotification *)notification  {
    //XXX.userInfo为字典类型
    //第一种形式 接收
//    NSString *info1 = notification.userInfo[@"key"];
    
    //第二种形式 接收
    NSDictionary *dict = notification.userInfo;
    NSString *info2 = [dict valueForKey:@"key"];
    
    [self.notificationBtn setTitle:info2
                          forState:UIControlStateNormal];
    [self.notificationBtn setTitleColor:UIColor.redColor
                               forState:UIControlStateNormal];
    self.notificationBtn.layer.borderColor = UIColor.yellowColor.CGColor;
}

#pragma mark - response method(点击/响应方法)
#pragma mark - 统一处理按钮点击事件
- (void)clickWithButton:(UIButton *)btn {
    BViewController *bVC = [[BViewController alloc]init];
    //代理:设置为代理
    bVC.delegate = self;
    //block:block代码块传值
    [bVC setMyBlock:^(NSString * title) {
        [self.blockBtn setTitle:[NSString stringWithFormat:@"%@传值成功", title]
                       forState:UIControlStateNormal];
        [self.blockBtn setTitleColor:UIColor.redColor
                            forState:UIControlStateNormal];
        self.blockBtn.layer.borderColor = UIColor.yellowColor.CGColor;
    }];
    
    //预传不同字符串
    if (btn == self.blockBtn) {
        bVC.sendStr = @"block";
    }
    if (btn == self.notificationBtn) {
        bVC.sendStr = @"notification";
    }
    if (btn == self.delegateBtn) {
        bVC.sendStr = @"delegate";
    }
    
    //统一跳转
    [self.navigationController pushViewController:bVC
                                         animated:YES];
}

#pragma mark - 添加子视图方法
- (void)addSubViews {
    [self.view addSubview:self.blockBtn];
    [self.view addSubview:self.delegateBtn];
    [self.view addSubview:self.notificationBtn];
}

#pragma mark - lazy
- (UIButton *)blockBtn {
    if (!_blockBtn) {
        _blockBtn = [self creatBtnWithTitle:@"block通信"];
        _blockBtn.frame = CGRectMake(50, 100, 280, 50);
    }
    return _blockBtn;
}

- (UIButton *)notificationBtn {
    if (!_notificationBtn) {
        _notificationBtn = [self creatBtnWithTitle:@"notification通信"];
        _notificationBtn.frame = CGRectMake(50, 200, 280, 50);
    }
    return _notificationBtn;
}

- (UIButton *)delegateBtn {
    if (!_delegateBtn) {
        _delegateBtn = [self creatBtnWithTitle:@"delegate通信"];
        _delegateBtn.frame = CGRectMake(50, 300, 280, 50);

    }
    return _delegateBtn;
}

#pragma mark - getter or setter
#pragma mark - 统一设置初始化按钮
- (UIButton *)creatBtnWithTitle:(NSString *)title {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    
    btn.layer.borderWidth = 2.0;
    btn.layer.borderColor = UIColor.blackColor.CGColor;
    [self.view addSubview:btn];
    
    [btn addTarget:self
            action:@selector(clickWithButton:)
  forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

@end
