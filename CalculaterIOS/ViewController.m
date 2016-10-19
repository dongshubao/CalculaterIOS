//
//  ViewController.m
//  CalculaterIOS
//
//  Created by 董淑宝 on 2016/10/12.
//  Copyright © 2016年 董淑宝. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize resultLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加左划手势
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleLabelLeftSwipe)];
    [leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    resultLabel.userInteractionEnabled = YES;
    [resultLabel addGestureRecognizer:leftSwipe];
    
    for(id item in self.view.subviews){
        if ([item class] == [UIButton class]) {
            [item addTarget:self action:@selector(buttonTouchDownEffect:) forControlEvents:UIControlEventTouchDown];
            [item addTarget:self action:@selector(buttonTouchUpInsideEffect:) forControlEvents:UIControlEventTouchUpInside];
            [item addTarget:self action:@selector(buttonTouchUpInsideEffect:) forControlEvents:UIControlEventTouchUpOutside];
        }
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)handleLabelLeftSwipe{
    if (![resultLabel.text isEqual: @""]) {
        resultLabel.text = [resultLabel.text substringToIndex:resultLabel.text.length-1];
    }
}


- (IBAction)clickNumber:(UIButton *)sender {
    resultLabel.text = [resultLabel.text stringByAppendingString:sender.titleLabel.text];
}


- (IBAction)clickAC:(UIButton *)sender {
    [resultLabel setText:@""];
}


- (IBAction)calculate:(UIButton *)sender {
    resultLabel.text = [CalculateModel resolveWithString:resultLabel.text];
}

- (void)buttonTouchDownEffect:(UIButton *)sender {
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    visualEffectView.frame = sender.bounds;
    visualEffectView.alpha = 1;
    sender.maskView = visualEffectView;
    AudioServicesPlaySystemSound(1104);
}

- (void)buttonTouchUpInsideEffect:(UIButton *)sender { sender.maskView = nil; }

- (UIStatusBarStyle)preferredStatusBarStyle { return UIStatusBarStyleLightContent; }

@end
