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
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickNumber:(UIButton *)sender {
    resultLabel.text = [resultLabel.text stringByAppendingString:sender.titleLabel.text];
    sender.backgroundColor = [UIColor lightGrayColor];
}
- (IBAction)buttonTouchDown:(UIButton *)sender {
    sender.backgroundColor = [UIColor redColor];
}

- (IBAction)clickAC:(UIButton *)sender {
    [resultLabel setText:@""];
    sender.backgroundColor = [UIColor lightGrayColor];
}

- (IBAction)calculate:(UIButton *)sender {
    
    resultLabel.text = [CalculateModel resolveWithString:resultLabel.text];
    
    sender.backgroundColor = [UIColor orangeColor];
}

@end
