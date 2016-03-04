//
//  YSWImageClickView.m
//  Collection
//
//  Created by ymq on 16/3/2.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "YSWImageClickView.h"

@interface YSWImageClickView ()

@property (strong, nonatomic) id obj;

@end

@implementation YSWImageClickView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)clickAction
{
    if (self.click)
    {
        self.click(self.obj);
    }
}

-(void)setImageWithUrl:(NSURL *)imgUrl placeholderImage:(UIImage *)placeholderImage WithData:(id)obj tapBlock:(ImageClivk)tapAction
{
    self.obj = obj;
//    [self sd_setImageWithURL:imgUrl placeholderImage:placeholderImage];
    self.click = tapAction;
}

@end
