//
//  SSJTableView.h
//  OCWithJSDemo
//
//  Created by SSJ on 2020/11/4.
//  Copyright © 2020 菲比寻常. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJRefreshHeader;
@class MJRefreshFooter;
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger,SSJTableViewAnimateType) {
    ///不需要添加任何动作
    SSJTableViewAnimateTypeOfNil = 0,
    ///下拉刷新
    SSJTableViewAnimateTypeOfOnlyHeader = 1,
    ///上拉加载
    SSJTableViewAnimateTypeOfOnlyFooter = 2,
    ///下拉刷新和上拉加载
    SSJTableViewAnimateTypeOfHeaderAndFooter = 3,
};

@interface SSJTableView : UITableView

/// 初始化
/// @param frame            SSJTableView的坐标
/// @param dataList         数据源
/// @param cellName         cell的Xib名字，不带后缀
/// @param isNeedAnimate    SSJTableViewAnimateType类型（需要刷新或者加载更多动作）
/// @param noDataShow       没有数据的时候展示，不需要处理就传nil（需要设置frame属性）
- (instancetype)initWithFrame:(CGRect)frame dataList:(NSArray *)dataList cellName:(NSString *)cellName isNeedAnimate:(SSJTableViewAnimateType)isNeedAnimate noDataShow:(UIView *)noDataShow;

///返回高度的block
typedef float (^HeightForRowAtIndexPathBlcok)(NSIndexPath *indexPath);
@property (nonatomic , copy) HeightForRowAtIndexPathBlcok heightForRowAtIndexPathBlcok;

///cell点击的block
typedef void (^DidSelectRowAtIndexPathBlcok)(NSIndexPath *indexPath);
@property (nonatomic , copy) DidSelectRowAtIndexPathBlcok didSelectRowAtIndexPathBlcok;

///下拉刷新
typedef void (^ShuaXinBlcok)(MJRefreshHeader *refreshHeader);
@property (nonatomic , copy) ShuaXinBlcok shuaXinBlcok;

///上拉加载
typedef void (^JaiZaiGengDuoBlcok)(MJRefreshFooter *refreshFooter);
@property (nonatomic , copy) JaiZaiGengDuoBlcok jaiZaiGengDuoBlcok;

/// 结束刷新动画
- (void)endHeaderAnimate;

/// 结束加载更多动画
- (void)endFooterAnimate;

/// 刷新数据
/// @param datas 数据源
- (void)updateWIthArray:(NSArray *)datas;
@end


/**     How to use ?
 
 - (SSJNoDataView *)noDataShow{
     /// 无数据直接加载xib
     SSJNoDataView *_noDataShow = [[[NSBundle mainBundle] loadNibNamed:@"SSJNoDataView" owner:self options:nil] lastObject];
         _noDataShow.icon.image = [UIImage imageNamed:@"quanZi_noData"];
         _noDataShow.titleLabel.text = @"圈子暂无更新";
     return _noDataShow;
 }

 - (void)viewDidAppear:(BOOL)animated{
     float w = [UIScreen mainScreen].bounds.size.width;
     float h = [UIScreen mainScreen].bounds.size.height;
     CGRect fr = CGRectMake(0, 20, w, h - 20);
     NSArray *das = @[@"张三",@"李四",@"王武",@"赵六"];
     __weak typeof(self) weakSelf = self;
     self.sSJTableView = [[SSJTableView alloc] initWithFrame:fr dataList:das cellName:@"Test02VCCell" isNeedAnimate:SSJTableViewAnimateTypeOfHeaderAndFooter noDataShow:[self noDataShow]];
     ///返回cell高度
     self.sSJTableView.heightForRowAtIndexPathBlcok = ^float(NSIndexPath * _Nonnull indexPath) {
         return 50;
     };
     ///点击cell会调用
     self.sSJTableView.didSelectRowAtIndexPathBlcok = ^void(NSIndexPath * _Nonnull indexPath) {
         NSLog(@"点击第%ld个",(long)indexPath.row);
     };
     ///下拉刷新
     self.sSJTableView.shuaXinBlcok = ^(MJRefreshHeader * _Nonnull refreshHeader) {
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             NSArray *das = @[@"张三",@"李四",@"王武",@"赵六"];
             [weakSelf.sSJTableView updateWIthArray:das];
             [weakSelf.sSJTableView endHeaderAnimate];
         });
     };
     ///上拉加载
     self.sSJTableView.jaiZaiGengDuoBlcok = ^(MJRefreshFooter * _Nonnull refreshFooter) {
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             NSArray *das = @[];
             [weakSelf.sSJTableView updateWIthArray:das];
             [weakSelf.sSJTableView endFooterAnimate];
         });
     };
     [self.view addSubview:self.sSJTableView];
 }
 
 注意 》》〉
    1、Test02VCCell是自定义的cell，Test02VCCell继承自SSJTableViewCell且》〉必须实现方法：
     ///必须要实现，否则会提示找不到方法而崩溃
     - (void)refreshUIWithModel:(id)model{
         //这里的model就是cell的Model,需要根据实际情况进行强转使用
     }
    2、heightForRowAtIndexPathBlcok是告诉SSJTableView每个cell的高度，》〉必须要实现
    3、SSJTableView只针对单一的cell，如果一个tableView有多种不同的cell，请自行实现
    4、MJRefresh (3.4.3)， 其它版本的请自行测试
 */


NS_ASSUME_NONNULL_END
