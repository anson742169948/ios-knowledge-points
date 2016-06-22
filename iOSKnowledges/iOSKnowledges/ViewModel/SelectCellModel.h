//
//  SelectCellModel.h
//  iOSKnowledges
//
//  Created by Anson on 16/6/22.
//  Copyright © 2016年 LHW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SelectCellModel : NSObject<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)NSArray *titles;

@end
