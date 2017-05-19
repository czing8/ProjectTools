//
//  VariousAnimationController.m
//  ProjectTools
//
//  Created by Vols on 2017/2/17.
//  Copyright © 2017年 Vols. All rights reserved.
//

#import "VariousAnimationController.h"
#import "VEffectsButton.h"

@interface VariousAnimationController ()

@end

@implementation VariousAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setEffectsButton];

}

- (void)setEffectsButton{
    float width = (self.view.frame.size.width - 44) / 4;
    float x = width / 2;
    float y = 20;
    
    // star button
    VEffectsButton *starButton = [[VEffectsButton alloc] initWithFrame:CGRectMake(x, y, 44, 44) image: [UIImage imageNamed:@"star"]];
    [self.view addSubview:starButton];
    x += width;
    
    // heart button
    VEffectsButton *heartButton = [[VEffectsButton alloc] initWithFrame:CGRectMake(x, y, 44, 44) image: [UIImage imageNamed:@"heart"]];
    heartButton.imageColorOn = [UIColor colorWithRed:254/255.0f green:110/255.0f blue:111/255.0f alpha:1.0];
    heartButton.circleColor = [UIColor colorWithRed:254/255.0f green:110/255.0f blue:111/255.0f alpha:1.0];
    heartButton.lineColor = [UIColor colorWithRed:226/255.0f green:96/255.0f blue:96/255.0f alpha:1.0];
    [self.view addSubview:heartButton];
    x += width;
    
    // heart button
    VEffectsButton *likeButton = [[VEffectsButton alloc] initWithFrame:CGRectMake(x, y, 44, 44) image: [UIImage imageNamed:@"like"]];
    likeButton.imageColorOn = [UIColor colorWithRed:52/255.0f green:152/255.0f blue:219/255.0f alpha:1.0];
    likeButton.circleColor = [UIColor colorWithRed:52/255.0f green:152/255.0f blue:219/255.0f alpha:1.0];
    likeButton.lineColor = [UIColor colorWithRed:41/255.0f green:128/255.0f blue:185/255.0f alpha:1.0];
    likeButton.duration = 2;
    [self.view addSubview:likeButton];
    x += width;
    
    // heart button
    VEffectsButton *smileButton = [[VEffectsButton alloc] initWithFrame:CGRectMake(x, y, 44, 44) image: [UIImage imageNamed:@"smile"]];
    smileButton.imageColorOn = [UIColor colorWithRed:45/255.0f green:204/255.0f blue:112/255.0f alpha:1.0];
    smileButton.circleColor = [UIColor colorWithRed:45/255.0f green:204/255.0f blue:112/255.0f alpha:1.0];
    smileButton.lineColor = [UIColor colorWithRed:45/255.0f green:195/255.0f blue:106/255.0f alpha:1.0];
    smileButton.duration = 1;
    [self.view addSubview:smileButton];
    x += width;
    
    starButton.selected = YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
