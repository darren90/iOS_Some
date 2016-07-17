//
//  RankDetailCell.m
//  WordRank
//
//  Created by Tengfei on 16/7/17.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "RankDetailCell.h"
#import "Rank_Word.h"

@interface RankDetailCell ()
//rank_year , rank , last_rank , co_name,co_detailurl , income , profit , nation
@property (weak, nonatomic) IBOutlet UILabel *rankL;

@property (weak, nonatomic) IBOutlet UILabel *last_rankL;
@property (weak, nonatomic) IBOutlet UILabel *co_nameL;
 
@property (weak, nonatomic) IBOutlet UILabel *incomeL;
@property (weak, nonatomic) IBOutlet UILabel *profitL;
@property (weak, nonatomic) IBOutlet UILabel *rnationL;

@end


@implementation RankDetailCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    RankDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RankDetailCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"RankDetailCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.co_nameL.textAlignment = NSTextAlignmentLeft;
//    self.co_nameL.adjustsFontSizeToFitWidth = YES;
}


-(void)setModel:(Rank_Word *)model
{
    _model = model;
    
    self.rankL.text = model.rank;
    self.last_rankL.text = model.last_rank;
    self.co_nameL.text = model.co_name;
    self.incomeL.text = model.income;
    self.profitL.text = model.profit;
    self.rnationL.text = model.nation;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end






