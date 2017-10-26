//
//  JZNewVersionView.h
//  JZNewVersionDemo
//
//  Created by wanhongios on 2017/10/25.
//  Copyright © 2017年 wanhongios. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^JZNewVersionViewEnterBtnBlock)(void);
@interface JZNewVersionView : UIView
// 进入体验的按钮点击block
-(void)newVersionViewEnterBlock:(JZNewVersionViewEnterBtnBlock)enterBlock;

- (instancetype)initWithFrame:(CGRect)frame datas:(NSArray *)datas;// 初始化方法

// 本地图片数组
@property(nonatomic,weak)NSArray * jz_localImages;
// 网络图片Url
@property(nonatomic,weak)NSArray * jz_netUrls;
// pageControl的默认颜色
@property(nonatomic,strong) UIColor * jz_pageControlNormalColor;
// pageControl的选中颜色
@property(nonatomic,strong) UIColor * jz_pageControlCurrentColor;
// 隐藏pageControl 默认显示(显示yes，隐藏no)
@property(nonatomic,assign) BOOL jz_pageControlShow;

// 进入体验按钮的显示文字
@property(nonatomic,copy) NSString * jz_enterBtnTitle;
// 进入体验按钮的背景颜色
@property(nonatomic,strong) UIColor * jz_enterBtnBackColor;
// 进入按钮的边框颜色
@property(nonatomic,strong) UIColor * jz_enterBtnBorderColor;
// 进入按钮的圆角
@property(nonatomic,assign) CGFloat jz_enterBtnCornerRadius;
// 进入按钮的文字颜色
@property(nonatomic,strong) UIColor * jz_enterBtnTitleColor;
// 进入按钮的字体大小
@property(nonatomic,assign) CGFloat jz_enterBtnTitleFont;
@end
