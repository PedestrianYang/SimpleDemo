//
//  FoldSectionTableView.h
//  YSWScanViewController
//
//  Created by ymq on 16/3/18.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface FoldSectionTableView : UITableView


@property (nonatomic, strong) NSDictionary *cellDataDic;
@property (nonatomic, strong) NSArray *titleArray;

@end
