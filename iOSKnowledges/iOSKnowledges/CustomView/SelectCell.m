//
//  SelectCell.m
//  iOSKnowledges
//
//  Created by Anson on 16/6/22.
//  Copyright © 2016年 LHW. All rights reserved.
//

#import "SelectCell.h"

@implementation SelectCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _selectView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"select"]];
        [_selectView setFrame:CGRectMake(10, 10, 25, 25)];
        [self.contentView addSubview:_selectView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    [_selectView setHidden:!selected];
}

@end
