//
//  DreamMusicListViewControllerTableViewController.m
//  PlayerLearning
//
//  Created by 孙龙霄 on 2/6/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

#import "DreamMusicListViewController.h"
#import "DreamMusic.h"
#import "DreamMusicListCell.h"
#import "DreamPlayerController.h"
#import "DreamMusicTool.h"

@interface DreamMusicListViewController ()
@property (nonatomic,strong) DreamPlayerController *player;
@end


@implementation DreamMusicListViewController

- (DreamPlayerController *)player{
    if (!_player){
        _player = [[DreamPlayerController alloc] init];
    }
    return _player;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Dream Music Player";

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return [DreamMusicTool musics].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    DreamMusicListCell *cell = [DreamMusicListCell cellWithTableView:tableView];
    NSArray *musics = [DreamMusicTool musics];
    cell.music = musics[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    [DreamMusicTool setPlayingMusic:[DreamMusicTool musics][indexPath.row]];
    
    [self.player show];
    
    
}
@end

