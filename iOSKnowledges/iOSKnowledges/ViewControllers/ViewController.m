//
//  ViewController.m
//  iOSKnowledges
//
//  Created by Anson on 16/6/14.
//  Copyright © 2016年 LHW. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSArray *titles;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    titles = @[@"CoreData",
                        @"GCD"];
    
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
    [cell.textLabel setText:titles[indexPath.row]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titles.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
