//
//  Number.m
//  ArrayDataSourceExample
//
//  Created by Angel on 4/9/14.
//  Copyright (c) 2014 Angel Casado. All rights reserved.
//

#import "Number.h"

@implementation Number

- (id)initWithNumber:(NSInteger)number
{
    self = [super init];
    if (self) {
        self.title = number;
    }
    return self;
}

@end
