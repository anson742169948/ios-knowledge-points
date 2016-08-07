//
//  AudioViewController.m
//  iOSKnowledges
//
//  Created by Anson on 16/6/27.
//  Copyright © 2016年 LHW. All rights reserved.
//

#import "AudioViewController.h"
#import "AudioTableDelegate.h"

@interface AudioViewController ()

@end

@implementation AudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak typeof(self)weakself = self;
    
    UIButton *speakBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [speakBtn.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [speakBtn.layer setBorderWidth:1.0f];
    [speakBtn.layer setCornerRadius:5];
    speakBtn.clipsToBounds = YES;
    [speakBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [speakBtn setBackgroundImage:[Global createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [speakBtn setBackgroundImage:[Global createImageWithColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
    [speakBtn setTitle:@"Press to speak" forState:UIControlStateNormal];
    [speakBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [speakBtn addTarget:self action:@selector(speak:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:speakBtn];
    
    [speakBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.trailing.equalTo(weakself.view.mas_trailing).offset(-20);
        make.leading.equalTo(weakself.view.mas_leading).offset(20);
        make.bottom.equalTo(weakself.view.mas_bottom).offset(-10);
    }];
    
    UITableView *msgTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 300, 300) style:UITableViewStylePlain];
    msgTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [msgTable setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:msgTable];
    
    [msgTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.view.mas_top);
        make.bottom.equalTo(speakBtn.mas_top);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
    }];
    
    AudioTableDelegate *delegate = [[AudioTableDelegate alloc]init];
    msgTable.delegate = delegate;
    msgTable.dataSource = delegate;
    
}

- (void)speak:(id)sender
{
    
    //create database
    HWDatabaseManager *dbManager = [HWDatabaseManager shareInstance];
    [dbManager openDatabase];
    
    if ([dbManager isTableExists:@"AudioMsg"]) {
        
    }else{
        [dbManager createTable:@"AudioMsg" withArguments:@"audio_id INTEGER PRIMARY KEY AUTOINCREAMENT,path TEXT, length LONG, usr_id INTEGER, usr_photo TEXT"];
    }
    
    
    [self becomeFirstResponder];
    
    UIButton *btn = (UIButton*)sender;
    UIMenuItem *deleteBtn = [[UIMenuItem alloc]initWithTitle:@"Delete" action:@selector(deleteMethod:)];
    UIMenuItem *ear = [[UIMenuItem alloc]initWithTitle:@"Ear Listen" action:@selector(ear:)];
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuItems:[NSArray arrayWithObjects:ear,deleteBtn, nil]];
    [menu setArrowDirection:UIMenuControllerArrowDown];
    
    [menu setTargetRect:[btn frame] inView:self.view];
    [menu setMenuVisible:YES animated:YES];
    
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(ear:)||action == @selector(deleteMethod:)) {
        return YES;
    }
    return NO;
}

-(void)ear:(id)sender{
    
}

-(void)deleteMethod:(id)sender{
    
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
