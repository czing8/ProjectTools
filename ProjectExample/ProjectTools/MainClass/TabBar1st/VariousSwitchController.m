//
//  VariousSwitchController.m
//  ProjectTools
//
//  Created by Vols on 2016/2/17.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "VariousSwitchController.h"
#import "VTextSwitch.h"
#import "VSwitch.h"
#import "VFlatSwitch.h"

#import "KLSwitch.h"

#define kGreenColor [UIColor colorWithRed:144/255.0 green: 202/255.0 blue: 119/255.0 alpha: 1.0]
#define kBlueColor [UIColor colorWithRed:129/255.0 green: 198/255.0 blue: 221/255.0 alpha: 1.0]
#define kYellowColor [UIColor colorWithRed:233/255.0 green: 182/255.0 blue: 77/255.0 alpha: 1.0]
#define kOrangeColor [UIColor colorWithRed:288/255.0 green: 135/255.0 blue: 67/255.0 alpha: 1.0]
#define kRedColor [UIColor colorWithRed:158/255.0 green: 59/255.0 blue: 51/255.0 alpha: 1.0]


@interface VariousSwitchController ()

@property (nonatomic, strong) VFlatSwitch * flatSwitch;

@property (nonatomic, strong)  KLSwitch *smallestSwitch;
@property (nonatomic, strong)  KLSwitch *smallSwitch;
@property (nonatomic, strong)  KLSwitch *mediumSwitch;
@property (nonatomic, strong)  KLSwitch *bigSwitch;
@property (nonatomic, strong)  KLSwitch *biggestSwitch;

@end

@implementation VariousSwitchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRGB(250, 250, 250);
    [self setTextSwitchUIs];
    [self setSwitchUIs];
    [self setFlatSwitchUIs];
    [self setKLSwitchUIs];
}

- (void)setTextSwitchUIs {
    
    VTextSwitch *swit = [VTextSwitch switchWithFrame:CGRectMake(20, 60, 80, 40)
                                             onColor:kRGB(240, 0, 130)
                                            offColor:kRGB(0, 192, 246)
                                                font:24
                                            ballSize:30];
    swit.onText = @"女";
    swit.offText = @"男";
    [self.view addSubview:swit];
    [swit addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)setSwitchUIs {
    VSwitch * funnySwitch = [[VSwitch alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 120)/2, 100, 120, 60)];
    [funnySwitch setSwitchDidSelectedBlock:^(BOOL isOn) {
        if (isOn) {
            NSLog(@"Changed value to: %@", isOn ? @"ON" : @"OFF");
        }
    }];
    [self.view addSubview:funnySwitch];
}


- (void)setFlatSwitchUIs {
    
    VFlatSwitch *mySwitch = [[VFlatSwitch alloc] initWithFrame:CGRectZero];
    mySwitch.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5);
    [mySwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:mySwitch];
    mySwitch.on = YES;
    
    VFlatSwitch *mySwitch2 = [[VFlatSwitch alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    mySwitch2.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5 - 50);
    [mySwitch2 addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    mySwitch2.offImage = [UIImage imageNamed:@"cross.png"];
    mySwitch2.onImage = [UIImage imageNamed:@"check.png"];
    mySwitch2.onTintColor = [UIColor colorWithHue:0.08f saturation:0.74f brightness:1.00f alpha:1.00f];
    mySwitch2.isRounded = NO;
    [self.view addSubview:mySwitch2];
    [mySwitch2 setOn:YES animated:YES];
    
    
    VFlatSwitch *mySwitch3 = [[VFlatSwitch alloc] initWithFrame:CGRectZero];
    mySwitch3.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5 + 50);
    [mySwitch3 addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:mySwitch3];
    
    //self.view.backgroundColor = [UIColor colorWithRed:0.19f green:0.23f blue:0.33f alpha:1.00f];
    mySwitch3.thumbTintColor = [UIColor colorWithRed:0.19f green:0.23f blue:0.33f alpha:1.00f];
    mySwitch3.activeColor = [UIColor colorWithRed:0.07f green:0.09f blue:0.11f alpha:1.00f];
    mySwitch3.inactiveColor = [UIColor colorWithRed:0.07f green:0.09f blue:0.11f alpha:1.00f];
    mySwitch3.onTintColor = [UIColor colorWithRed:0.45f green:0.58f blue:0.67f alpha:1.00f];
    mySwitch3.borderColor = [UIColor clearColor];
    mySwitch3.shadowColor = [UIColor blackColor];
}


