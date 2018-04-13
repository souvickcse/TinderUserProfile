//
//  ViewController.m
//  TinderProfile
//
//  Created by souvick on 12/04/18.
//  Copyright © 2018 souvick. All rights reserved.
//

#import "ViewController.h"
#import "ProfileView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet ProfileView *profileView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_profileView setUpImageViewWithImageArr:@[@"https://picsum.photos/600/900/?image=180",
                                               @"https://picsum.photos/600/900/?image=152",
                                               @"https://picsum.photos/600/900/?image=432",
                                               @"https://picsum.photos/600/900/?image=48",
                                               ] userDetails:@{@"name":@"Souvick",
                                                               @"gender":@"Male",
                                                               @"like":@"10k Likes",
                                                               @"distance":@"20",
                                                               }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
