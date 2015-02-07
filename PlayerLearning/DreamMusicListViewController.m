//
//  DreamMusicListViewControllerTableViewController.m
//  PlayerLearning
//
//  Created by 孙龙霄 on 2/6/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

#import "DreamMusicListViewController.h"
#import "MJExtension.h"
#import "DreamMusic.h"
#import "DreamMusicListCell.h"
#import "DreamMusicPlayViewController.h"

@interface DreamMusicListViewController ()
@property (nonatomic,strong) NSArray *musics;
@property (nonatomic,strong) DreamMusicPlayViewController *player;
@end


@implementation DreamMusicListViewController

- (DreamMusicPlayViewController *)player{
    if (!_player){
        _player = [[DreamMusicPlayViewController alloc] init];
    }
    return _player;
}

- (NSArray *)musics{
    if (!_musics){
        _musics =  [DreamMusic objectArrayWithFilename:@"Musics.plist"];
    }
    
    return _musics;
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


    return self.musics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    DreamMusicListCell *cell = [DreamMusicListCell cellWithTableView:tableView];
    cell.music = self.musics[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [self.player show];
}
@end

