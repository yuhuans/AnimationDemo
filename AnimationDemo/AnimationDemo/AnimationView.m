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
        [self setUp];
    }
    return self;
}
-(void)setUp{
    for (int i=0 ; i<6; i++) {
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
    for (int i=0 ; i<6; i++) {
        UIView *view=[self viewWithTag:100+i];
    
        CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnima.fromValue = [NSNumber numberWithFloat:1.0f];
        scaleAnima.toValue = [NSNumber numberWithFloat:distance/KOriginalR];
        
        CABasicAnimation *positionAnima = [CABasicAnimation animationWithKeyPath:@"position"];
        positionAnima.fromValue = [NSValue valueWithCGPoint:view.center];

        if (i==0) {
            positionAnima.toValue = [NSValue valueWithCGPoint:CGPointMake(view.center.x+distance/2, view.layer.position.y-(distance*(sqrt (3)/2)))];
        }else if (i==1) {
            positionAnima.toValue = [NSValue valueWithCGPoint:CGPointMake(view.center.x-distance/2, view.layer.position.y-(distance*(sqrt (3)/2)))];
        }else if (i==3) {
            positionAnima.toValue = [NSValue valueWithCGPoint:CGPointMake(view.center.x-distance, view.layer.position.y)];
        }
        else if (i==4) {
            positionAnima.toValue = [NSValue valueWithCGPoint:CGPointMake(view.center.x-distance/2, view.layer.position.y+(distance*(sqrt (3)/2)))];
        }else if (i==5) {
            positionAnima.toValue = [NSValue valueWithCGPoint:CGPointMake(view.center.x+distance/2, view.layer.position.y+(distance*(sqrt (3)/2)))];
        }else{
            positionAnima.toValue = [NSValue valueWithCGPoint:CGPointMake(view.center.x+distance,view.layer.position.y)];
        }
        
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
@end
