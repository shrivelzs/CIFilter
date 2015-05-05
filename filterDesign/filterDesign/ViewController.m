//
//  ViewController.m
//  filterDesign
//
//  Created by Shu Zhang on 4/29/15.
//  Copyright (c) 2015 Shu Zhang. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (nonatomic, strong)CIContext *context;

@property(nonatomic, strong)CIImage *Cimage;

@property (strong, nonatomic) IBOutlet UIImageView *imageView2;
@end

@implementation ViewController



//@synthesize currentImage = currentImage;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //Label will show under the filter subView
    NSArray *filterName = [NSArray arrayWithObjects:@"F1",@"F2",@"F3",@"F4",@"F5",@"F6",@"F7",@"F8", nil];
    //the filter subview windows will be added in a scrollview
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height - 80, self.view.bounds.size.width, 80)];
    _scrollView.backgroundColor = [UIColor blackColor];
    _scrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = YES;
    //Core Image Filter
    _context = [CIContext contextWithOptions:nil];
    _Cimage = [[CIImage alloc]initWithImage:self.ImageView.image];
    
    
    //calculate positions for every filter view
    float x = 0.0;
    for (NSInteger i = 0; i < 8; i++) {
        x = 10 + 51*i;
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setImageStyle:)];
        recognizer.numberOfTouchesRequired = 1;
        recognizer.numberOfTapsRequired = 1;
        //recognizer.delegate = self;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(x, 53, 40, 23)];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setText:[filterName objectAtIndex:i]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont systemFontOfSize:13.0f]];
        [label setTextColor:[UIColor whiteColor]];
        [label setUserInteractionEnabled:YES];
        [label setTag:i];
        
        [label addGestureRecognizer:recognizer];
        
        [_scrollView addSubview:label];
        
        UIImageView *subImageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, 10, 40, 43)];
        [subImageView setTag:i];
        [subImageView addGestureRecognizer:recognizer];
        [subImageView setUserInteractionEnabled:YES];
        ////
        UIImage *subImage = [self changeImage:i ];
        subImageView.image = subImage;
        
        
        [_scrollView addSubview:subImageView];
    }
    _scrollView.contentSize = CGSizeMake(x + 55, 80);
    [self.view addSubview:_scrollView];
}


//action will perform when tap subview
-(IBAction)setImageStyle:(UITapGestureRecognizer *)sender
{
    UIImage *newImage = [self changeImage:sender.view.tag];
    NSLog(@"%ld",(long)sender.view.tag);
    [_ImageView setImage:newImage];
    [_imageView2 setImage:newImage];
    
}

-(UIImage *)changeImage:(NSInteger)index
{
    UIImage *image;
    
    
    //8 filter could be selected, the filter are made by Core Image
    switch (index) {
        case 0:
        {
            return _ImageView.image;
            
        }
            break;
        case 1:
        {
            image = [self processImagewithFilter:@"CISepiaTone"];
            
        }
            break;
        case 2:
        {
            image = [self processImagewithFilter:@"CIPhotoEffectTonal"];
        }
            break;
        case 3:
        {
            image = [self processImagewithFilter:@"CIPhotoEffectChrome"];
        }
            break;
        case 4:
        {
            image = [self processImagewithFilter:@"CIPhotoEffectMono"];
        }
            break;
        case 5:
        {
            image = [self processImagewithFilter:@"CIPhotoEffectFade"];
        }
            break;
        case 6:
        {
            image = [self processImagewithFilter:@"CIPhotoEffectInstant"];
        }
            break;
        case 7:
        {
            image = [self processImagewithFilter:@"CIPhotoEffectTonal"];
        }
            break;
        case 8:
        {
            image = [self processImagewithFilter:@"CIPhotoEffectTransfer"];
        }
            break;

    }
    return image;
    
    
}

-(UIImage *)processImagewithFilter:(NSString *)filterName
{
    CIFilter *filter = [CIFilter filterWithName:filterName];
    [filter setValue:_Cimage forKey:kCIInputImageKey];
    //[filter setValue:@0.8f forKey:kCIInputIntensityKey];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGRect extent = [result extent];
    CGImageRef cgImage = [_context createCGImage:result fromRect:extent];
    UIImage *newImage = [UIImage imageWithCGImage:cgImage];
    
    
    return newImage;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
