# SSJTableView
自定义一个tableView,只需要实现一个初始化方法和几个block即可展示一个带刷新、加载更多的列表
```
 - (UIView *)noDataShow{
     UIView *noDataShow = [UIView new];
     float w = [UIScreen mainScreen].bounds.size.width;
     float h = [UIScreen mainScreen].bounds.size.height;
     CGRect fr = CGRectMake(0, 0, w, h);
     noDataShow.frame = fr;
     
     CGRect titleFrame = CGRectMake(0, (h - 30) * 0.5, w, 30);
     UILabel *titleLabel = [[UILabel alloc]initWithFrame:titleFrame];
     titleLabel.textAlignment = NSTextAlignmentCenter;
     titleLabel.text = @"圈子暂无更新";
     
     [noDataShow addSubview:titleLabel];
     return noDataShow;
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
  ```
 
 注意 》》〉
 
    1、Test02VCCell是自定义的xib类型的cell，Test02VCCell继承自SSJTableViewCell且 》〉必须实现方法,否则会提示找不到方法而崩溃 :
     
```
     - (void)refreshUIWithModel:(id)model{
         //这里的model就是cell的Model,需要根据实际情况进行强转使用
     }
```
    
    2、heightForRowAtIndexPathBlcok是告诉SSJTableView每个cell的高度，》〉必须要实现  
    
    3、SSJTableView只针对单一的cell，如果一个tableView有多种不同的cell，请自行实现  
    
    4、MJRefresh (3.4.3)， 其它版本的请自行测试  
