//
//  MThreadViewController.m
//  iOSKnowledges
//
//  Created by Anson on 16/6/18.
//  Copyright © 2016年 LHW. All rights reserved.
//

#import "MThreadViewController.h"
#import "PthreadsViewController.h"
#import "NThreadViewController.h"
#import "GCDViewController.h"
#import "OperationViewController.h"

@interface MThreadViewController ()
{
    UITableView *listTable;
    NSArray *listTitles;
}

@end

@implementation MThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    listTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    listTable.dataSource = self;
    listTable.delegate = self;
    [self.view addSubview:listTable];
    
    listTitles = @[@"Pthreads",
                   @"NSThread",
                   @"GCD",
                   @"NSOperation",];
    
}

#pragma  mark - TableView Delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"listCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    [cell.textLabel setText:listTitles[indexPath.row]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listTitles.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSelector:@selector(unselectCell:) withObject:nil afterDelay:0.2];
    
    NSInteger row = [indexPath row];
    NSString *rowTitle = [listTitles objectAtIndex:row];
    
    if ([rowTitle isEqualToString:@"Pthreads"]) {
        PthreadsViewController *pth = [[PthreadsViewController alloc]init];
        [self.navigationController pushViewController:pth animated:YES];
        [pth.navigationController.navigationBar.topItem setTitle:@"Pthreads"];
    }else if ([rowTitle isEqualToString:@"NSThread"]){
        NThreadViewController *nth = [[NThreadViewController alloc]init];
        [self.navigationController pushViewController:nth animated:YES];
        [nth.navigationController.navigationBar.topItem setTitle:@"NSThread"];
    }else if ([rowTitle isEqualToString:@"GCD"]){
        GCDViewController *gcd = [[GCDViewController alloc]init];
        [self.navigationController pushViewController:gcd animated:YES];
        [gcd.navigationController.navigationBar.topItem setTitle:@"GCD"];
    }else if ([rowTitle isEqualToString:@"NSOperation"]){
        OperationViewController *operation = [[OperationViewController alloc]init];
        [self.navigationController pushViewController:operation animated:YES];
        [operation.navigationController.navigationBar.topItem setTitle:@"NSOperation"];
    }
}

-(void)unselectCell:(id)sender{
    [listTable deselectRowAtIndexPath:[listTable indexPathForSelectedRow] animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar.topItem setTitle:@"MultiThreading"];
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
