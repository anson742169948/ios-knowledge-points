//
//  ViewController.h
//  iOSKnowledges
//
//  Created by Anson on 16/6/14.
//  Copyright © 2016年 LHW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *mainTable;

@end