- (void)setKLSwitchUIs{
    
    [self.view addSubview:self.smallestSwitch];
    [self.view addSubview:self.smallSwitch];
    [self.view addSubview:self.mediumSwitch];
    [self.view addSubview:self.bigSwitch];
    [self.view addSubview:self.biggestSwitch];
    
    [self.smallestSwitch setTintColor: kGreenColor];
    [self.smallSwitch setOnTintColor: kBlueColor];
    [self.mediumSwitch setOnTintColor: kYellowColor];
    [self.bigSwitch setOnTintColor: kOrangeColor];
    [self.biggestSwitch setOnTintColor: kRedColor];
    
    [self.smallestSwitch setOn: YES
                      animated: YES];
    [self.smallestSwitch setDidChangeHandler:^(BOOL isOn) {
        NSLog(@"Smallest switch changed to %d", isOn);
    }];
    
    [self.smallSwitch setOn: YES
                   animated: YES];
    [self.smallSwitch setDidChangeHandler:^(BOOL isOn) {
        NSLog(@"Small switch changed to %d", isOn);
    }];
    
    [self.mediumSwitch setOn: YES
                    animated: YES];
    [self.mediumSwitch setDidChangeHandler:^(BOOL isOn) {
        NSLog(@"Medium switch changed to %d", isOn);
    }];
    
    [self.bigSwitch setOn: YES
                 animated: YES];
    [self.bigSwitch setDidChangeHandler:^(BOOL isOn) {
        NSLog(@"Big switch changed to %d", isOn);
    }];
    
    [self.biggestSwitch setOn: YES
                     animated: YES];
    [self.biggestSwitch setDidChangeHandler:^(BOOL isOn) {
        NSLog(@"Biggest switch changed to %d", isOn);
    }];
    
}

#pragma mark - Properties

- (void)switchAction:(VTextSwitch *)sender {
    NSLog(@"%s", __FUNCTION__);
}

- (void)switchChanged:(VFlatSwitch *)sender {
    NSLog(@"Changed value to: %@", sender.on ? @"ON" : @"OFF");
}


#pragma mark - Properties

- (KLSwitch *)smallestSwitch{
    if (_smallestSwitch == nil) {
        _smallestSwitch = [[KLSwitch alloc] initWithFrame:CGRectMake(10, 200, 60, 30)];
    }
    return _smallestSwitch;
}


- (KLSwitch *)smallSwitch{
    if (_smallSwitch == nil) {
        _smallSwitch = [[KLSwitch alloc] initWithFrame:CGRectMake(10, 240, 80, 30)];
    }
    return _smallSwitch;
}

- (KLSwitch *)mediumSwitch{
    if (_mediumSwitch == nil) {
        _mediumSwitch = [[KLSwitch alloc] initWithFrame:CGRectMake(10, 280, 60, 30)];
    }
    return _mediumSwitch;
}

- (KLSwitch *)bigSwitch{
    if (_bigSwitch == nil) {
        _bigSwitch = [[KLSwitch alloc] initWithFrame:CGRectMake(10, 320, 60, 30)];
    }
    return _bigSwitch;
}

- (KLSwitch *)biggestSwitch{
    if (_biggestSwitch == nil) {
        _biggestSwitch = [[KLSwitch alloc] initWithFrame:CGRectMake(10, 360, 80, 40)];
    }
    return _biggestSwitch;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
