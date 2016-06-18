//
//  ViewController.m
//  iOSKnowledges
//
//  Created by Anson on 16/6/14.
//  Copyright © 2016年 LHW. All rights reserved.
//

#import "ViewController.h"
#import "MThreadViewController.h"

@interface ViewController ()
{
    NSArray *titles;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    titles = @[@"TableView",
               @"AutoLayout",
               @"Audio",
               @"Vedio",
               @"Core Image",
               @"Core Text",
               @"View Animation",
               @"Class Contact Class",
               @"Timer",
               @"HTTP Method",
               @"Socket",
               @"MultiThreading",
               @"CoreData",
               ];
    _mainTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_mainTable];
    
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    
}

#pragma  mark - TableView Delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"mainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    [cell.textLabel setText:titles[indexPath.row]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titles.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    NSString *rowTitle = [titles objectAtIndex:row];
    
    if ([rowTitle isEqualToString:@"MultiThreading"]) {
        MThreadViewController *mth = [[MThreadViewController alloc]init];
        [self.navigationController pushViewController:mth animated:YES];
        [mth.navigationController.navigationBar.topItem setTitle:@"MultiThreading"];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar.topItem setTitle:@"iOS Knowledges"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
