//
//  ViewController.h
//  iOSKnowledges
//
//  Created by Anson on 16/6/14.
//  Copyright © 2016年 LHW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mainTable;

@end

