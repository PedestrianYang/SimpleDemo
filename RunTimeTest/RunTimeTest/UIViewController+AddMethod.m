//
//  UIViewController+AddMethod.m
//  RunTimeTest
//
//  Created by ymq on 16/3/8.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "UIViewController+AddMethod.h"
#import <objc/runtime.h>


typedef id(*_IMP)(id, SEL, ...);
typedef void(*_VIMP)(id, SEL, ...);
@implementation UIViewController(AddMethod)

/**
 *  1.通过重写viewDidLoad方法增加代码
 */
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method viewDidLoad = class_getInstanceMethod(self, @selector(viewDidLoad));
        Method viewDidLoadAdd = class_getInstanceMethod(self, @selector(viewDidLoadAdd));
        method_exchangeImplementations(viewDidLoad, viewDidLoadAdd);
    });
}

- (void)viewDidLoadAdd
{
    [self viewDidLoadAdd];
    Class class1 = NSClassFromString(@"ViewController");
    Class class2 = NSClassFromString(@"SecondViewController");
    if ([self isKindOfClass:class1] || [self isKindOfClass:class2])
    {
        NSLog(@"%@",[self class]);
    }
}


/**
 *  2.通过方法指针IMP，调用方法添加代码
 */
//+(void)load
//{
//    static dispatch_once_t onceTaken;
//    dispatch_once(&onceTaken, ^{
//        Method viewDidLoad = class_getInstanceMethod(self, @selector(viewDidLoad));
//        _VIMP viewDidLoad_IMP = (_VIMP)method_getImplementation(viewDidLoad);
//        method_setImplementation(viewDidLoad,imp_implementationWithBlock(^(id target, SEL action){
//            viewDidLoad_IMP(self, @selector(viewDidLoad));
//            NSLog(@"%@",[self class]);
//            
//        }));
//        
//    });
//}

@end
