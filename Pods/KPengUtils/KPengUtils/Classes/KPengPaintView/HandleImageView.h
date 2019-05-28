 

#import <UIKit/UIKit.h>

@class HandleImageView;

@protocol HandleImageViewDelegate <NSObject>

@optional
- (void)handleImageView:(HandleImageView *)handleImageView didHandleImage:(UIImage *)image;

@end

@interface HandleImageView : UIView

@property (nonatomic, strong) UIImage *image;


@property (nonatomic, weak) id<HandleImageViewDelegate> delegate;

@end
