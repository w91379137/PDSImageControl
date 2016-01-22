//
//  PDSImageControl.h
//
//  Created by w91379137 on 2016/1/3.
//

#import <UIKit/UIKit.h>
#import "UIImage+PDSImage.h"

@interface PDSImageControl : NSObject
{
    
}

@property (nonatomic, strong) UIImage *image;

#pragma mark - Init
- (instancetype)initWithImage:(UIImage *)image;

#pragma mark - 貼圖
- (void)addImage:(UIImage *)image
          Origin:(CGPoint)origin;

- (void)addImageAtCenter:(UIImage *)image;

#pragma mark - 中心轉換
+ (CGPoint)originOfCenterAlignImage:(UIImage *)image
                    BackgroundImage:(UIImage *)backgroundImage;

@end
