# AnimationDemo
<img src="https://github.com/yuhuans/AnimationDemo/blob/master/animation.gif" width="208" height="369" />

目前支持设置分支个数，暂时只支持偶数分支
```
    _animationView=[[AnimationView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    _animationView.branchCount=2;
    _animationView.center=self.view.center;
    [self.view addSubview:_animationView];
```