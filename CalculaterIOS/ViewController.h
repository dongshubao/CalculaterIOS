//
//  ViewController.h
//  CalculaterIOS
//
//  Created by 董淑宝 on 2016/10/12.
//  Copyright © 2016年 董淑宝. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculateModel.h"
#import "AboutViewController.h"

@interface ViewController : UIViewController <UIPopoverPresentationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end
