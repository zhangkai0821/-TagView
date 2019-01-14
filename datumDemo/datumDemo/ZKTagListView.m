//
//  ZKTagListView.m
//  datumDemo
//
//  Created by zhangkai on 2019/1/9.
//  Copyright © 2019年 zhangkai. All rights reserved.
//

#import "ZKTagListView.h"
#import "Masonry.h"
#define kScreenB           [UIScreen mainScreen].bounds
#define kScreenH           [UIScreen mainScreen].bounds.size.height
#define kScreenW           [UIScreen mainScreen].bounds.size.width
#define TagSpace           15

@interface ZKTagListView()
@property(strong,nonatomic)NSMutableArray *labelArr;
@end

@implementation ZKTagListView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init{
    if (self = [super init]) {
        _leftToScreenSpace = 80;
        _rightToScreenSpace = 40;
        _tagToTagSpaceH = 10;
        _tagToTagSpaceW = 10;
        self.labelArr = @[].mutableCopy;
    }
    return self;
}
- (void)configTagWithTagStrings:(NSArray *)tagStrings;{
    
    //比如说有5个点
    //先计算是否超过屏幕的宽度, 距离左边的距离是80 右边的是40
    //有效的距离
    CGFloat realFloat = kScreenW - _leftToScreenSpace - _rightToScreenSpace;
    
    //记录标签换行的元素下标
    NSMutableArray *indexArr = @[].mutableCopy;
    do {
        if (indexArr.count == 0) {
            NSInteger breakindex = [self rowIndex:tagStrings begin:0 realFloat:realFloat];
            [indexArr addObject:@(breakindex)];
        }else{
            NSInteger breakindex = [self rowIndex:tagStrings begin:[indexArr.lastObject integerValue]  realFloat:realFloat];
            [indexArr addObject:@(breakindex)];
        }
    } while ([indexArr.lastObject intValue] != 0);
    
    
    int z = 0;
    do {
        //如果为0 说明不用换行了
        NSInteger row = [indexArr[z] integerValue];
        
        NSInteger maxRow = row;
        if (z != 0) {
            maxRow = row == 0?(tagStrings.count - [indexArr[z-1] integerValue]):(row-[indexArr[z-1] integerValue]);
        }else{
            if (row == 0) {
                maxRow = tagStrings.count;
            }
        }
        for (int i = 0; i<maxRow; i++) {
            UILabel *tempLabel = [[UILabel alloc] init];
            tempLabel.textColor = [UIColor blackColor];
            tempLabel.font = [UIFont systemFontOfSize:12];
            if (z != 0) {
                tempLabel.text = tagStrings[i+[indexArr[z-1] integerValue]];
            }else{
                tempLabel.text = tagStrings[i];
            }
            [self addSubview:tempLabel];
            //取出第一个label做参考
            UILabel *lastLabel;
            if (i == 0 && z != 0) {
                lastLabel = self.labelArr[0];
            }else{
                lastLabel = self.labelArr.lastObject;
            }
            
            UILabel *overLabel;
            if (z != 0) {
                NSInteger overIndex = [indexArr[z-1] integerValue] - 1;
                overLabel = self.labelArr[overIndex];
            }
            [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                if (i == 0) {
                    make.left.equalTo(self.mas_left).offset(self.leftToScreenSpace);//i*15是间距
                }else{
                    make.left.equalTo(lastLabel.mas_right).offset(15);
                }
                if (z == 0) {
                    make.top.equalTo(self.mas_top);
                }else{
                    make.top.equalTo(overLabel.mas_bottom).offset(8);
                }
                
                if (i == 0 && z == indexArr.count-1) {
                    make.bottom.equalTo(self.mas_bottom).offset(-15);//最后可以微调
                }
            }];
            //将label加入到数组
            [self.labelArr addObject:tempLabel];
            
        }
        z++;
        
    } while (z != indexArr.count);
    
    
    
    
}




//计算宽度
- (CGSize)widthForLabel:(NSString *)text fontSize:(CGFloat)font
{
    
    CGSize size = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil]];
    
    return size;
}

- (NSInteger)rowIndex:(NSArray *)titleArr begin:(NSInteger)begin realFloat:(CGFloat)realFloat{
    NSInteger breakindex = 0;
    NSInteger i = 0;
    CGFloat maxFloat= 0;
    for (NSInteger j = begin; j<titleArr.count; j++) {
        CGSize tempSize = [self widthForLabel:titleArr[j] fontSize:12];
        CGFloat tempWidth = tempSize.width>(kScreenW - _leftToScreenSpace - _rightToScreenSpace)?(kScreenW - _leftToScreenSpace - _rightToScreenSpace):tempSize.width;//当标签过长的时候 限制宽度
        maxFloat = maxFloat + tempWidth +i *_tagToTagSpaceW;
        if (maxFloat>realFloat) {
            //如果大于了 就终止循环
            breakindex = j;
            break;
        }
        i++;
    }
    return breakindex;
}

@end
