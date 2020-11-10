//
//  SSJTableViewCell.h
//  OCWithJSDemo
//
//  Created by SSJ on 2020/11/4.
//  Copyright © 2020 SSJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSJTableViewCell : UITableViewCell
///必须要实现
- (void)refreshUIWithModel:(id)model;
@end

NS_ASSUME_NONNULL_END
