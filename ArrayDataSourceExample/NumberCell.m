//
//  NumberCell.m
//  ArrayDataSourceExample
//
//  Created by Angel on 4/9/14.
//  Copyright (c) 2014 Angel Casado. All rights reserved.
//

#import "NumberCell.h"

@implementation NumberCell

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"NumberCell" bundle:nil];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
