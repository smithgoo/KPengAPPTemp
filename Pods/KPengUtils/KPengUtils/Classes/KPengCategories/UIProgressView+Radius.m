              //
//  UIProgressView+Radius.m
//  SpokenEvaluation
//
//  Created by 王朋 on 2017/8/7.
//  Copyright © 2017年 cnsunrun. All rights reserved.
//

#import "UIProgressView+Radius.h"

@implementation UIProgressView (Radius)

- (void)setRadiusTrackColor:(UIColor*)trackColor cornerRadius:(float )cornerRadius
{
    UIImage * trackImage = [ self imageWithColor:trackColor cornerRadius:cornerRadius];
    [ self setTrackImage:trackImage];
}

-(void)setRadiusProgressColor:(UIColor*)progressColor cornerRadius:(float )cornerRadius
{
    UIImage * progressImage = [ self imageWithColor:progressColor cornerRadius: cornerRadius];
    [ self setProgressImage:progressImage];
}

-(void)setRadiusTrackColor:(UIColor*)trackColor progressColor:(UIColor*)progressColor cornerRadius:(float )cornerRadius;
{
    [ self setRadiusTrackColor:trackColor cornerRadius:cornerRadius];
    [ self setRadiusProgressColor:progressColor cornerRadius:cornerRadius];
}

//最小尺寸---1px
static CGFloat edgeSizeWithRadius(CGFloat cornerRadius) {
    return cornerRadius * 2 + 1;
}


- (UIImage *)imageWithColor:(UIColor *)color
               cornerRadius:(CGFloat)cornerRadius {
    CGFloat minEdgeSize = edgeSizeWithRadius(cornerRadius);
    CGRect rect = CGRectMake(0, 0, minEdgeSize, minEdgeSize);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    roundedRect.lineWidth = 0;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}
@end
