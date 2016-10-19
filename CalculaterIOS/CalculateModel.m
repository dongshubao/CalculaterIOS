//
//  CalculateModel.m
//  CalculaterIOS
//
//  Created by 董淑宝 on 2016/10/17.
//  Copyright © 2016年 董淑宝. All rights reserved.
//

#import "CalculateModel.h"

@implementation CalculateModel

+ (NSString *)evaluateExpression:(NSArray *)infixExpression{
    //栈内优先数
    NSDictionary *inStackPriority = @{@"#":@"0", @"(":@"1", @"*":@"5", @"/":@"5", @"+":@"3", @"-":@"3", @")":@"6"};
    //栈外优先数
    NSDictionary *inComingPriority = @{@"#":@"0", @"(":@"6", @"*":@"4", @"/":@"4", @"+":@"2", @"-":@"2", @")":@"1"};
    
    NSMutableArray *OPND = [NSMutableArray new];    //操作数栈
    NSMutableArray *OPTR = [NSMutableArray new]; [OPTR addObject:@"#"]; //运算符栈
    
    
    int i = 0;
    NSString *each = infixExpression[i];
    
    while (![each isEqual:@"#"] || ![[OPTR lastObject] isEqual:@"#"]) {
        
        if ([each  isEqual: @""])
            return nil;
        
        if ([self isNumberString:each]) {
            //格式化操作数并入栈
            [OPND addObject:[[NSNumber numberWithDouble:[each doubleValue]] stringValue]];
            each = infixExpression[++i];
        }
        else{
            int ISP = [[inStackPriority objectForKey:[OPTR lastObject]] intValue];
            int ICP = [[inComingPriority objectForKey:each] intValue];
            
            if (ISP > ICP){
                NSString *A,*B,*theta;
                
                A = [OPND lastObject];
                [OPND removeLastObject];
                
                B = [OPND lastObject];
                [OPND removeLastObject];
                
                theta = [OPTR lastObject];
                [OPTR removeLastObject];
                
                [OPND addObject:[self operate:A :theta :B]];
            }
            else if (ISP == ICP){
                [OPTR removeLastObject];
                each = infixExpression[++i];
            }
            else if (ISP < ICP){
                [OPTR addObject:each];
                each = infixExpression[++i];
            }
        }
    }
    return [OPND lastObject];
}

+ (BOOL)isNumberString:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];

    if ([scan scanInt:NULL] && [scan isAtEnd])
        return true;
    
    scan = [NSScanner scannerWithString:string];
    if ([scan scanFloat:NULL] && [scan isAtEnd])
        return true;
    
    scan = [NSScanner scannerWithString:string];
    if ([scan scanDouble:NULL] && [scan isAtEnd])
        return true;
    
    return false;
}

+ (NSString *)operate:(NSString *)value1 :(NSString *)theta :(NSString *)value2{
    double A = [value1 doubleValue];
    double B = [value2 doubleValue];
    double C;
    
    if ([theta isEqual:@"+"])
        C = B + A;
    else if ([theta isEqual:@"-"])
        C = B - A;
    else if ([theta isEqual:@"*"])
        C = B * A;
    else if ([theta isEqual:@"/"])
        C = B / A;
    
    return [[NSNumber numberWithDouble:C] stringValue];//[[NSString alloc] initWithFormat:@"%f",C];
}

+ (NSArray *)componentsSeparatedByOperators:(NSString *)TEXT{
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

+ (NSString *)resolveWithString:(NSString *)TEXT{
    if ([TEXT isEqual:@""])
        TEXT = @"0";
    
    NSArray *infixExpression = [self componentsSeparatedByOperators:TEXT];
    
    NSString *result = [self evaluateExpression:infixExpression];
    
    if (result != nil)
        return result;
    else
        return @"错误";
}
@end
