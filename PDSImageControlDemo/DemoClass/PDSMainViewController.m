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
    
    if (imageView == nil) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        imageView.backgroundColor = [UIColor colorWithRed:.1 green:.1 blue:.1 alpha:.3];
        imageView.contentMode = UIViewContentModeCenter;
        [self.view addSubview:imageView];
        
        UIImage *image =
        [PDSImage makePureColorImage:CGSizeMake(50, 50)
                               Color:[UIColor colorWithRed:.3 green:.8 blue:.5 alpha:.3]];
        NSLog(@"%@",NSStringFromCGSize(image.size));
        
        imageView.image = image;
    }
}

@end
