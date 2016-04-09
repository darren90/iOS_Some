//
//  SettingSwitchCell2.m
//  RollClient
//
//  Created by Tengfei on 16/4/7.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "SettingSwitchCell2.h"
#import "SettingSwitchItem.h"


@interface SettingSwitchCell2 ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *switchView;

@end

@implementation SettingSwitchCell2

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * const Identifier = @"SettingSwitchCell2";
    SettingSwitchCell2 *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SettingSwitchCell2" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setItem:(SettingSwitchItem *)item
{
    _item = item;
    
    self.iconView.image = [UIImage imageNamed:item.icon];
    self.titleLabel.text = item.title;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isON = [defaults boolForKey:KAutoPlayView];
    
    self.switchView.on = isON;
}


- (IBAction)switchClick:(UISwitch *)switchView {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:switchView.on forKey:KAutoPlayView];
    [defaults synchronize];
}

@end


