//
//  UILabel+custom.m
//  yxzj
//
//  Created by tokee on 15/12/11.
//  Copyright © 2015年 tokee. All rights reserved.
//

#import "UILabel+custom.h"

@implementation UILabel (custom)

- (CGSize)boundingRectWithSize:(CGSize)size {
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    CGSize retSize = [self.text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    return retSize;
}

@end
