//
//  NumberCell.h
//  ArrayDataSourceExample
//
//  Created by Angel on 4/9/14.
//  Copyright (c) 2014 Angel Casado. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumberCell : UITableViewCell

+ (UINib *)nib;

@property (nonatomic, strong) IBOutlet UILabel *numberLabel;

@end
