//
//  ViewController.m
//  AnimationDemo
//
//  Created by 于小水 on 2017/5/9.
//  Copyright © 2017年 于小水. All rights reserved.
//

#import "ViewController.h"
#import "AnimationView.h"
@interface ViewController ()
@property (nonatomic,strong)AnimationView *animationView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    [self.animationView start];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(AnimationView *)animationView{
    if (!_animationView) {
        _animationView=[[AnimationView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        _animationView.branchCount=2;
        _animationView.center=self.view.center;
        [self.view addSubview:_animationView];
    }
    return _animationView;
}
@end
