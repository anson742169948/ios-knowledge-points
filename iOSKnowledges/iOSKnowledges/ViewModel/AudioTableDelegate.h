//
//  AudioTableDelegate.h
//  iOSKnowledges
//
//  Created by Anson on 16/6/27.
//  Copyright © 2016年 LHW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AudioTableDelegate : NSObject<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain)NSArray *msgData;

@end
