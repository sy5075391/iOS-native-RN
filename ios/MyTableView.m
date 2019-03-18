/*******************************************************************************
 # File        : MyTableView.m
 # Project     : NativeInsertDemo
 # Author      : Jamesholy
 # Created     : 2018/12/8
 # Corporation :  水木科技
 # Description :
 <#Description Logs#>
 -------------------------------------------------------------------------------
 # Date        : <#Change Date#>
 # Author      : <#Change Author#>
 # Notes       :
 <#Change Logs#>
 ******************************************************************************/

#import "MyTableView.h"
#import "FirstViewController.h"

@implementation MyTableView

RCT_EXPORT_MODULE()

- (UIView *)view {
  FirstViewController *vc = [[FirstViewController alloc] init];
  vc.backgroundColor = [UIColor redColor];
  return vc;
}

@end
