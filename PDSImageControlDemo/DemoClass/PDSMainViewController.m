//
//  PDSMainViewController.m
//
//  Created by w91379137 on 2016/1/3.
//

#import "PDSMainViewController.h"
#import "PDSImage.h"

@interface PDSMainViewController ()

@end

@implementation PDSMainViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CGSize imageSize = CGSizeMake(50, 50);
    
    CGSize imageViewSize = CGSizeMake(70, 70);
    UIColor *imageViewBgColor = [UIColor colorWithRed:.5 green:.5 blue:.5 alpha:.3];
    
    UIColor *demoColor1 = [UIColor colorWithRed:.3 green:.8 blue:.5 alpha:.8];
    UIColor *demoColor2 = [UIColor colorWithRed:.5 green:.3 blue:.8 alpha:.8];
    UIColor *demoColor3 = [UIColor colorWithRed:.8 green:.5 blue:.3 alpha:.8];
    UIColor *demoColor4 = [UIColor lightGrayColor];
    
    {
        UIImageView *imageView =
        [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, imageViewSize.width, imageViewSize.width)];
        imageView.backgroundColor = imageViewBgColor;
        imageView.contentMode = UIViewContentModeCenter;
        [self.view addSubview:imageView];
        
        UIImage *image =
        [PDSImage makePureColorImage:imageSize
                               Color:demoColor1];
        NSLog(@"%@",NSStringFromCGSize(image.size));
        
        imageView.image = image;
    }
    {
        UIImageView *imageView =
        [[UIImageView alloc] initWithFrame:CGRectMake(imageViewSize.width, 20, imageViewSize.width, imageViewSize.width)];
        imageView.backgroundColor = imageViewBgColor;
        imageView.contentMode = UIViewContentModeCenter;
        [self.view addSubview:imageView];
        
        UIImage *image =
        [PDSImage makeGradientImage:imageSize
                         StartPoint:CGPointMake(0, 0)
                           EndPoint:CGPointMake(imageSize.width, imageSize.height)
                             Colors:@[demoColor1,demoColor2,demoColor3,demoColor4]
                           Location:@[@0,@0.3,@0.7,@1]];
        NSLog(@"%@",NSStringFromCGSize(image.size));
        
        imageView.image = image;
    }
}

@end
