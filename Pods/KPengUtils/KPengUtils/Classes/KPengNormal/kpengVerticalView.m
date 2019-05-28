//
//  kpengVerticalView.m
//  MainProject
//
//  Created by 王朋 on 2017/9/11.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "kpengVerticalView.h"
#define LABRLH  18
#define TEMPWIDTH 10
#define CELLH 44
#define km_rgb_hex(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface kpengVerticalView()

@property (nonatomic,strong) NSIndexPath *firstindexPath;
@property (nonatomic,strong) UIView *showLine;

@end
@implementation kpengVerticalView

-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSArray*)titleArr {
    
    self =[super initWithFrame:frame];
    
    if (self) {
        _titleArr =titleArr;
        self.tableFooterView =[UIView new];
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self setupUI];
        [self reloadData];
        
    }
    return self;
}

- (void)setupUI{
    
    _firstindexPath =0;
    self.delegate =self;
    self.dataSource =self;
    _showLine =[[UIView alloc] initWithFrame:CGRectMake(0, ((_tableRowH<=0?CELLH:_tableRowH)-LABRLH)/2, 1,LABRLH)];
    _showLine.backgroundColor =[UIColor redColor];
    [self addSubview:_showLine];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return _tableRowH<=0?CELLH:_tableRowH;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _titleArr.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    kpengVerticalCell *cell =[kpengVerticalCell cellWithTableView:tableView withCellHeight:_tableRowH<=0?CELLH:_tableRowH];
    [cell bdingTitle:[_titleArr objectAtIndex:indexPath.row]];
    if (_firstindexPath == indexPath) {
        cell.titleLab.textColor =km_rgb_hex(0x333333);
 
    }else {
          cell.titleLab.textColor =km_rgb_hex(0x999999);
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    //之前选中的，取消选择
    kpengVerticalCell *celled = [tableView cellForRowAtIndexPath:_firstindexPath];
     celled.titleLab.textColor =km_rgb_hex(0x999999);
    //记录当前选中的位置索引
    _firstindexPath = indexPath;
    //当前选择的打勾
    kpengVerticalCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.titleLab.textColor =km_rgb_hex(0x333333);
    
    _showLine.frame =CGRectMake(0, (_tableRowH<=0?CELLH:_tableRowH)*indexPath.row+((_tableRowH<=0?44:_tableRowH)-LABRLH)/2, 1, LABRLH);
    
    
    if (_selectedInfoCallBack) {
        _selectedInfoCallBack([_titleArr objectAtIndex:indexPath.row],indexPath.row);
    }


}


-(void)setTableRowH:(CGFloat)tableRowH {

    _tableRowH =tableRowH;
    _showLine.frame =CGRectMake(0, ((_tableRowH<=0?CELLH:_tableRowH)-LABRLH)/2, 1,LABRLH);
    [self reloadData];

}


- (void)setCanScroll:(BOOL)canScroll {

    if (canScroll) {
        self.scrollEnabled =YES;
    } else {
        self.scrollEnabled =NO;
    }

}


-(void)setBgColor:(UIColor *)bgColor {

    _showLine.backgroundColor =bgColor;
}


-(void)setTitleArr:(NSArray *)titleArr {

    _titleArr =titleArr;
    [self reloadData];
    
}


- (void)setNeedLine:(BOOL)needLine {
    
    if (needLine) {
      [self setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    }

}



@end


@interface kpengVerticalCell()

@end

@implementation kpengVerticalCell


+(NSString*)kind {
    
    return @"kpengVerticalCell";
    
}

+ (instancetype)cellWithTableView:(UITableView*)tableView withCellHeight:(CGFloat)cellH {
    
    kpengVerticalCell *cell = [tableView dequeueReusableCellWithIdentifier:[kpengVerticalCell kind]];
  
    if (!cell) {
        cell = [[kpengVerticalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[kpengVerticalCell kind] withCellHeight:cellH];
        
    }
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier  withCellHeight:(CGFloat)cellH {
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor =[UIColor whiteColor];
    self.selectionStyle =UITableViewCellSelectionStyleNone;
    _cellRowH =cellH;
    [self setupUI];
    return self;
}


- (void)setupUI {
    
    _titleLab =[[UILabel alloc] initWithFrame:CGRectMake(TEMPWIDTH, (_cellRowH-LABRLH)/2, self.bounds.size.width-TEMPWIDTH, LABRLH)];
     _titleLab.font =[UIFont systemFontOfSize:14];
    [self addSubview:_titleLab];
    
}

- (void)bdingTitle:(NSString*)title {
    
    _titleLab.text =title;

}



@end
