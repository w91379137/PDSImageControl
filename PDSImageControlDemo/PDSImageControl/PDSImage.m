//
//  PDSImage.m
//
//  Created by w91379137 on 2016/1/3.
//

#import "PDSImage.h"

@implementation PDSImage

+(UIImage *)makePureColorImage:(CGSize)size
                         Color:(UIColor *)color
{
    UIImage *aPureColorImage = nil;
    
    if (color != nil) {
        CGSize imageSize = size;
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
        [color set];
        UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
        aPureColorImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return aPureColorImage;
}

@end
