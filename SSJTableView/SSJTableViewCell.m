//
//  SSJTableViewCell.m
//  OCWithJSDemo
//
//  Created by SSJ on 2020/11/4.
//  Copyright © 2020 SSJ. All rights reserved.
//

#import "SSJTableViewCell.h"

@implementation SSJTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/// 刷新cell
- (void)refreshUIWithModel:(id)model{
//    self.backgroundColor = [UIColor clearColor];
////    if (model.) {
////        self.headImageView.image
////    }
//    self.nameLabel.text = model.name;
//    self.messageLabel.text = model.message;
//
//    ///获取文字的宽度
//    float widthF = [self getStringWidthWithText:self.messageLabel.text font:[UIFont systemFontOfSize:15.0] viewHeight:model.messageHeight];
//    float screenW = [UIScreen mainScreen].bounds.size.width;
//    ///如果messageLabel内容比较短，让它靠右显示，修改它的leading
//    if(widthF < screenW - (8+40+8+8+8) - 46){
//        __weak typeof(self) weakSelf = self;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            weakSelf.messageLabelTrailingLayout.constant = screenW - (8+40+8+8+8) - widthF;
//        });
//    }
}
@end
