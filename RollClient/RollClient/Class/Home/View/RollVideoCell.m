//
//  RollVideoCell.m
//  RollClient
//
//  Created by Tengfei on 16/4/5.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "RollVideoCell.h"
#import "RollModel.h"
#import "ItemImags.h"

@interface RollVideoCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconViewW;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@end


@implementation RollVideoCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    RollVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RollVideo"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"RollVideoCell" owner:nil options:nil].firstObject;
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    if (isApplePad) {
        self.iconViewW.constant = 120;
    }
}



-(void)setModel:(RollModel *)model{
    _model = model;
    
    NSArray *readArray = [[NSUserDefaults standardUserDefaults] objectForKey:KHadReades];
    BOOL result = [readArray containsObject:model.itemId];
    if (result) {
        self.titleLabel.textColor = [UIColor lightGrayColor];
    }else{
        self.titleLabel.textColor = [UIColor blackColor];
    }
    
    self.titleLabel.text = model.itemTitle;
    if (model.itemImageList.count == 0) return;
    ItemImags *im = model.itemImageList[0];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:im.itemImageUrl] placeholderImage:KPlaceHolderImg];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
