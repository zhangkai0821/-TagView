
//
//  ZKMostlyInfoCell.m
//  datumDemo
//
//  Created by zhangkai on 2019/1/6.
//  Copyright © 2019年 zhangkai. All rights reserved.
//

#import "ZKMostlyInfoCell.h"
#import "Masonry.h"
#import "ZKPicCollectionViewCell.h"
#define kOffset            15*kScalW
#define kScalW             kScreenW/375
#define kScalH             kScreenH/667
#define kScreenB           [UIScreen mainScreen].bounds
#define kScreenH           [UIScreen mainScreen].bounds.size.height
#define kScreenW           [UIScreen mainScreen].bounds.size.width
@interface ZKMostlyInfoCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(strong,nonatomic)UILabel *titleLabel;
@property(strong,nonatomic)UILabel *subTitleLabel;
@property(strong,nonatomic)UILabel *infoTitleLabel;
@property(strong,nonatomic)UILabel *imageTitleLabel;
@property(strong,nonatomic)UICollectionView *picCollectionView;
@property(strong,nonatomic)UICollectionViewFlowLayout *layout;
@end

@implementation ZKMostlyInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUpUi];
    }
    return self;
}
- (void)setUpUi{
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
    }];
    
    [self.contentView addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
    }];
    
    [self.contentView addSubview:self.infoTitleLabel];
    [self.infoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subTitleLabel.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.subTitleLabel.mas_bottom).offset(10);
    }];
    
    [self.contentView addSubview:self.imageTitleLabel];
    [self.imageTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoTitleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.infoTitleLabel.mas_left);
    }];
    
    //添加图片容器
    [self.contentView addSubview:self.picCollectionView];
    [self.picCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageTitleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.size.mas_equalTo([self calcPictureViewSize:4]);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;{
    return 4;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;{
    ZKPicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor yellowColor];
    return cell;
}
//计算图片控制器的宽高
- (CGSize)calcPictureViewSize:(NSInteger)count;{
    
    NSInteger cols = count>3?3:count;
    NSInteger row = (count - 1)/3 + 1;
    CGFloat cellWigth = (CGFloat)(kScreenW-46*kScalW)/3;
    CGFloat width = cols * cellWigth + (cols - 1)*8*kScalW;
    CGFloat height = row * cellWigth + (row -1) * 8*kScalW;
    self.layout.minimumLineSpacing = 8*kScalW;
    self.layout.minimumInteritemSpacing = 8*kScalW;
    CGSize size = CGSizeMake(width, height);
    self.layout.itemSize = CGSizeMake(cellWigth, cellWigth);
    return size;
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
-(UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.textColor = [UIColor blackColor];
        _subTitleLabel.font = [UIFont systemFontOfSize:14];
        _subTitleLabel.text = @"壹招";
    }
    return _subTitleLabel;
}
-(UILabel *)infoTitleLabel{
    if (!_infoTitleLabel) {
        _infoTitleLabel = [[UILabel alloc] init];
        _infoTitleLabel.textColor = [UIColor blackColor];
        _infoTitleLabel.font = [UIFont systemFontOfSize:14];
        _infoTitleLabel.numberOfLines = 0;
        _infoTitleLabel.text = @"壹招,壹招,壹招,壹招,壹招,壹招,壹招,壹招,壹招,壹招,壹招,壹招,壹招,壹招壹招,壹招壹招壹招壹招壹招壹招壹招壹招壹招壹招壹招壹招壹招";
    }
    return _infoTitleLabel;
}
-(UILabel *)imageTitleLabel{
    if (!_imageTitleLabel) {
        _imageTitleLabel = [[UILabel alloc] init];
        _imageTitleLabel.textColor = [UIColor blackColor];
        _imageTitleLabel.font = [UIFont systemFontOfSize:14];
        _imageTitleLabel.text = @"壹招";
    }
    return _imageTitleLabel;
}
-(UICollectionView *)picCollectionView{
    if (!_picCollectionView) {
        _picCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _picCollectionView.backgroundColor = [UIColor whiteColor];
        [_picCollectionView registerClass:[ZKPicCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _picCollectionView.delegate = self;
        _picCollectionView.dataSource = self;
    }
    return _picCollectionView;
}
-(UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _layout;
}
@end
