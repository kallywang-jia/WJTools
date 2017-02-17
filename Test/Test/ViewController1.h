//
//  ViewController1.h
//  Test
//
//  Created by tempus-MAC on 2017/2/14.
//  Copyright © 2017年 tempus_kally. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ResultCallBackBlock) (int result);

@interface ViewController1 : UIViewController

@property(nonatomic,copy)ResultCallBackBlock callBackBlock;

@end
