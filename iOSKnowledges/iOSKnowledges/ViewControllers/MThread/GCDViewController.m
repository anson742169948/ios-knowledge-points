//
//  GCDViewController.m
//  iOSKnowledges
//
//  Created by Anson on 16/6/18.
//  Copyright © 2016年 LHW. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()
{
    UIButton *queueBtn;
    UIButton *startBtn;
    UIButton *closeBtn;
    UIButton *resumeBtn;
    UITextView *tipView;
    
    dispatch_queue_t mainQueue;
    dispatch_queue_t testQueue;
}
@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Main Thread Queue
    mainQueue = dispatch_get_main_queue();
    
    //Create Concurrent Thread Queue
    //DISPATCH_QUEUE_CONCURRENT : concurrent queue
    //nil & DISPATCH_QUEUE_SERIAL : serial queue
    testQueue = dispatch_queue_create("concurrent_testqueue", DISPATCH_QUEUE_SERIAL);
    
    //Global Concurrent Queue
//    testQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
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

-(void)groupThread{
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, testQueue, ^{
        dispatch_async(mainQueue, ^{
            [tipView setText:@"group running ····"];
        });
        for (NSInteger i = 0; i < 1300; i++) {
            NSLog(@"group-01 - %@", [NSThread currentThread]);
        }
    });
    dispatch_group_async(group, testQueue, ^{
        for (NSInteger i = 0; i < 1300; i++) {
            NSLog(@"group-02 - %@", [NSThread currentThread]);
            
        }
    });
    dispatch_group_async(group, testQueue, ^{
        for (NSInteger i = 0; i < 1300; i++) {
            NSLog(@"group-03 - %@", [NSThread currentThread]);
            
        }
    });
    dispatch_group_notify(group, testQueue, ^{
        dispatch_async(mainQueue, ^{
            [tipView setText:@"Group done!"];
        });
    });
}

-(void)startThread{

    dispatch_async(testQueue, ^{
        NSLog(@"New Thread:%@",[NSThread currentThread]);
        NSLog(@"Thread Queue:%@",testQueue);
        __block NSString *newTH = [[NSThread currentThread] description];
        dispatch_async(mainQueue, ^{
            
            //add Lock
            @synchronized (self) {
                startBtn.enabled = NO;
                [startBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                
                [tipView setText:[NSString stringWithFormat:@"New Thread:%@\nPlease Close it!",newTH]];
            }
        });
    });
}

-(void)closeThread{
    if (testQueue) {
        dispatch_suspend(testQueue);
        [tipView setText:@"The thread was suspend!Now resume it!"];
        
    }
}

-(void)resumeThread{
    dispatch_resume(testQueue);
    [tipView setText:@"Now you can create another thread!"];
    
    startBtn.enabled = YES;
    [startBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
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
