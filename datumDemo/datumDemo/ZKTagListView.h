//
//  ZKTagListView.h
//  datumDemo
//
//  Created by zhangkai on 2019/1/9.
//  Copyright © 2019年 zhangkai. All rights reserved.
//

#import <UIKit/UIKit.h>
//还在优化
@interface ZKTagListView : UIView
@property(assign,nonatomic)CGFloat leftToScreenSpace;//左边距离屏幕的距离
@property(assign,nonatomic)CGFloat rightToScreenSpace;//右边边距离屏幕的距离
@property(assign,nonatomic)CGFloat tagToTagSpaceW;//
@property(assign,nonatomic)CGFloat tagToTagSpaceH;//
- (void)configTagWithTagStrings:(NSArray *)tagStrings;
@end
