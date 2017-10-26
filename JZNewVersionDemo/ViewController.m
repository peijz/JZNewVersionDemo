//
//  ViewController.m
//  JZNewVersionDemo
//
//  Created by wanhongios on 2017/10/25.
//  Copyright © 2017年 wanhongios. All rights reserved.
//

#import "ViewController.h"
#import "JZNewVersionView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"版本新特性";
    self.view.backgroundColor = [UIColor brownColor];
    
    JZNewVersionView *jz_newVersionView = [[JZNewVersionView alloc]initWithFrame:self.view.bounds datas:[NSArray arrayWithObjects:@"u=2771784367,1529189070&fm=27&gp=0.jpg",@"u=2398155085,3520102918&fm=27&gp=0.jpg",@"u=2514746018,3381081595&fm=27&gp=0.jpg",@"u=4266564208,2452097814&fm=11&gp=0.jpg",@"u=87941439,1125787948&fm=11&gp=0.jpg", nil]];
    [jz_newVersionView newVersionViewEnterBlock:^{
        NSLog(@"点击了版本新特性");
    }];
    [self.view addSubview:jz_newVersionView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
