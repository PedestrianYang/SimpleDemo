//
//  People.h
//  RunTimeTest
//
//  Created by ymq on 16/3/8.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Description.h"
@interface People : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger age;
@property (assign, nonatomic) BOOL man;

@end
