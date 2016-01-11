//
//  PDSImage.h
//
//  Created by w91379137 on 2016/1/3.
//

#import <UIKit/UIKit.h>

@interface PDSImage : UIImage

#pragma mark - 產生純色圖
+ (UIImage *)makePureColorImage:(CGSize)size
                          Color:(UIColor *)color;

#pragma mark - 產生字圖
+ (UIImage *)makeTextImage:(NSString *)string
            FontDictionary:(NSDictionary *)fontDictionary;

#pragma mark - 產生漸層圖
+ (UIImage *)makeGradientImage:(CGSize)size
                    StartPoint:(CGPoint)startPoint
                      EndPoint:(CGPoint)endPoint
                        Colors:(NSArray *)colors
                      Location:(NSArray *)locations;

#pragma mark - 貼圖
+ (UIImage *)addImage:(UIImage *)image
      BackgroundImage:(UIImage *)backgroundImage
               Origin:(CGPoint)origin;

#pragma mark - 圓角
+ (UIImage *)makeRoundedImage:(UIImage *)image
                      Corners:(UIRectCorner)corners
                       Radius:(NSInteger)radius;

#pragma mark - 切圖
+ (UIImage *)clipImage:(UIImage *)image
                  Path:(UIBezierPath *)path;

#pragma mark - 中心轉換
+ (CGPoint)originOfCenterAlignImage:(UIImage *)image
                    BackgroundImage:(UIImage *)backgroundImage;

@end
