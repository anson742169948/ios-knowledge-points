//
//  NThreadViewController.m
//  iOSKnowledges
//
//  Created by Anson on 16/6/18.
//  Copyright © 2016年 LHW. All rights reserved.
//

#import "NThreadViewController.h"

@interface NThreadViewController ()
{
    UIButton *startBtn;
    UIButton *closeBtn;
    UITextView *tipView;
    NSThread *thread;
}
@end

@implementation NThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    tipView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 120)];
    [tipView setTag:11];
    [tipView setTextAlignment:NSTextAlignmentCenter];
    [tipView setTextColor:[UIColor blackColor]];
    [tipView setFont:[UIFont systemFontOfSize:13]];
    [tipView setCenter:CGPointMake(self.view.center.x, self.view.center.y-140)];
    [tipView setScrollsToTop:YES];
    [tipView setScrollEnabled:NO];
    [tipView setEditable:NO];
    [tipView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:tipView];
    
    startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [startBtn setFrame:CGRectMake(0, 0, 120, 40)];
    [startBtn setTitle:@"New Thread" forState:UIControlStateNormal];
    [startBtn setCenter:CGPointMake(self.view.center.x, self.view.center.y-40)];
    [startBtn addTarget:self action:@selector(startThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [closeBtn setFrame:CGRectMake(0, 0, 120, 40)];
    [closeBtn setTitle:@"Close Thread" forState:UIControlStateNormal];
    [closeBtn setCenter:CGPointMake(self.view.center.x, self.view.center.y+40)];
    [closeBtn addTarget:self action:@selector(closeThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    
    
    NSLog(@"Main Thread:%@",[NSThread mainThread]);
    [tipView setText:[NSString stringWithFormat:@"Main Thread:%@",[[NSThread mainThread] description]]];
}

-(void)startThread{
    thread = [[NSThread alloc]initWithTarget:self selector:@selector(newThread:) object:@"This is new thread!"];
    [thread start];
}

-(void)newThread:(id)object{
    NSLog(@"LOG:%@",object);
    
    [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:YES];
    
}

-(void)updateUI{
    startBtn.enabled = NO;
    [startBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    [tipView setText:[NSString stringWithFormat:@"New Thread:%@\nPlease Close it!",thread]];
}

-(void)closeThread{
    if (thread) {
        [thread cancel];
        thread = nil;
        [tipView setText:@"The thread was quited!"];
        startBtn.enabled = YES;
        [startBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }
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
