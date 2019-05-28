//
//  kpengHorizontalView.m
//  SegmentDemo
//
//  Created by 王朋 on 2018/3/4.
//  Copyright © 2018年 王朋. All rights reserved.
//

#import "kpengHorizontalView.h"
@interface kpengHorizontalView ()
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIButton *btn;
@property (nonatomic,strong) NSArray *localListArr;
@property (nonatomic,strong) NSMutableArray <UIButton*>*localBtnListArr;

@end
@implementation kpengHorizontalView

-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSArray*)titleArr {
    
    self =[super initWithFrame:frame];
    
    if (self) {
        
        self.showsVerticalScrollIndicator =NO;
        self.showsHorizontalScrollIndicator =NO;
        _localListArr =titleArr;
        _localBtnListArr =[NSMutableArray array];
        self.delegate =self;
        [self setupUIWithFrame:frame];
    }
    
    return self;
}

- (CGFloat)calculateRowWidth:(NSString *)string {
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};  //指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, 30)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.width;
}


#pragma ---- mark 初始化UI 元素   这个计算中的UI绘制按钮是像个15pt 然后就是绘制中横线的悬停以及一些遍历的累加和位置的判断 我们可以写一个left 或者right 来进行延展  多余的代码也是可以封装的 原谅放荡不羁的我
- (void)setupUIWithFrame:(CGRect)frame{
    __block  CGFloat TW =0;
    if (_localListArr.count<=6 ) {
        self.contentSize =CGSizeMake(frame.size.width, frame.size.height);
        
    } else   {
        
        //        CGFloat W = frame.size.width+frame.size.width/6*(_localListArr.count-6);
        //        self.contentSize =CGSizeMake(W, frame.size.height);
        
#pragma --mark  重新计算多文字排列省略号的问题   这个地方要计算
        
        [_localListArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TW =TW+[self calculateRowWidth:obj];
        }];
        
        if ((TW +15*_localListArr.count)<self.frame.size.width) {
            self.contentSize =CGSizeMake(self.frame.size.width, frame.size.height);
            
        } else {
            
            self.contentSize =CGSizeMake(TW+15*_localListArr.count, frame.size.height);
        }
        
    }
    CGFloat BF =0;
    
    for (int index =0; index <_localListArr.count; index++) {
        _btn =[UIButton new];
        [_btn setTitle:[NSString stringWithFormat:@"%@",_localListArr[index]] forState:UIControlStateNormal];
        _btn.titleLabel.textAlignment =NSTextAlignmentCenter;
        _btn.titleLabel.font =_nomalFont?_nomalFont:[UIFont systemFontOfSize:14];
        
        BF =BF +[self calculateRowWidth:_localListArr[index]];
        if ((TW +15*_localListArr.count)<self.frame.size.width) {
#pragma --mark 这个是等宽的 需要计算一个是根据文字宽度来适配的  上面这个算法是的
            _btn.frame =CGRectMake(frame.size.width/_localListArr.count*index, 0, frame.size.width/_localListArr.count, frame.size.height-1);
        } else {
            _btn.frame =CGRectMake(BF-[self calculateRowWidth:_localListArr[index]]+index*15, 0, [self calculateRowWidth:_localListArr[index]], frame.size.height-1);
            
        }
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_localBtnListArr addObject:_btn];
        
        _btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _btn.contentEdgeInsets = UIEdgeInsetsMake(0,0, 0, 0);
        [self addSubview:_btn];
        _btn.tag =index;
        [_btn addTarget:self action:@selector(btnHitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    _line =[UIView new];
    [self addSubview:_line];
    _line.backgroundColor =_selectedColor?_selectedColor:[UIColor redColor];
    if ((TW +15*_localListArr.count)<self.frame.size.width) {
        _line.frame =CGRectMake(0, frame.size.height-1, self.frame.size.width/_localListArr.count, 1);
        
    } else {
        _line.frame =CGRectMake(0, frame.size.height-1, [self calculateRowWidth:_localListArr[0]], 1);
        
    }
}
#pragma ---- mark 点击事件的回调
- (void)btnHitAction:(UIButton*)sender {
    [_localBtnListArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        obj.titleLabel.font =_nomalFont?_nomalFont:[UIFont systemFontOfSize:14];
    }];
    [sender setTitleColor:_selectedColor?_selectedColor:[UIColor redColor] forState:UIControlStateNormal];
    sender.titleLabel.font =_selectedFont?_selectedFont:[UIFont boldSystemFontOfSize:15];
    [UIView animateWithDuration:0.25 animations:^{
        _line.frame =CGRectMake(CGRectGetMaxX(sender.frame)-sender.frame.size.width, self.frame.size.height-1, sender.frame.size.width, 1);
        
    }];
    if (_itemClickCallBack) {
        _itemClickCallBack(sender.tag,sender.titleLabel.text);
    }
    
}

#pragma  --mark 外部滑动的时候那个线显示的位置
-(void)setLocalIndex:(NSInteger)localIndex {
    __block CGFloat BF =0;
    [_localBtnListArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BF =BF +[self calculateRowWidth:_localListArr[idx]];
       
        if (idx ==localIndex) {
            [obj setTitleColor:_selectedColor?_selectedColor:[UIColor redColor] forState:UIControlStateNormal];
            obj.titleLabel.font =_selectedFont?_selectedFont:[UIFont boldSystemFontOfSize:15];
        } else {
            [obj setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            obj.titleLabel.font =[UIFont systemFontOfSize:14];

        }
    }];
    
    __block  CGFloat TW =0;
    [_localListArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TW =TW+[self calculateRowWidth:obj];
    }];
    
    if ((TW +15*_localListArr.count)<self.frame.size.width) {
        _line.frame =CGRectMake(self.frame.size.width/_localListArr.count*localIndex, self.frame.size.height-1,self.frame.size.width/_localListArr.count , 1);
    } else {
        _line.frame =CGRectMake(BF-[self calculateRowWidth:_localListArr[localIndex]]+localIndex*15, self.frame.size.height-1, [self calculateRowWidth:_localListArr[localIndex]], 1);
    }
}



-(void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor =selectedColor;
}


-(void)setLineColor:(UIColor *)lineColor {
    _line.backgroundColor =lineColor;
    
}

-(void)setNomalFont:(UIFont *)nomalFont {
    
    _nomalFont = nomalFont;
}

- (void)setSelectedFont:(UIFont *)selectedFont {
    _selectedFont = selectedFont;
}

@end
