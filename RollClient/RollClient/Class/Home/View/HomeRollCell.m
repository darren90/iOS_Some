//
//  HomeRollCell.m
//  RollClient
//
//  Created by Fengtf on 16/3/30.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "HomeRollCell.h"
#import "RollModel.h"
#import "ItemImags.h"

@interface HomeRollCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imag1X;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imag2X;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imag3X;

@end

@implementation HomeRollCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    HomeRollCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeRollCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"HomeRollCell" owner:nil options:nil].firstObject;
    }
    return cell;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}


-(void)updateConstraints
{
    [self autoArrangeBoxWithConstransits:@[self.imag1X,self.imag2X,self.imag3X] width:self.buttonW.constant];
    [super updateConstraints];
}

-(void)autoArrangeBoxWithConstransits:(NSArray *)constraninArray width:(CGFloat)width{
    NSInteger step = (self.contentView.frame.size.width - (width * constraninArray.count))/(constraninArray.count+1);
    for (int i = 0 ; i< constraninArray.count ; i++) {
        NSLayoutConstraint *constraint = constraninArray[i];
        constraint.constant = step * (i + 1) + width * i;
    }
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
