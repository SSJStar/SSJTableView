//
//  Test02VCCell.m
//  OCWithJSDemo
//
//  Created by 苏墨 on 2020/11/4.
//  Copyright © 2020 菲比寻常. All rights reserved.
//

#import "Test02VCCell.h"
@interface  Test02VCCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end
@implementation Test02VCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

///必须要实现
- (void)refreshUIWithModel:(id)model{
    self.nameLabel.text = model;
}
@end
