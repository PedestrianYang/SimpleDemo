//
//  YSWImageClickView.h
//  Collection
//
//  Created by ymq on 16/3/2.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ImageClivk)(id obj);

@interface YSWImageClickView : UIImageView

@property (copy, nonatomic) ImageClivk click;

-(void)setImageWithUrl:(NSURL *)imgUrl placeholderImage:(UIImage *)placeholderImage WithData:(id)obj tapBlock:(ImageClivk)tapAction;

@end
