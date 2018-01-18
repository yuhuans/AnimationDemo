//
//  AnimationView.m
//  AnimationDemo
//
//  Created by 于小水 on 2017/5/9.
//  Copyright © 2017年 于小水. All rights reserved.
//

#import "AnimationView.h"
#define KOriginalR 10 //原始半径
@implementation AnimationView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
//        [self setUp];
    }
    return self;
}
-(void)setUp{
    for (int i=0 ; i<_branchCount; i++) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KOriginalR*2, KOriginalR*2)];
        view.layer.cornerRadius = view.frame.size.width / 2;
        view.layer.masksToBounds = YES;
        view.backgroundColor=[UIColor colorWithRed:89.0/255.0 green:193.0/255.0 blue:188.0/255.0 alpha:0.5];
        view.tag=100+i;
        view.center=self.center;
        [self addSubview:view];
    }
}
-(void)start{
    float distance=self.frame.size.width/4;
    UIView *view=[self viewWithTag:101];
    NSMutableArray *positionArr=[NSMutableArray new];
    //一个角除去垂直水平几个分支 则一个角除去垂直水平几个对角线
    float branchOfAnAngle = M_PI*2/_branchCount;
    //        [positionArr addObject:[NSValue valueWithCGPoint:CGPointMake(view.layer.position.x, view.layer.position.y-distance)]];
    float angle = 0;
    while (angle < M_PI*2) {
        angle = angle + branchOfAnAngle;
        if (0 < angle < M_PI/2) {
            [positionArr addObject:[NSValue valueWithCGPoint:CGPointMake(view.layer.position.x+cos(angle)*distance, view.layer.position.y-sin(angle)*distance)]];
        }else if(angle == 0){
            [positionArr addObject:[NSValue valueWithCGPoint:CGPointMake(view.layer.position.x+distance, view.layer.position.y)]];
        }else if (angle == M_PI/2){
            [positionArr addObject:[NSValue valueWithCGPoint:CGPointMake(view.layer.position.x, view.layer.position.y-distance)]];
        }else if (angle == M_PI){
            [positionArr addObject:[NSValue valueWithCGPoint:CGPointMake(view.layer.position.x-distance, view.layer.position.y)]];
        }else if (angle == M_PI/4*3){
            [positionArr addObject:[NSValue valueWithCGPoint:CGPointMake(view.layer.position.x, view.layer.position.y+distance)]];
        }else if (M_PI/2 < angle < M_PI){
            [positionArr addObject:[NSValue valueWithCGPoint:CGPointMake(view.layer.position.x-cos(angle)*distance, view.layer.position.y-sin(angle)*distance)]];
        }else if (M_PI < angle < M_PI/4*3){
            [positionArr addObject:[NSValue valueWithCGPoint:CGPointMake(view.layer.position.x-cos(angle)*distance, view.layer.position.y+sin(angle)*distance)]];
        }else if (M_PI/4*3 < angle < M_PI*2){
            [positionArr addObject:[NSValue valueWithCGPoint:CGPointMake(view.layer.position.x+cos(angle)*distance, view.layer.position.y+sin(angle)*distance)]];
        }
    }
//    if (_branchCount%2 == 0) {
//        //一个角除去垂直水平几个分支 则一个角除去垂直水平几个对角线
//        float branchOfAnAngle;
//        //diagonal 对角线个数
//        float diagonalCount = _branchCount/2;
//        // vertical 垂直
//        if (_branchCount%4==0) {
//            [positionArr addObject:[NSValue valueWithCGPoint:CGPointMake(view.layer.position.x, view.layer.position.y+distance)]];
//            [positionArr addObject: [NSValue valueWithCGPoint:CGPointMake(view.layer.position.x, view.layer.position.y-distance)]];
//            branchOfAnAngle=diagonalCount-2;
//        }else{
//            branchOfAnAngle=diagonalCount-1;
//        }
//        //horizontal 水平
//        [positionArr addObject:[NSValue valueWithCGPoint:CGPointMake(view.layer.position.x+distance, view.layer.position.y)]];
//         [positionArr addObject:[NSValue valueWithCGPoint:CGPointMake(view.layer.position.x-distance, view.layer.position.y)]];
//        float angle=M_PI*2/_branchCount;
//        for(int i=1;i<branchOfAnAngle+1;i++){
//            CGPoint point1=CGPointMake(view.layer.position.x+cos(angle*i)*distance, view.layer.position.y-distance*sin(angle*i));
//            CGPoint point2=CGPointMake(view.layer.position.x+cos(angle*i)*distance, view.layer.position.y+distance*sin(angle*i));
//            [positionArr addObject:[NSValue valueWithCGPoint:point1]];
//            [positionArr addObject:[NSValue valueWithCGPoint:point2]];
//            [positionArr addObject:[NSValue valueWithCGPoint:CGPointMake(view.layer.position.x-cos(angle*i)*distance, view.layer.position.y-distance*sin(angle*i))]];
//            [positionArr addObject:[NSValue valueWithCGPoint:CGPointMake(view.layer.position.x-cos(angle*i)*distance, view.layer.position.y+distance*sin(angle*i))]];
//        }
//    }else{
//
//    }
    for (int i=0 ; i<_branchCount; i++) {
        UIView *view=[self viewWithTag:100+i];
        CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnima.fromValue = [NSNumber numberWithFloat:1.0f];
        scaleAnima.toValue = [NSNumber numberWithFloat:distance/KOriginalR];
        
        CABasicAnimation *positionAnima = [CABasicAnimation animationWithKeyPath:@"position"];
        positionAnima.fromValue = [NSValue valueWithCGPoint:view.center];
        positionAnima.toValue=positionArr[i];
        //组动画
        CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
        groupAnimation.animations = [NSArray arrayWithObjects:scaleAnima,positionAnima, nil];
        groupAnimation.duration = 4.0f;
        groupAnimation.autoreverses = YES;
        groupAnimation.fillMode = kCAFillModeForwards;
        groupAnimation.removedOnCompletion = NO;
        groupAnimation.repeatCount = MAXFLOAT;
        
        [view.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
        
    }
    //旋转动画
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anima.toValue = [NSNumber numberWithFloat:M_PI*2];
    anima.duration = 4.0f;
    anima.autoreverses = YES;
    anima.fillMode = kCAFillModeForwards;
    anima.removedOnCompletion = NO;
    anima.repeatCount = MAXFLOAT;
    [self.layer addAnimation:anima forKey:@"transform"];
}
#pragma -mark -gettr
-(void)setBranchCount:(int)branchCount{
    _branchCount=branchCount;
    [self setUp];
}
@end
