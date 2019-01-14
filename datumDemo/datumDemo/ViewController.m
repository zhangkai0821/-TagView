//
//  ViewController.m
//  datumDemo
//
//  Created by zhangkai on 2019/1/6.
//  Copyright © 2019年 zhangkai. All rights reserved.
//

#import "ViewController.h"
#import "ZKDatumVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel *newLabal = [[UILabel alloc] init];
    newLabal.font = [UIFont systemFontOfSize:16];
    newLabal.text = @"学习";
    newLabal.frame = CGRectMake(10, 100, 0, 0);
    [newLabal sizeToFit];
    
    CGSize newSize = [self widthForLabel:@"学习" fontSize:16];
    NSLog(@"size---%@", NSStringFromCGSize(newSize));
    NSLog(@"label--%@", NSStringFromCGRect(newLabal.frame));
    [self.view addSubview:newLabal];
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ZKDatumVC *VC = [[ZKDatumVC alloc] init];
    [self presentViewController:VC animated:YES completion:nil];
}
- (CGSize)widthForLabel:(NSString *)text fontSize:(CGFloat)font
{
    
    CGSize size = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil]];
    
    return size;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
