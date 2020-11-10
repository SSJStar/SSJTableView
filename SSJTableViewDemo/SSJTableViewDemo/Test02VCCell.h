//
//  Test02VCCell.h
//  OCWithJSDemo
//
//  Created by 苏墨 on 2020/11/4.
//  Copyright © 2020 菲比寻常. All rights reserved.
//

#import "SSJTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface Test02VCCell : SSJTableViewCell
///必须要实现
- (void)refreshUIWithModel:(id)model;
@end

NS_ASSUME_NONNULL_END
