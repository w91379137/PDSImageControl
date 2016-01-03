//
//  PDSImage.h
//
//  Created by w91379137 on 2016/1/3.
//

#import <UIKit/UIKit.h>

@interface PDSImage : UIImage

#pragma mark - 做純色圖
+ (UIImage *)makePureColorImage:(CGSize)size
                          Color:(UIColor *)color;

#pragma mark - 做漸層圖
+ (UIImage *)makeGradientImage:(CGSize)size
                    StartPoint:(CGPoint)startPoint
                      EndPoint:(CGPoint)endPoint
                        Colors:(NSArray *)colors
                      Location:(NSArray *)locations;

@end
