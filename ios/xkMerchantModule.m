//
//  TestModul.m
//  xkMerchant
//
//  Created by qiushaoyu on 2018/8/16.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "xkMerchantModule.h"
#import "NSObject+XKController.h"
#import "NativeController.h"
#define KEY_WINDOW   [UIApplication sharedApplication].keyWindow

@interface xkMerchantModule()


@end

@implementation xkMerchantModule
RCT_EXPORT_MODULE();


RCT_EXPORT_METHOD(popNative)
{
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.getCurrentUIVC.navigationController popViewControllerAnimated:YES];
  });
}

RCT_EXPORT_METHOD(pushNative)
{
  dispatch_async(dispatch_get_main_queue(), ^{
    NativeController *vc =[NativeController new];
    [self.getCurrentUIVC.navigationController pushViewController:vc animated:YES];
  });
}


@end
