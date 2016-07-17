//
//  RankCell.m
//  WordRank
//
//  Created by Tengfei on 16/7/17.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "RankCell.h"
#import "RankSort.h"

@interface RankCell ()
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation RankCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    RankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RankCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"RankCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setModel:(RankSort *)model
{
    _model = model;
    
    self.yearLabel.text = model.rank_year;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
