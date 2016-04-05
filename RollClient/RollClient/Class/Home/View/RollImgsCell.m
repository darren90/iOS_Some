//
//  RollImgsCell.m
//  RollClient
//
//  Created by Tengfei on 16/4/5.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "RollImgsCell.h"
#import "RollModel.h"
#import "ItemImags.h"

@interface RollImgsCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@end

@implementation RollImgsCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    RollImgsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RollImgs"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"RollImgsCell" owner:nil options:nil].firstObject;
    }
    return cell;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

  
-(void)setModel:(RollModel *)model{
    _model = model;
    
    
    self.titleLabel.text = model.itemTitle;
    
    NSArray *arry = model.itemImageList;
    if (arry && arry.count) {
        if (arry.count == 1) {
            ItemImags *im = model.itemImageList[0];
            [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:im.itemImageUrl] placeholderImage:nil];
        }else if (arry.count == 2){
            ItemImags *im0 = model.itemImageList[0]; ItemImags *im1 = model.itemImageList[1];
            [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:im0.itemImageUrl] placeholderImage:nil];
            [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:im1.itemImageUrl] placeholderImage:nil];
        }else if (arry.count == 3){
            ItemImags *im0 = model.itemImageList[0]; ItemImags *im1 = model.itemImageList[1]; ItemImags *im2 = model.itemImageList[2];
            [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:im0.itemImageUrl] placeholderImage:nil];
            [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:im1.itemImageUrl] placeholderImage:nil];
            [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:im2.itemImageUrl] placeholderImage:nil];
        }
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
