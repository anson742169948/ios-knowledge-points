//
//  OperationViewController.m
//  iOSKnowledges
//
//  Created by Anson on 16/6/18.
//  Copyright © 2016年 LHW. All rights reserved.
//

#import "OperationViewController.h"

@interface OperationViewController ()
{
    UIButton *queueBtn;
    UIButton *startBtn;
    UIButton *closeBtn;
    UIButton *resumeBtn;
    UITextView *tipView;
    
    NSOperationQueue *mainQueue;
    NSOperationQueue *testQueue;
}

@end

@implementation OperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    mainQueue = [NSOperationQueue mainQueue];
    testQueue = [[NSOperationQueue alloc]init];
    
    tipView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 120)];
    [tipView setTag:11];
    [tipView setTextAlignment:NSTextAlignmentCenter];
    [tipView setTextColor:[UIColor blackColor]];
    [tipView setFont:[UIFont systemFontOfSize:13]];[tipView setScrollsToTop:YES];
    [tipView setScrollEnabled:NO];
    [tipView setEditable:NO];
    [tipView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:tipView];
    
    queueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [queueBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [queueBtn setFrame:CGRectMake(0, 0, 150, 40)];
    [queueBtn setTitle:@"Thread Group" forState:UIControlStateNormal];
    [queueBtn setCenter:CGPointMake(self.view.center.x, self.view.center.y-120)];
    [queueBtn addTarget:self action:@selector(groupThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:queueBtn];
    
    startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [startBtn setFrame:CGRectMake(0, 0, 120, 40)];
    [startBtn setTitle:@"New Thread" forState:UIControlStateNormal];
    [startBtn setCenter:CGPointMake(self.view.center.x, self.view.center.y-40)];
    [startBtn addTarget:self action:@selector(startThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [closeBtn setFrame:CGRectMake(0, 0, 150, 40)];
    [closeBtn setTitle:@"Suspend Thread" forState:UIControlStateNormal];
    [closeBtn setCenter:CGPointMake(self.view.center.x, self.view.center.y+40)];
    [closeBtn addTarget:self action:@selector(closeThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    
    resumeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [resumeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [resumeBtn setFrame:CGRectMake(0, 0, 150, 40)];
    [resumeBtn setTitle:@"Resume Thread" forState:UIControlStateNormal];
    [resumeBtn setCenter:CGPointMake(self.view.center.x, self.view.center.y+120)];
    [resumeBtn addTarget:self action:@selector(resumeThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resumeBtn];
    
    
    NSLog(@"Main Thread:%@",[NSThread mainThread]);
    [tipView setText:[NSString stringWithFormat:@"Main Thread:%@",[[NSThread mainThread] description]]];
}

- (void)groupThread
{
    //block 1
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1.0];
        NSString *newTH = [[NSThread currentThread] description];
        NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
            [tipView setText:[NSString stringWithFormat:@"Block 1:%@",newTH]];
        }];
        [mainQueue addOperation:blockOperation];
    }];
    
    //block 2
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1.0];
        NSString *newTH = [[NSThread currentThread] description];
        NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
            [tipView setText:[NSString stringWithFormat:@"Block 2:%@",newTH]];
        }];
        [mainQueue addOperation:blockOperation];
    }];
    
    //block 3
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1.0];
        NSString *newTH = [[NSThread currentThread] description];
        NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
            [tipView setText:[NSString stringWithFormat:@"Block 3:%@",newTH]];
        }];
        [mainQueue addOperation:blockOperation];
    }];
    
    //dependency
    [operation2 addDependency:operation1];
    [operation3 addDependency:operation2];
    
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperations:@[operation3, operation2, operation1] waitUntilFinished:NO];
}

- (void)closeThread
{
    [closeBtn setEnabled:NO];
    [resumeBtn setEnabled:YES];
    [startBtn setEnabled:NO];
    [testQueue setSuspended:YES];
    
    [resumeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    [tipView setText:@"The queue was suspended,now you can resume it!"];
}

- (void)resumeThread
{
    [resumeBtn setEnabled:NO];
    [closeBtn setEnabled:YES];
    [startBtn setEnabled:YES];
    [testQueue setSuspended:NO];
    
    [resumeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    [tipView setText:@"Now you can create another thread!"];
}

- (void)startThread
{
    [startBtn setEnabled:NO];
    [startBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(run) object:nil];
//    [operation start];
    
//    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"New Thread:%@",[NSThread currentThread]);
//    }];
//    [operation start];
    
    [testQueue addOperation:operation];
}

-(void)run
{
    NSString *newTH = [[NSThread currentThread] description];
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        [tipView setText:[NSString stringWithFormat:@"New Thread:%@",newTH]];
    }];
    [mainQueue addOperation:blockOperation];
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
