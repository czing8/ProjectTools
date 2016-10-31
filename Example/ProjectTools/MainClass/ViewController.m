//
//  ViewController.m
//  ProjectTools
//
//  Created by Vols on 2016/10/25.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "ViewController.h"

#import "VDeviceHelper.h"
#import "DataCenter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    NSLog(@"%ld", (long)[VDeviceHelper shared].processorSpeed);
    NSLog(@"%@", [VDeviceHelper shared].machineModelName);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
