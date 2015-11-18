//
//  ViewController.m
//  HandGesture
//
//  Created by Augus on 15/10/10.
//  Copyright © 2015年 Augus_LWH. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *testView;
@property (strong, nonatomic) IBOutlet UILongPressGestureRecognizer *longPressG;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //点击手势
    UITapGestureRecognizer * tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    [self.testView addGestureRecognizer:tapG];
    tapG.numberOfTapsRequired = 2;
    tapG.numberOfTouchesRequired = 1;
    
    UITapGestureRecognizer * tapG3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture3:)];
    [self.testView addGestureRecognizer:tapG3];
    tapG3.numberOfTapsRequired = 3;
    tapG3.numberOfTouchesRequired = 1;
    //当点击3次手势失败时才去调用点击两次手势
    [tapG requireGestureRecognizerToFail:tapG3];
    
    //长按手势
    UILongPressGestureRecognizer * longPG = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(tapLongG:)];
    [self.testView addGestureRecognizer:longPG];
    longPG.minimumPressDuration = 2;
    
    //捏合手势
    UIPinchGestureRecognizer * pinchG = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(tapPinchG:)];
    [self.testView addGestureRecognizer:pinchG];
    
    //旋转手势
    UIRotationGestureRecognizer * rotationG = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(tapRotationG:)];
    [self.testView addGestureRecognizer:rotationG];
    
    //拖动手势
    UIPanGestureRecognizer * panG = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(tapPanG:)];
    [self.testView addGestureRecognizer:panG];
    
    //轻扫手势
    UISwipeGestureRecognizer * swipeG = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(tapSwipeG:)];
    [self.testView addGestureRecognizer:swipeG];
    
    //开启当前App的shake
    [[UIApplication sharedApplication]setApplicationSupportsShakeToEdit:YES];
    
}

//摇动回调
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    self.testView.backgroundColor = [UIColor orangeColor];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    self.testView.backgroundColor = [UIColor greenColor];
}

//点击手势方法
- (void)tapGesture:(UITapGestureRecognizer *)tapG
{
    NSLog(@"dianji");
    UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"hehe"];
    [self showViewController:vc sender:nil];
}

- (void)tapGesture3:(UITapGestureRecognizer *)tapG
{
    UIView * view = tapG.view;
    view.backgroundColor = [UIColor redColor];
}

//长按手势
- (void)tapLongG:(UILongPressGestureRecognizer *)longG
{
    if (longG.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"开始录音！");
    }else if (longG.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"发送录音！");
    }
}

//捏合手势
- (void)tapPinchG:(UIPinchGestureRecognizer *)pinchG
{
    NSLog(@"捏合");
    UIView * view = pinchG.view;
    if (pinchG.state == UIGestureRecognizerStateBegan || pinchG.state == UIGestureRecognizerStateChanged)
    {
        view.transform = CGAffineTransformMakeScale(pinchG.scale, pinchG.scale);
    }
}

//旋转手势
- (void)tapRotationG:(UIRotationGestureRecognizer *)rotationG
{
    NSLog(@"旋转");
    UIView * view = rotationG.view;
    if (rotationG.state == UIGestureRecognizerStateBegan || rotationG.state == UIGestureRecognizerStateChanged)
    {
        view.transform = CGAffineTransformMakeRotation(rotationG.rotation);
    }
}

//拖动手势
- (void)tapPanG:(UIPanGestureRecognizer *)panG
{
    NSLog(@"拖动");
    
    UIView * view = panG.view;
    if (panG.state == UIGestureRecognizerStateChanged  || panG.state == UIGestureRecognizerStateBegan)
    {
        CGPoint translate = [panG translationInView:view.superview];
//        NSLog(@"%@",NSStringFromCGPoint(translate));
        [view setCenter:CGPointMake(view.center.x + translate.x, view.center.y + translate.y)];
        [panG setTranslation:CGPointZero inView:view.superview];
    }
}

//轻扫手势
- (void)tapSwipeG:(UISwipeGestureRecognizer *)swipeG
{
    NSLog(@"轻扫");
}

- (IBAction)tapLobgPressG:(id)sender
{
    NSLog(@"长按");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
