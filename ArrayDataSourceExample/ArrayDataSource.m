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

#import "ArrayDataSource.h"

@interface ArrayDataSource ()

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;

@end

@implementation ArrayDataSource

- (id)init
{
    return nil;
}

- (id)initWithURL:(NSString *)url cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock;
{
    self = [super init];
    if (self) {
        self.items = [NSMutableArray array];
        self.cellIdentifier = cellIdentifier;
        self.configureCellBlock = [configureCellBlock copy];
        self.pageCount = 1;
        self.isLoading = NO;
        self.doneLoading = NO;
        self.url = url;
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.items objectAtIndex:indexPath.row];
}

- (void)addItems:(NSArray *)items
{
    [self.items addObjectsFromArray:items];
}

- (void)reset
{
    self.isLoading = NO;
    self.doneLoading = NO;
    self.pageCount = 1;
    self.url = nil;
    self.items = nil;
}

- (void)resetWithURL:(NSString *)url
{
    [self reset];
    self.url = url;
    self.items = [NSMutableArray array];
    [self loadNextPage];
}

#pragma mark Pagination

- (void)loadNextPage
{
    if (self.isLoading) {
        return;
    }
    
    if (!self.doneLoading) {
        [self loadResultsForPage:self.pageCount andURL:self.url];
    }
}

- (void)loadResultsForPage:(NSInteger)page andURL:(NSString *)url
{
    /*
        Abstract method
        Subclass this class and override this method with your
        own fetch procedure and use the methods in this class
        to add the items, increment page count, trigger loading
        indication in your controller, etc.
    */
}

- (void)prepareToLoadMoreResults
{
    if ([self.delegate respondsToSelector:@selector(paginatorWillLoadResults)]) {
        [self.delegate paginatorWillLoadResults];
    }
}

- (void)finishedLoadingResults
{
    if ([self.delegate respondsToSelector:@selector(paginatorDidLoadResults)]) {
        [self.delegate paginatorDidLoadResults];
    }
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    return cell;
}

@end
