//
//  kpengVerticalView.h
//  MainProject
//
//  Created by 王朋 on 2017/9/11.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class kpengVerticalCell;
@interface kpengVerticalView : UITableView<UITableViewDelegate,UITableViewDataSource>

/**
 初始化方法

 @param frame frame description
 @param titleArr titleArr description
 @return return value description
 */
-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSArray*)titleArr ;


/**
点击之后 block回调
 */
@property (nonatomic,copy) void(^selectedInfoCallBack)(id callbackInfo,NSInteger row);

/**
 tableviewcell高度
 */
@property (nonatomic,assign) CGFloat tableRowH;


/**
 是否可以滑动 default is yes
 */
@property (nonatomic,assign) BOOL canScroll;

/**
 背景颜色
 */
@property (nonatomic,strong) UIColor *bgColor;

/**
 放入显示的数组
 */
@property (nonatomic,strong) NSArray *titleArr;

/**
 是否需要分割线
 */
@property (nonatomic,assign) BOOL needLine;

@end



/**
 cell 方法
 */
@interface kpengVerticalCell : UITableViewCell
@property (nonatomic,strong) UILabel *titleLab;
+ (instancetype)cellWithTableView:(UITableView*)tableView withCellHeight:(CGFloat)cellH ;
- (void)bdingTitle:(NSString*)title;

/**
 self高度
 */
@property (nonatomic,assign) CGFloat cellRowH;
@end
