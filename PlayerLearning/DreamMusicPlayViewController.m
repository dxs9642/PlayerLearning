//
//  DreamMusicPlayViewController.m
//  PlayerLearning
//
//  Created by 孙龙霄 on 2/6/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

#import "DreamMusicPlayViewController.h"
#import "Colours.h"
@interface DreamMusicPlayViewController ()

@end

@implementation DreamMusicPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)show{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self.view];
    self.view.frame = window.bounds;
    self.view.y = window.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.y = 0;
        
        
    }];
    
}


@end
