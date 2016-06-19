//
//  PthreadsViewController.m
//  iOSKnowledges
//
//  Created by Anson on 16/6/18.
//  Copyright © 2016年 LHW. All rights reserved.
//

#import "PthreadsViewController.h"
#import <pthread.h>
#import "PthModel.h"

@interface PthreadsViewController ()
{
    
    UIButton *startBtn;
    UIButton *closeBtn;
    pthread_t thread;
}

@end

pthread_t mainThread;
PthModel *model;
UITextView *tipView;
NSString *newTh;

@implementation PthreadsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    model = [[PthModel alloc]init];
    [model setValue:@NO forKey:@"isGetNewTH"];
//    [self setValue:isGetNewTH forKey:@"isGetNewTH"];
    [model addObserver:self forKeyPath:@"isGetNewTH" options:NSKeyValueObservingOptionNew context:nil];
    
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
    mainThread = pthread_self();
    [tipView setText:[NSString stringWithFormat:@"Main Thread:%@",[[NSThread mainThread] description]]];
    

}

-(void)startThread
{
    //Create a thread
    [self performSelector:@selector(changeIsGetNewTH) withObject:nil afterDelay:3.0];
    [tipView setText:@"Doing..."];
    pthread_create(&thread, NULL, threadStart, NULL);
    
    startBtn.enabled = NO;
    [startBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

-(void)closeThread
{
    
    int t = pthread_kill(thread, SIGQUIT);
    if (t == ESRCH){
        NSLog(@"Thread was killed!");
        [tipView setText:@"The thread was quited!"];
        startBtn.enabled = YES;
        [startBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }else if (t == EINVAL){
        NSLog(@"signal is invalid!");
    }else {
        NSLog(@"Thread is still alive!");
    }
    
    
}

-(void)changeIsGetNewTH{
    if (newTh) {
        [model setValue:@YES forKey:@"isGetNewTH"];
    }
    
}

void *threadStart(void *data){
    NSLog(@"New Thread :%@",[NSThread currentThread]);
    newTh = [[NSThread currentThread] description];
//    [model setValue:@YES forKey:@"isGetNewTH"];
    return NULL;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"isGetNewTH值改变！");
    [tipView setText:[NSString stringWithFormat:@"New Thread:%@\nPlease Close it!",newTh]];
}

-(void)dealloc
{
    [model removeObserver:self forKeyPath:@"isGetNewTH"];
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
