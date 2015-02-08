//
//  DreamLRCView.h
//  PlayerLearning
//
//  Created by 孙龙霄 on 2/8/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

#import "DRNRealTimeBlurView.h"

@interface DreamLRCView : DRNRealTimeBlurView
@property (nonatomic,copy) NSString *lrcname;
@property (nonatomic,assign) NSTimeInterval currentTime;
@end
