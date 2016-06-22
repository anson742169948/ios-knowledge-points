//
//  TableViewController.m
//  iOSKnowledges
//
//  Created by Anson on 16/6/22.
//  Copyright © 2016年 LHW. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController
@synthesize model;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *mainTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:mainTable];
    
    model = [[SelectCellModel alloc]init];
    model.titles = @[@"Cell 1",
                     @"Cell 2",
                     @"Cell 3",
                     @"Cell 4",
                     @"Cell 5",
                     @"Cell 6",
                     ];
    mainTable.delegate = model;
    mainTable.dataSource = model;
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
