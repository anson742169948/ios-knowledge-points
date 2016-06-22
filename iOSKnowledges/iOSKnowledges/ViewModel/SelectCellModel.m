//
//  SelectCellModel.m
//  iOSKnowledges
//
//  Created by Anson on 16/6/22.
//  Copyright © 2016年 LHW. All rights reserved.
//

#import "SelectCellModel.h"
#import "SelectCell.h"

@implementation SelectCellModel

#pragma  mark - TableView Delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"selectCell";
    SelectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[SelectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    [cell.textLabel setText:_titles[indexPath.row]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titles.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
