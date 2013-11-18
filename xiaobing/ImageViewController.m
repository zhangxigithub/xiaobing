//
//  ImageViewController.m
//  xiaobing
//
//  Created by 张 玺 on 13-6-2.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import "ImageViewController.h"
#import <UIImageView+AFNetworking.h>


@implementation ImageViewController
//
////-(id)initWithPodcast:(XBPodcast *)thePodcast
////{
////    self = [super init];
////    if (self) {
////        podcast = thePodcast;
////        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
////    }
////    return self;
////}
//- (id)init
//{
//    self = [super init];
//    if (self) {
//        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    }
//    return self;
//}
//
//
//-(void)setPodcast:(XBPodcast *)thePodcast
//{
//    _podcast = thePodcast;
//    
//    
//    
//    
//    rateView.value = 0;
//    rateView.hidden = NO;
//    imageView.image = nil;
//    [activityIndicatorView startAnimating];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:self.podcast.largeImageURL];
//    
//AFImageRequestOperation *op = [AFImageRequestOperation imageRequestOperationWithRequest:request
//       imageProcessingBlock:^UIImage *(UIImage *image) {
//           
//           return image;
//       } success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//           
//           [activityIndicatorView stopAnimating];
//           rateView.hidden = YES;
//           imageView.image = image;
//           
//           float rate = [[UIScreen mainScreen] scale];
//           rate =1;
//           imageView.frame = CGRectMake(60, 80, kContent_Width-120, kContent_Height-140);
//           
//           imageView.alpha = 0;
//           [UIView animateWithDuration:0.2
//                            animations:^{
//                                imageView.alpha =1;
//                                imageView.frame = CGRectMake(0, 0, image.size.width/rate, image.size.height/rate);
//                            }];
//           canvas.contentSize = imageView.frame.size;
//           
//           //canvas.contentSize = CGSizeMake(image.size.width/2, image.size.height/2)
//           
//       } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//           
//       }];
//
//    [op setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
//        NSLog(@"%d   %lld    %lld",bytesRead,totalBytesRead,totalBytesExpectedToRead);
//        rateView.value = (float)totalBytesRead/(float)totalBytesExpectedToRead;
//    }];
//    
//    [op start];
//}
//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//}
//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
//
//{
//    return imageView;
//}
//-(void)scrollViewDidZoom:(UIScrollView *)scrollView
//{
//    //CGRect newFrame = self.view.bounds;
//    //newFrame.size.width *= scrollView.zoomScale;
//    
//    return;
//    if(scrollView.zoomScale < 1)
//    {
//     [UIView animateWithDuration:0.3
//                     animations:^{
//                         imageView.center = canvas.center;
//                     }];
//    }
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    
//    self.view.backgroundColor = [UIColor blackColor];
//
//    
//    canvas = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    canvas.minimumZoomScale = 1;
//    canvas.maximumZoomScale = 2;
//    canvas.alwaysBounceHorizontal = YES;
//    canvas.alwaysBounceVertical = YES;
//
//    canvas.delegate = self;
//    [self.view addSubview:canvas];
//    
//    imageView = [[UIImageView alloc] initWithFrame:canvas.bounds];
//    //[imageView setImageWithURL:self.podcast.imageURL];
//    [canvas addSubview:imageView];
//    
//    
//    activityIndicatorView = [[UIActivityIndicatorView alloc] init];
//    activityIndicatorView.center = self.view.center;
//    activityIndicatorView.hidesWhenStopped = YES;
//    [self.view addSubview:activityIndicatorView];
//    [activityIndicatorView startAnimating];
//    
//    
//    rateView = [[PageNumberView alloc] initWithFrame:CGRectMake(0,0, 60, 60)];
//    rateView.value = 0;
//    [self.view addSubview:rateView];
//    rateView.center = self.view.center;
//
////    [imageView setImageWithURLRequest:request
////                     placeholderImage:nil
////                              success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
////                                  //imageView.image = image;
////                                  [activityIndicatorView stopAnimating];
////                              } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
////                                  
////                              }];
//    
//    
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
//    [canvas addGestureRecognizer:tap];
//}
//-(void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    
//    canvas.minimumZoomScale = 1;
//    canvas.maximumZoomScale = 2;
//    canvas.alwaysBounceHorizontal = YES;
//    canvas.alwaysBounceVertical = YES;
//    canvas.zoomScale =1;
//    
//}
//-(void)tap
//{
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
//}
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//
//}

@end
