//
//  NSObject+XKController.m
//  XKSquare
//
//  Created by Jamesholy on 2018/9/25.
//  Copyright © 2018年 xk. All rights reserved.
//

#import "NSObject+XKController.h"

@implementation NSObject (XKController)

/**常规写法*/
- (UIViewController *)getCurrentUIVC {
    return [self getCurrentVC];
}

- (UINavigationController *)getCurrentNav {
  return [self getCurrentUIVC].navigationController;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [self getCurrentVCFrom:[rootVC presentedViewController]];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];

    return currentVC;
}

/**
 从导航栏控制器中获取一个类的实例
 
 @param className 类名
 @return 该类的实例
 */
+ (nullable UIViewController *)getViewControllerFromCurrentStackWithClassName:(Class)className {
    return [self getViewControllerFromStack:[self getCurrentAvailableNavController] WithClassName:className];
}

/**
 获取当前可用的导航栏控制器
 
 @return 导航栏控制器
 */
+ (nullable UINavigationController *)getCurrentAvailableNavController {
    UIViewController *currentVC = [self getCurrentVC];
    if (currentVC) {
        return currentVC.navigationController;
    }
    return nil;
}

/**
 从导航栏控制器中获取一个类的实例
 
 @param className 类名
 @return 该类的实例
 */
+ (nullable UIViewController *)getViewControllerFromStack:(UINavigationController *)nav WithClassName:(Class)className {
    NSArray *vcs = nav.viewControllers;
    UIViewController *tempVC = nil;
    for (id vc in vcs) {
        if ([vc isMemberOfClass:className]) {
            tempVC = vc;
            break;
        }
    }
    return tempVC;
}

/**
 导航栏控制器中是否存在类
 
 @param className 类型
 @return YES 存在
 */
+ (BOOL)currentStackisContainClass:(Class)className {
    return [self oneStackisContainClass:className WithStack:[self getCurrentAvailableNavController]];
}

/**
 导航栏控制器中是否存在类
 
 @param className 类型
 @return YES 存在
 */
+ (BOOL)oneStackisContainClass:(Class)className WithStack:(UINavigationController *)nav {
    BOOL flag = NO;
    NSArray *vcs = nav.viewControllers;
    for (id vc in vcs) {
        if ([vc isMemberOfClass:className]) {
            flag = YES;
            break;
        }
    }
    return flag;
}

/**
 pop 到指定类名的vc
 
 @param className 类名
 */
+ (void)popToVCFromCurrentStackTargetVCClass:(Class)className {
    UIViewController *vc = [self getViewControllerFromCurrentStackWithClassName:className];
    if (vc) {
        [vc.navigationController popToViewController:vc animated:YES];
    }
}

/**
 导航栏控制器中移除类
 
 @param className 类名
 @return YES 成功
 */
+ (BOOL)cleanFromCurrentStackTargetVCClass:(Class)className {
    UIViewController *tempVC = [self getViewControllerFromCurrentStackWithClassName:className];
    if (tempVC) {
        [self removeVCFromCurrentStack:tempVC];
        return YES;
    }
    return NO;
}

/**
 导航栏控制器中移除类的数组
 
 @param classArray 类名数组
 */
+ (void)cleanFromCurrentStackTargetVCArrayClass:(NSArray<Class> *)classArray {
    NSMutableArray *tempVCS = [NSMutableArray new];
    UIViewController *currentVC = [self getCurrentVC];
    NSMutableArray *vcs = currentVC.navigationController.viewControllers.mutableCopy;
    for (Class className in classArray) {
        for (UIViewController *containVC in vcs) {
            if ([containVC isMemberOfClass:className]) {
                if (![tempVCS containsObject:containVC]) {
                    [tempVCS addObject:containVC];
                }
            }
        }
    }
    [vcs removeObjectsInArray:tempVCS];
    [currentVC.navigationController setViewControllers:vcs.copy];
}

/**
 移除当前控制器中，指定的类
 
 @param vcToRemove 要移除的类
 */
+ (void)removeVCFromCurrentStack:(__kindof UIViewController *)vcToRemove {
    UINavigationController *nav = [self getCurrentAvailableNavController];
    NSMutableArray *vcs = nav.viewControllers.mutableCopy;
    [vcs enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj == vcToRemove) {
            [vcs removeObject:obj];
        }
    }];
    nav.viewControllers = vcs;
}

/**
 移除当前控制器中，指定的类,数组
 
 @param vcsToRemove 要移除的类的数组
 */
+ (void)removeVCsFromCurrentStack:(NSArray <__kindof UIViewController *>*)vcsToRemove {
    UIViewController *vc = [vcsToRemove lastObject];
    NSMutableArray *vcs = vc.navigationController.viewControllers.mutableCopy;
    NSMutableArray *tempVcsToRemove = [NSMutableArray new];
    for (id vcToRemove in vcsToRemove) {
        for (UIViewController *tempVC in vcs) {
            if ([vcToRemove isEqual:tempVC]) {
                [tempVcsToRemove addObject:tempVC];
                break;
            }
        }
    }
    [vcs removeObjectsInArray:tempVcsToRemove];
    [vc.navigationController setViewControllers:vcs];
}


/**
 在当前控制器栈中添加一个vc到index位置
 
 @param vc vc
 @param index 要添加到位置
 */
+ (void)addVCToCurrentStack:( __kindof UIViewController * _Nonnull)vc toIndex:(NSUInteger)index {
    [self addVCsToCurrentStack:@[vc] toIndex:index];
}

/**
 在当前控制器栈中添加一个vc到index位置
 
 @param vcs vcs
 @param index 要添加到位置
 */
+ (void)addVCsToCurrentStack:(NSArray <__kindof UIViewController * > * _Nonnull)vcs toIndex:(NSUInteger)index {
    UIViewController *currentVC = [self getCurrentVC];
    NSMutableArray *array = currentVC.navigationController.viewControllers.mutableCopy;
    if (index >= array.count) {
        [array addObjectsFromArray:vcs];
    } else {
        [array insertObjects:vcs atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, vcs.count)]];
    }
    [currentVC.navigationController setViewControllers:array];
}

/**
 保持栈中仅有一个该类
 
 @param vc 类的实例
 @param nav 导航栏控制器
 */
+ (void)keepOnlyVC:(UIViewController *)vc FormStackWithNavigationController:(UINavigationController *)nav {
    NSMutableArray *tempVCS = [NSMutableArray new];
    NSMutableArray *vcs = nav.navigationController.viewControllers.mutableCopy;
    for (UIViewController *tempVC in vcs) {
        // 得到当前控制器中所有的vc
        if ([tempVC isMemberOfClass:[vc class]]) {
            [tempVCS addObject:tempVC];
        }
    }
    // 保留最后一个
    [tempVCS removeLastObject];
    [vcs removeObjectsInArray:tempVCS];
    [nav setViewControllers:vcs];
}

/**
 保持栈中仅有一个该类
 
 @param vc 类的实例
 */
+ (void)keepOnlyVC:(UIViewController *)vc {
     [self keepOnlyVC:vc FormStackWithNavigationController:[self getCurrentAvailableNavController]];
}

@end
