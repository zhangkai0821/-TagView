//
//  ZKBaseDatumCell.m
//  datumDemo
//
//  Created by zhangkai on 2019/1/6.
//  Copyright © 2019年 zhangkai. All rights reserved.
//

#import "ZKBaseDatumCell.h"
#import "Masonry.h"
#define kOffset            15*kScalW
#define kScalW             kScreenW/375
#define kScalH             kScreenH/667
#define kScreenB           [UIScreen mainScreen].bounds
#define kScreenH           [UIScreen mainScreen].bounds.size.height
#define kScreenW           [UIScreen mainScreen].bounds.size.width
#define TagSpace           15
@interface ZKBaseDatumCell()
@property(strong,nonatomic)UILabel *titleLabel;
@property(strong,nonatomic)NSMutableArray *labelArr;
@end
@implementation ZKBaseDatumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//这里相当于赋值model
- (void)updataViewWithCount:(NSInteger)count;{
    
    //先不管数组有没有东西 都清除
    for (int i = 0; i<self.labelArr.count; i++) {
        UILabel *tempLabel = (UILabel *)self.labelArr[i];
        [tempLabel removeFromSuperview];
    }
    //在清除数组
    [self.labelArr removeAllObjects];

    //比如说有5个点
    //先计算是否超过屏幕的宽度, 距离左边的距离是80 右边的是40
    //有效的距离
    CGFloat realFloat = kScreenW - 80 - 40;
    /**
     1.每个标签的距离可以为15
     2.计算每个标签的宽度
     */
    //定义一个数组
    NSArray *titleArr = @[@"资质保障",@"服务保障",@"服务打",@"服务保障",@"服务保障",@"保障",@"服务保障二环",@"服务保障",@"服务保障",@"服务保障",@"服务保障"];
    NSMutableArray *indexArr = @[].mutableCopy;
    do {
        if (indexArr.count == 0) {
            NSInteger breakindex = [self rowIndex:titleArr begin:0 realFloat:realFloat];
            [indexArr addObject:@(breakindex)];
        }else{
            NSInteger breakindex = [self rowIndex:titleArr begin:[indexArr.lastObject integerValue]  realFloat:realFloat];
            [indexArr addObject:@(breakindex)];
        }
    } while ([indexArr.lastObject intValue] != 0); //条件不成立的时候 就跳出循环
    
    
    int z = 0;
    do {
        //如果为0 说明不用换行了
        NSInteger row = [indexArr[z] integerValue];
        
        NSInteger maxRow = row;
        if (z != 0) {
            maxRow = row == 0?(titleArr.count - [indexArr[z-1] integerValue]):(row-[indexArr[z-1] integerValue]);
        }else{
            if (row == 0) {
                maxRow = titleArr.count;
            }
        }
        for (int i = 0; i<maxRow; i++) {
            UILabel *tempLabel = [[UILabel alloc] init];
            tempLabel.textColor = [UIColor blackColor];
            tempLabel.font = [UIFont systemFontOfSize:12];
            if (z != 0) {
                tempLabel.text = titleArr[i+[indexArr[z-1] integerValue]];
            }else{
                tempLabel.text = titleArr[i];
            }
            CGSize tempSize = [self widthForLabel:tempLabel.text fontSize:12];
            CGFloat tempWidth = tempSize.width>(kScreenW - 80 - 40)?(kScreenW - 80 - 40):tempSize.width;
            [self.contentView addSubview:tempLabel];
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
                    make.left.equalTo(self.contentView.mas_left).offset(80);//i*15是间距
                }else{
                    make.left.equalTo(lastLabel.mas_right).offset(15);
                }
                if (z == 0) {
                  make.centerY.equalTo(self.titleLabel.mas_centerY);
                }else{
                  make.top.equalTo(overLabel.mas_bottom).offset(8);
                }
                
                if (i == 0 && z == indexArr.count-1) {
                    make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);//最后可以微调
                }
                    make.width.mas_equalTo(tempWidth+3);

                
            }];
            //将label加入到数组
            [self.labelArr addObject:tempLabel];
            
        }
        z++;
        
    } while (z != indexArr.count);
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.labelArr = @[].mutableCopy;
        [self setUpUi];
    }
    return self;
}
- (void)setUpUi{
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.left.equalTo(self.contentView.mas_left).offset(10);
    }];
    
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.text = @"壹招";
    }
    return _titleLabel;
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
        CGFloat tempWidth = tempSize.width>(kScreenW - 80 - 40)?(kScreenW - 80 - 40):tempSize.width;
        maxFloat = maxFloat + tempWidth +i *TagSpace;
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
