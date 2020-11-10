//
//  SSJTableView.m
//  OCWithJSDemo
//
//  Created by SSJ on 2020/11/4.
//  Copyright © 2020 SSJ. All rights reserved.
//

#import "SSJTableView.h"
#import "SSJTableViewCell.h"
#import "MJRefresh.h"
@interface SSJTableView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) NSArray *datas;
@property (nonatomic , strong) NSString*cellName;
///无数据的时候显示
@property (nonatomic , strong) UIView *noDataShow;
///记录noDataShow坐标
@property (nonatomic , assign) CGRect noDataShowFrame;
@end
@implementation SSJTableView


/// 初始化
/// @param frame            SSJTableView的坐标
/// @param dataList         数据源
/// @param cellName         cell的Xib名字，不带后缀
/// @param isNeedAnimate    SSJTableViewAnimateType类型（需要刷新或者加载更多动作）
/// @param noDataShow       没有数据的时候展示，不需要处理就传nil（需要设置frame属性）
- (instancetype)initWithFrame:(CGRect)frame dataList:(NSArray *)dataList cellName:(NSString *)cellName isNeedAnimate:(SSJTableViewAnimateType)isNeedAnimate noDataShow:(UIView *)noDataShow{
    self = [super initWithFrame:frame];
    if (self && dataList && dataList.count > 0 && cellName && cellName.length > 0) {
        ///添加暂无数据的view
        if(noDataShow){
            self.noDataShow = noDataShow;
            self.noDataShowFrame = noDataShow.frame;
            self.tableHeaderView = self.noDataShow;
        }
        self.datas = dataList;
        self.cellName = cellName;
        self.dataSource = self;
        self.delegate = self;
        ///注册cell
        NSString *identifierStr = [cellName stringByAppendingString:@"IDENTIFIER"];
        [self registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellReuseIdentifier:identifierStr];
        
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        [self setTableFooterView:view];
        ///去掉所有cell下划线
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        ///添加下拉刷新、上拉加载
        if (isNeedAnimate == SSJTableViewAnimateTypeOfOnlyHeader) {
            [self shuaXinAdd];
        }else if (isNeedAnimate == SSJTableViewAnimateTypeOfOnlyFooter) {
            [self jiaZaiGengDuoAdd];
        }else if (isNeedAnimate == SSJTableViewAnimateTypeOfHeaderAndFooter) {
            [self shuaXinAdd];
            [self jiaZaiGengDuoAdd];
        }
    }
    return self;
}

///添加刷新动作
- (void)shuaXinAdd{
    __weak typeof(self) weakSelf = self;
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (weakSelf.shuaXinBlcok) {
            weakSelf.shuaXinBlcok(weakSelf.mj_header);
        }
    }];
    [self.mj_header beginRefreshing];
}

///添加加载更多动作
- (void)jiaZaiGengDuoAdd{
    __weak typeof(self) weakSelf = self;
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (weakSelf.jaiZaiGengDuoBlcok) {
            weakSelf.jaiZaiGengDuoBlcok(weakSelf.mj_footer);
        }
    }];
}

/// 结束刷新动画
- (void)endHeaderAnimate{
    if (self.mj_header) {
        [self.mj_header endRefreshing];
    }
}

/// 结束加载更多动画
- (void)endFooterAnimate{
    if (self.mj_footer) {
        [self.mj_footer endRefreshing];
    }
}


#pragma mark ---- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.noDataShow){
        ///判断要不要展示noDataShow
        if (self.datas && self.datas.count == 0) {
            self.noDataShow.hidden = NO;
            self.noDataShow.frame = self.noDataShowFrame;
        }else{
            self.noDataShow.hidden = YES;
            self.noDataShow.frame = CGRectZero;
        }
    }
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ///读取cell
    id cellModel;
    SSJTableViewCell *cell;
    if (indexPath.row < self.datas.count) {
        cellModel = self.datas[indexPath.row];
        NSString *identifierStr = [self.cellName stringByAppendingString:@"IDENTIFIER"];
        cell = (SSJTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifierStr];
        ///刷新cell数据， 根据cellModel
        [cell refreshUIWithModel:cellModel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        cell = [SSJTableViewCell new];
    }
    return cell;
}

#pragma mark ---- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float cellHeight = 0;
    if(self.heightForRowAtIndexPathBlcok){
        cellHeight = self.heightForRowAtIndexPathBlcok(indexPath);
    }
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(self.didSelectRowAtIndexPathBlcok){
        self.didSelectRowAtIndexPathBlcok(indexPath);
    }
}

/** 正常状态下点击 */
- (void)didSelectRowWithNormal:(NSIndexPath *)indexPath{
    [self performSelector:@selector(unSelectCell) withObject:nil afterDelay:0.5];
    NSLog(@"点击了； %@",self.datas[indexPath.row]);
}
- (void)unSelectCell{
    [self deselectRowAtIndexPath:[self indexPathForSelectedRow] animated:YES];
}

#pragma mark -------- 刷新数据 ---------
/// 刷新数据
/// @param datas 数据源
- (void)updateWIthArray:(NSArray *)datas{
    self.datas = datas;
    [self reloadData];
}
@end
