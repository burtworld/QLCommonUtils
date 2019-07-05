//
//  QLViewController.m
//  QLCommonUtils
//
//  Created by Paramita on 05/06/2019.
//  Copyright (c) 2019 Paramita. All rights reserved.
//

#import "QLViewController.h"

#import <QLCommonUtils/QLCommonUtils.h>
@interface QLViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation QLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *img = [UIImage imageNamed:@"pal61.jpg"];
    
    img = [QLHJWaterMarker getWaterMarkImage:img andTitle:@"this is title and " andMarkFont:nil andMarkColor:[UIColor redColor]];
    img = [QLHJWaterMarker getWaterMarkImage:img.size texts:@[@"i am so smart",@"无可厚非"] font:nil textColor:[UIColor greenColor] bgColor:[[UIColor yellowColor] colorWithAlphaComponent:0.3]];
    
    self.imageView.image = img;
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
