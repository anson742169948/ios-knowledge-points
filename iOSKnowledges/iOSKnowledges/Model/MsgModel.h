//
//  MsgModel.h
//  iOSKnowledges
//
//  Created by Anson on 16/6/25.
//  Copyright © 2016年 LHW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

typedef enum {
    recording = 0,
    recorded,
    recordfailed,
}msgType;

@interface MsgModel : BaseModel

@property(nonatomic,copy)NSString *path;
@property(nonatomic,copy)NSString *photoPath;
@property(nonatomic,assign)long tLength;
@property(nonatomic,assign)msgType type;

@end
