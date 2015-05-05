//
//  ViewController.h
//  filterDesign
//
//  Created by Shu Zhang on 4/29/15.
//  Copyright (c) 2015 Shu Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface ViewController : UIViewController


//@property(nonatomic,strong)UIImage *currentImage;
//@property(nonatomic,strong)UIImageView *ImageView;
@property (strong, nonatomic) IBOutlet UIImageView *ImageView;
@property(nonatomic, strong) UIScrollView *scrollView;


@end

//@protocol ImageFilterProcessDelegate <NSObject>
//
//-(void)imageFitlerProcessDone:(UIImage *)image;
//
//@end