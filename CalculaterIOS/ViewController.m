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

- (IBAction)clickAC:(id)sender {
    [resultLabel setText:@""];
}

- (IBAction)calculate:(id)sender {
    NSString *TEXT = resultLabel.text;
    if ([TEXT isEqual:@""])
        TEXT = @"0";
    
    NSArray *infixExpression = [self componentsSeparatedByOperators:TEXT];
    
    printf("中缀表达式:");
    for(NSString *each in infixExpression){
        printf("%s ", [each UTF8String]);
    }
    printf("\n");

    NSMutableArray *postfixExpression = [self infixToPostfix:infixExpression];
    
    printf("后缀表达式:");
    for(NSString *each in postfixExpression){
        printf("%s ", [each UTF8String]);
    }
    printf("\n");
    
    NSMutableArray *OPND = [NSMutableArray new];
    
    while (![[postfixExpression firstObject] isEqual:@"#"]) {
    //for (NSString *each in postfixExpression){
        NSString *each = [postfixExpression firstObject];
        if (isnumber([each characterAtIndex:0])) {
            [OPND addObject:each];
        }
        else{
            double A,B,C;
            A = [[OPND lastObject] doubleValue];
            [OPND removeLastObject];
            B = [[OPND lastObject] doubleValue];
            [OPND removeLastObject];
            
            NSArray *OP = [NSArray arrayWithObjects:@"+", @"-", @"*", @"/", nil];
            
            switch ([OP indexOfObject:each]) {
                case 0:
                    C = B + A;
                    break;
                case 1:
                    C = B - A;
                    break;
                case 2:
                    C = B * A;
                    break;
                case 3:
                    C = B / A;
                    break;
                    
                default:
                    break;
            }
            
            [OPND addObject:[[NSString alloc] initWithFormat:@"%f",C]];
        }
        [postfixExpression removeObjectAtIndex:0];
    }
    
    resultLabel.text = [OPND objectAtIndex:0];
}

- (NSMutableArray *)infixToPostfix:(NSArray *)infixExpression{
    //栈内优先数
    NSDictionary *inStackPriority = @{@"#":@"0",
                                      @"(":@"1",
                                      @"*":@"5",
                                      @"/":@"5",
                                      @"+":@"3",
                                      @"-":@"3",
                                      @")":@"6"};
    //栈外优先数
    NSDictionary *inComingPriority = @{@"#":@"0",
                                       @"(":@"6",
                                       @"*":@"4",
                                       @"/":@"4",
                                       @"+":@"2",
                                       @"-":@"2",
                                       @")":@"1"};
    NSMutableArray *OPTR = [NSMutableArray new]; [OPTR addObject:@"#"]; //运算符栈
    NSMutableArray *suffixList = [NSMutableArray new];
    
    for (NSString *each in infixExpression){
        if (isnumber([each characterAtIndex:0])) {
            //操作数入栈
            [suffixList addObject:each];
        }
        else{
            //等于的情况只有栈外@")"，栈内@"(" 和 栈外@"#"，栈内@"#"
            while ([[inStackPriority objectForKey:[OPTR lastObject]] intValue] >= [[inComingPriority objectForKey:each] intValue]){
                //当each为右括号时出栈到第一个左括号为止
                if ([[OPTR lastObject] isEqual:@"("]){
                    [OPTR removeLastObject];
                    break;
                }
                //弹出符号栈所有剩余符号为止
                else if ([[OPTR lastObject] isEqual:@"#"]){
                    [suffixList addObject:[OPTR lastObject]];
                    break;
                }
                else{
                    [suffixList addObject:[OPTR lastObject]];
                    [OPTR removeLastObject];
                }
            }
            if (![each isEqual:@")"])
                [OPTR addObject:each];
        }
    }
    return suffixList;
}

- (NSArray *)componentsSeparatedByOperators:(NSString *)TEXT{
    NSString *TEMP = @"";
    for(int i = 0; i < TEXT.length; i++){
        NSString *c = [TEXT substringWithRange:NSMakeRange(i, 1)];
        if(isnumber([c characterAtIndex:0])|[c isEqual:@"."])
            TEMP = [TEMP stringByAppendingString:c];
        else if([c  isEqual: @"("])
            TEMP = [TEMP stringByAppendingString:[[NSString alloc] initWithFormat:@"%@ ", c]];
        else if ([c  isEqual: @")"])
            TEMP = [TEMP stringByAppendingString:[[NSString alloc] initWithFormat:@" %@", c]];
        else
            TEMP = [TEMP stringByAppendingString:[[NSString alloc] initWithFormat:@" %@ ", c]];
    }
    return [[TEMP stringByAppendingString:@" #"] componentsSeparatedByString:@" "];
}

@end
