//
//  JZNewVersionCell.m
//  JZNewVersionDemo
//
//  Created by wanhongios on 2017/10/25.
//  Copyright © 2017年 wanhongios. All rights reserved.
//

#import "JZNewVersionCell.h"
@interface JZNewVersionCell()
@property(nonatomic,weak)UIImageView * jz_imageView;
@end
@implementation JZNewVersionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView{
    UIImageView * jz_imageView = [[UIImageView alloc]init];
    jz_imageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:jz_imageView];
    self.jz_imageView = jz_imageView;
}

-(void)setJz_imageName:(NSString *)jz_imageName{
    if (jz_imageName.length>0) {
        self.jz_imageView.image = [UIImage imageNamed:jz_imageName];
    }else{
        self.jz_imageView.image = nil;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat jz_imageViewX = 0;
    CGFloat jz_imageViewY = 0;
    CGFloat jz_imageViewW = self.bounds.size.width;
    CGFloat jz_imageViewH = self.bounds.size.height;
    self.jz_imageView.frame = CGRectMake(jz_imageViewX, jz_imageViewY, jz_imageViewW, jz_imageViewH);
}
@end
