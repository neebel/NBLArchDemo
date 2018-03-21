//
//  NBLHomeViewController.m
//  NBLArchDemo
//
//  Created by neebel on 2018/3/11.
//  Copyright © 2018年 neebel. All rights reserved.
//

#import "NBLHomeViewController.h"
#import "NBLNewsManager.h"
#import "NBLNewsCell.h"
#import <MJRefresh/MJRefresh.h>
#import "NBLTheme.h"
#import "NBLNewsWebViewController.h"

@interface NBLHomeViewController ()<NBLManagerProtocol, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NBLNewsManager *newsManager;
@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSArray        *newsList;
@property (nonatomic, strong) MJRefreshAutoNormalFooter *refreshFooter;
@property (nonatomic, assign) NSInteger currentPage;

@end

static NSString *newsCellIdentifier = @"newsCellIdentifier";

@implementation NBLHomeViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
    [self refreshData];
}

#pragma mark - Private

- (void)initUI
{
    [self.view addSubview:self.tableView];
    self.tableView.mj_footer = self.refreshFooter;
}


- (void)refreshData
{
    self.currentPage = 1;
    [self.newsManager loadRequest];
}


- (void)loadMoreData
{
    self.currentPage++;
    [self.newsManager loadRequest];
}


- (void)checkHasMore:(NBLNewsInfo *)info
{
    if (info.newsList.count == 10) {
        [self.tableView.mj_footer endRefreshing];
    } else {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

#pragma mark - Getter

- (NBLNewsManager *)newsManager
{
    if (!_newsManager) {
        _newsManager = [[NBLNewsManager alloc] init];
        _newsManager.caller = self;
    }
    
    return _newsManager;
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        [_tableView registerClass:[NBLNewsCell class] forCellReuseIdentifier:newsCellIdentifier];
    }
    
    return _tableView;
}


- (MJRefreshAutoNormalFooter *)refreshFooter
{
    if (!_refreshFooter) {
        __weak typeof(self) weakSelf = self;
        _refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf loadMoreData];
        }];
        [_refreshFooter setTitle:NSLocalizedString(@"点击或上拉加载更多", nil) forState:MJRefreshStateIdle];
        [_refreshFooter setTitle:NSLocalizedString(@"正在玩命加载...", nil) forState:MJRefreshStateRefreshing];
        [_refreshFooter setTitle:NSLocalizedString(@"没有更多了", nil) forState:MJRefreshStateNoMoreData];
        _refreshFooter.stateLabel.font = [UIFont systemFontOfSize:15];
        _refreshFooter.stateLabel.textColor = UIColorFromHexRGB(0x999999);
        [_refreshFooter setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    }
    
    return _refreshFooter;
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsList.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NBLNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:newsCellIdentifier forIndexPath:indexPath];
    [cell updateCellWithInfo:self.newsList[indexPath.row]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NBLSingleNewsInfo *newsInfo = self.newsList[indexPath.row];
    NBLNewsWebViewController *webVC = [[NBLNewsWebViewController alloc] initWithURLString:newsInfo.newsUrl];
    webVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - NBLManagerProtocol

- (NSDictionary *)externalRequestParameters
{
    return @{@"key":@"07724c1bbe7c9ce84b8bc6d8d8786a46",
             @"page":@(self.currentPage),
             @"num":@"10"};
}


- (void)receiveResponse:(NBLBaseInfo *)info error:(NSError *)error fromCache:(BOOL)fromCache
{
    if (error) {
        return;
    }
    
    if ([info isKindOfClass:[NBLNewsInfo class]]) {
        NBLNewsInfo *newsInfo = (NBLNewsInfo *)info;
        NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:self.newsList];
        [tmpArr addObjectsFromArray:newsInfo.newsList];
        self.newsList = tmpArr;
        [self.tableView reloadData];
        [self checkHasMore:newsInfo];
    }
}

@end
