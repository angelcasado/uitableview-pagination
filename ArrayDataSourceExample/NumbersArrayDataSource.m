//
//  NumbersArrayDataSource.m
//  ArrayDataSourceExample
//
//  Created by Angel on 4/9/14.
//  Copyright (c) 2014 Angel Casado. All rights reserved.
//

#import "NumbersArrayDataSource.h"
#import "Number.h"

@interface NumbersArrayDataSource ()

@property (nonatomic, assign) NSInteger numberCount;

@end

@implementation NumbersArrayDataSource

- (void)loadResultsForPage:(NSInteger)page andURL:(NSString *)url
{
    // This method is an overwrided method from ArrayDataSource
    // You could also use the page and url params for network calls
    if (!self.doneLoading) {
        if (!self.isLoading) {
            self.isLoading = YES;
            [self prepareToLoadMoreResults]; // call the delegate method
            dispatch_queue_t queue = dispatch_queue_create("com.number.create", NULL);
            dispatch_async(queue, ^{
                NSMutableArray *newNumbers = [NSMutableArray array];
                for (NSInteger i = self.numberCount + 1; i <= self.numberCount + 10; i++) {
                    [newNumbers addObject:[[Number alloc] initWithNumber:i]];
                }
                self.numberCount += 10;
                [self addItems:newNumbers];
                [NSThread sleepForTimeInterval:2.0];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.isLoading = NO;
                    self.pageCount++;
                    [self finishedLoadingResults]; // call the delegate method
                });
            });
        }
    }
}

@end
