//
//  DreamLRCView.m
//  PlayerLearning
//
//  Created by 孙龙霄 on 2/8/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

#import "DreamLRCView.h"
#import "DreamLRCLine.h"
#import "DreamLRCViewCell.h"

@interface DreamLRCView() <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *lrcLines;
@property (nonatomic,assign)long currentIndex;

@end

@implementation DreamLRCView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setLrcname:(NSString *)lrcname{
    
    _lrcname = [lrcname copy];
    
    [self.lrcLines removeAllObjects];
    
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:lrcname withExtension:nil];
    NSString *lrc = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSArray *lines = [lrc componentsSeparatedByString:@"\n"];
    
    for (NSString *str in lines) {
        DreamLRCLine *line = [[DreamLRCLine alloc] init];
        
        if ([str hasPrefix:@"["]) {
            
            if ([str hasPrefix:@"[ti:"] || [str hasPrefix:@"[ar:"] || [str hasPrefix:@"[al:"]) {
                
                NSString *orgWord = [[str componentsSeparatedByString:@":"] lastObject];
                line.word = [orgWord substringToIndex:orgWord.length - 1];
            }else{
                
                NSArray *orgWords = [str componentsSeparatedByString:@"]"] ;
                line.time = [[orgWords firstObject] substringFromIndex:1];
                line.word = [orgWords lastObject];
            }
        }
        
        [self.lrcLines addObject:line];
    }
    
    
    [self.tableView reloadData];
}


- (void)setCurrentTime:(NSTimeInterval)currentTime{
    
    _currentTime = currentTime;
    
    int minute = currentTime / 60;
    int second = (int)currentTime % 60;
    int msecond = (currentTime - (int)currentTime)*100;
    NSString *currentTimeStr = [NSString stringWithFormat:@"%02d:%02d.%02d",minute,second,msecond];
    [self.lrcLines enumerateObjectsUsingBlock:^(DreamLRCLine *line, NSUInteger idx, BOOL *stop) {
        
        NSString *currentLrcTime = line.time;
        if (idx<self.lrcLines.count-1) {
            idx++;
        }
        NSString *nextLrcTime = ((DreamLRCLine *)self.lrcLines[idx]).time;
        BOOL pass = ([currentTimeStr compare:currentLrcTime] == NSOrderedDescending)&&([currentTimeStr compare:nextLrcTime] == NSOrderedAscending);
        if (pass&&self.currentIndex!=idx-1) {
            
            self.currentIndex = idx - 1;
            
            NSIndexPath *previousPath = [NSIndexPath indexPathForRow:self.currentIndex-1 inSection:0];

            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
            NSIndexPath *nextPath = [NSIndexPath indexPathForRow:self.currentIndex+1 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:@[previousPath,indexPath,nextPath] withRowAnimation:UITableViewRowAnimationNone];

            
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:true];
            *stop = YES;
        }
        
        
    }];
    
    
}


- (NSMutableArray *)lrcLines{
    
    if (!_lrcLines) {
        _lrcLines = [NSMutableArray array];
    }
    
    return _lrcLines;
    
}


- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self setup];
        
    }
    return self;
}



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self){
        
        [self setup];
    }
    
    return self;
    
}

- (void)setup{
 
    UITableView *tableView = [[UITableView alloc] init];
    self.tableView = tableView;
    [self addSubview:tableView];
    
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
    
    self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.height / 2, 0, self.tableView.height / 2, 0);
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.lrcLines.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DreamLRCViewCell *cell =  [DreamLRCViewCell cellWithTableView:tableView];
    
    cell.line = self.lrcLines[indexPath.row];
    
    if (self.currentIndex == indexPath.row) {
        cell.textLabel.font = [UIFont systemFontOfSize:20];
    }else{
         cell.textLabel.font = [UIFont systemFontOfSize:13];
    }
    
    return cell;
    
}



@end
