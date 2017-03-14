//
//  MovieListCell.m
//  FileMaster
///Users/tengfei/github/iOS_Demo/FileMaster/FileMaster/Base.lproj/Main.storyboard
//  Created by Tengfei on 16/2/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "MovieListCell.h"
#import "MovieList.h"
#import "MovieFile.h"

@interface MovieListCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconGo;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *naleLTrail;

@end

@implementation MovieListCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    MovieListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movielistCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MovieListCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
    self.iconView.clipsToBounds = YES;
}
 
-(void)setModel:(MovieFile *)model
{
    if (model.isFolder) {
        self.iconView.image = [UIImage imageNamed:@"Finder_folder"];
         self.nameLabel.text = model.folderName;
        self.iconGo.hidden = NO;
        self.sizeLabel.hidden = YES;
    }else{
        MovieList *list = model.file;
//        self.iconView.image = [UIImage imageNamed:@"movie_icon"];
        self.iconView.image = list.imgData;
         self.sizeLabel.hidden = NO;
        self.nameLabel.text = list.name;
        self.iconGo.hidden = YES;
        self.sizeLabel.text = list.fileSize;
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
