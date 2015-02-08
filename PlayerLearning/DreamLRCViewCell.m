//
//  DreamLRCViewCell.m
//  PlayerLearning
//
//  Created by 孙龙霄 on 2/8/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

#import "DreamLRCViewCell.h"
#import "DreamLRCLine.h"

@implementation DreamLRCViewCell

- (void)setLine:(DreamLRCLine *)line{
    
    _line = line;
    self.textLabel.text = line.word;
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"lyric";
    
    DreamLRCViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell){
        cell = [[DreamLRCViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.textLabel.textColor = [UIColor whiteColor];
        
        self.backgroundColor = [UIColor clearColor];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
    }

    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.textLabel.frame = self.bounds;
    
    
    
}


@end
