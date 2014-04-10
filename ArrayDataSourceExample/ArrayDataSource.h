/* 
The MIT License (MIT)

Copyright (c) 2014 Angel Casado

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

#import <Foundation/Foundation.h>

typedef void (^TableViewCellConfigureBlock)(id cell, id item);

@protocol ArrayDataSourcePaginationDelegate <NSObject>
@required
- (void)paginatorWillLoadResults;
- (void)paginatorDidLoadResults;
@end

@interface ArrayDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, weak) id <ArrayDataSourcePaginationDelegate>delegate;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) BOOL doneLoading;
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, strong) NSString *url;

- (id)initWithURL:(NSString *)url cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock;
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
- (void)addItems:(NSArray *)items;

- (void)loadNextPage;
- (void)loadResultsForPage:(NSInteger)page andURL:(NSString *)url;

- (void)prepareToLoadMoreResults;
- (void)finishedLoadingResults;

- (void)reset;
- (void)resetWithURL:(NSString *)url;

@end
