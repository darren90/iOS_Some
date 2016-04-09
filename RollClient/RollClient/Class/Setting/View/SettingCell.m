//
//  SettingCell.m
//  MovieBinge
//
//  Created by Fengtf on 16/1/5.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import "SettingCell.h"
#import "SettingItem.h"
#import "SettingSwitchItem.h"

@interface SettingCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *indicaView;


/**
 *  默认是隐藏的，要显示，需要把indicaView.hidden = YES;
 */
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLeading;

@end

@implementation SettingCell

- (void)awakeFromNib {
    // Initialization code
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * const Identifier = @"setting";
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
//        cell= (UITwitterTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"UISpecialTableViewCell" owner:self options:nil]  lastObject];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SettingCell" owner:nil options:nil] lastObject];
    }
    return cell;
}



-(void)setItem:(SettingItem *)item
{
    _item = item;
    
    self.iconView.image = [UIImage imageNamed:item.icon];
    self.titleLabel.text = item.title;
    if (item.subtitle) {
        self.indicaView.hidden = YES;
        self.subTitleLabel.hidden = NO;
        self.subTitleLabel.text = item.subtitle;
    }else{
        self.indicaView.hidden = NO;
        self.subTitleLabel.hidden = YES;
    }
    
    if (!item.icon) {
        self.iconView.hidden = YES;
        self.titleLeading.constant = -25;
//        CGRect rect = self.titleLabel.frame;
//        rect.origin.x = 15;
//        self.titleLabel.frame = rect;
    }

    if ([item.title rangeOfString:KMsgNotice].location != NSNotFound && item.title.length > KMsgNotice.length) {
        NSString *markStr = item.title;
        NSMutableAttributedString *markAttrStr = [[NSMutableAttributedString alloc]initWithString:markStr];
        [markAttrStr addAttribute:NSFontAttributeName value:SYSTEMFONT(16) range:NSMakeRange(0, KMsgNotice.length)];
        [markAttrStr addAttribute:NSFontAttributeName value:SYSTEMFONT(13) range:NSMakeRange(KMsgNotice.length, markStr.length - KMsgNotice.length)];
        [markAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(KMsgNotice.length, markStr.length - KMsgNotice.length)];
        [markAttrStr addAttribute:NSForegroundColorAttributeName value:KCommonColor range:NSMakeRange(KMsgNotice.length+2, markStr.length - KMsgNotice.length - 3)];//有个空格，所以+1
        self.titleLabel.attributedText = markAttrStr;
    }
}

- (void)drawRect:(CGRect)rect   //画出tableviewcell下方的分割线
{
    CGFloat lineHeight = 0.4;
    CGFloat cellHetht = self.frame.size.height;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, 0, cellHetht - lineHeight);
    CGContextAddLineToPoint(ctx, KWidth, cellHetht - lineHeight);
    CGContextSetRGBStrokeColor(ctx, 0.88, 0.88, 0.88, 1.0);
    CGContextStrokePath(ctx);
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end



