//
//  ALayoutViewController.m
//  iOSKnowledges
//
//  Created by Anson on 16/6/23.
//  Copyright © 2016年 LHW. All rights reserved.
//

// There has three methods to add do autolayout:
// 1.native API
// 2.VFL
// 3.Masonry
// But my advice is using Masonry

#import "ALayoutViewController.h"
#import "Masonry.h"

@interface ALayoutViewController ()
{
    UIImageView *centerView;
    UIImageView *leftView;
    UIImageView *rightView;
    UIImageView *topView;
    UIImageView *bottomView;
    UIImageView *blueView;
    
    UIButton *deleteBtn;
}

@end

@implementation ALayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    centerView = [[UIImageView alloc]init];
    [centerView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:centerView];
    
    leftView = [[UIImageView alloc]init];
    [leftView setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:leftView];
    
    rightView = [[UIImageView alloc]init];
    [rightView setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:rightView];
    
    topView = [[UIImageView alloc]init];
    [topView setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:topView];
    
    bottomView = [[UIImageView alloc]init];
    [bottomView setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:bottomView];
    
    blueView = [[UIImageView alloc]init];
    [blueView setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:blueView];
    
    deleteBtn = [[UIButton alloc]init];
    [deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [deleteBtn setTitle:@"Delete Yellow!!" forState:UIControlStateNormal];
    [deleteBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.view addSubview:deleteBtn];
    [deleteBtn addTarget:self action:@selector(deleteYellow) forControlEvents:UIControlEventTouchUpInside];
    
    //Add Constraint
    
    __weak typeof(self)weakself = self;
    
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakself.view);
        make.height.and.width.mas_equalTo(20);
    }];
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(centerView);
        make.centerY.equalTo(centerView);
        make.trailing.mas_equalTo(centerView.mas_leading).offset(-50);
    }];

    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(centerView);
        make.centerY.equalTo(centerView);
        make.leading.mas_equalTo(centerView.mas_trailing).offset(50);
    }];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(centerView);
        make.centerX.equalTo(centerView);
        make.bottom.equalTo(centerView.mas_top).offset(-50);
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(centerView);
        make.centerX.equalTo(centerView);
        make.top.equalTo(centerView.mas_bottom).offset(50);
    }];
    
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(centerView);
        make.centerX.equalTo(centerView);
        make.top.equalTo(centerView.mas_bottom).offset(50).priority(250);
        make.top.equalTo(bottomView.mas_bottom).offset(20);
    }];
    
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 30));
        make.centerX.equalTo(centerView);
        make.bottom.equalTo(topView.mas_top).offset(-20);
    }];
}

-(void)deleteYellow{
    [bottomView removeFromSuperview];
    [UIView animateWithDuration:1.0 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
