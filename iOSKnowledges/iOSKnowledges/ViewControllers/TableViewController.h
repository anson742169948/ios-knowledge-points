//
//  TableViewController.h
//  iOSKnowledges
//
//  Created by Anson on 16/6/22.
//  Copyright © 2016年 LHW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SelectCellModel.h"

@interface TableViewController : BaseViewController

@property(nonatomic,retain)SelectCellModel *model; //must be retain

@end
