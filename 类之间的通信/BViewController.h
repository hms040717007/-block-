//
//  BViewController.h
//  类之间的通信
//
//  Created by apple on 2018/12/17.
//  Copyright © 2018 HuangMS. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN
/**
 添加协议方法 - 协议的名称一般是由:"类名+Delegate"
 
 @required//代理方必须实现的方法
 @optional//代理方可选实现的方法

 */
@protocol BViewControllerDelegate <NSObject>

#pragma mark - 代理方法(代理方法名称:类名+方法名)
- (void)bViewControllerSendTitle:(NSString *)title;

@end

@interface BViewController : UIViewController

/**
 通信来源 - 字符串
 */
@property (nonatomic, strong) NSString *sendStr;

/**
 通信 - block
 Q:iOS block修饰符为什么用copy
 1.block本身是像对象一样可以retain，和release。
 但是，block在创建的时候，它的内存是分配在栈(stack)上，而不是在堆(heap)上。
 他本身的作于域是属于创建时候的作用域，一旦在创建时候的作用域外面调用block将导致程序崩溃。
 2.使用retain也可以，但是block的retain行为默认是用copy的行为实现的，
 因为block变量默认是声明为栈变量的，为了能够在block的声明域外使用，所以要把block拷贝（copy）到堆，
 所以说为了block属性声明和实际的操作一致，最好声明为copy。
 
 block容易造成循环引用，在block里面如果使用了self，然后形成强引用时，需要打断循环引用；
 在MRC下用_block，在ARC下使用__weak
 */
@property (nonatomic, copy) void(^myBlock)(NSString *title);

//委托代理人，为了避免造成循环引用，代理一般需使用弱引用
@property (nonatomic, weak) id<BViewControllerDelegate> delegate;

/**
 Q:iOS 代理为什么要用weak修饰
 解:
 weak:指明该对象并不负责保持delegate这个对象，delegate这个对象的销毁由外部控制
 strong：该对象强引用delegate，外界不能销毁delegate对象，会导致循环引用(Retain Cycles)
 assing：也有weak的功效。但是网上有assign是指针赋值，不对引用计数操作，使用之后如果没有置为nil，可能就会产生野指针；而weak一旦不进行使用后，永远不会使用了，就不会产生野指针
 */
@end

NS_ASSUME_NONNULL_END
