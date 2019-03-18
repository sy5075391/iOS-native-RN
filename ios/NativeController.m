/*******************************************************************************
 # File        : NativeController.m
 # Project     : NativeInsertDemo
 # Author      : Jamesholy
 # Created     : 2019/3/18
 # Corporation : 水木科技
 # Description :
 <#Description Logs#>
 -------------------------------------------------------------------------------
 # Date        : <#Change Date#>
 # Author      : <#Change Author#>
 # Notes       :
 <#Change Logs#>
 ******************************************************************************/

#import "NativeController.h"

@interface NativeController ()

@end

@implementation NativeController

#pragma mark ----------------------------- 生命周期 ------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化默认数据
    [self createDefaultData];
    // 初始化界面
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

- (void)dealloc {
    NSLog(@"=====%@被销毁了=====", [self class]);
}

#pragma mark - 初始化默认数据
- (void)createDefaultData {
    
}

#pragma mark - 初始化界面
- (void)createUI {
  self.view.backgroundColor = [UIColor whiteColor];
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 40, 400, 200)];
  label.font = [UIFont systemFontOfSize:19];
  label.textColor = [UIColor redColor];
  label.textAlignment = NSTextAlignmentLeft;
  label.text =@"原生界面，点击回到RN界面";
  [self.view addSubview:label];
}

#pragma mark ----------------------------- 其他方法 ------------------------------

#pragma mark ----------------------------- 公用方法 ------------------------------

#pragma mark ----------------------------- 网络请求 ------------------------------

#pragma mark ----------------------------- 代理方法 ------------------------------

#pragma mark --------------------------- setter&getter -------------------------

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self.navigationController popViewControllerAnimated:YES];
}

@end
