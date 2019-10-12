//
//  ViewController.m
//  图片动效
//
//  Created by 张冲 on 2018/1/26.
//  Copyright © 2018年 张冲. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
 @interface ViewController ()
{
    UIImageView *imageview1;
}
@property(nonatomic,strong)CMMotionManager *motionManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 //   [self useGyroPush];
//    [self sssss];

    NSMutableArray *array = [NSMutableArray array]
    NSLog(@"array.cout = %d",array.count);

    if (array.count > 0) {
        NSLog(@"123");
    }



//    imageview1 = [[UIImageView alloc]initWithFrame:CGRectMake(100,100, 200, 200)];
//    imageview1.backgroundColor = [UIColor yellowColor];
//    imageview1.contentMode = UIViewContentModeScaleAspectFit;
//    imageview1.layer.anchorPoint = CGPointMake(0.5f,0.0f);//围绕点
//
//    [imageview1 setImage:[UIImage imageNamed:@"灯笼-金0001.png"]];
//    [self.view addSubview:imageview1];
    /*
    NSMutableArray *imageArray = [NSMutableArray array];
    for (NSInteger i = 1; i< 11; i ++) {
        NSString *imageString = [NSString stringWithFormat:@"%.4ld",(long)i];
        NSLog(@"imageString = %@",imageString);
        UIImage *image = [UIImage imageNamed:imageString];
        [imageArray addObject:image];

        NSLog(@"imageArray .cout = %lu",(unsigned long)imageArray.count);
        if (imageArray.count == 10) {
                [self startAnimal:imageArray];

        }
    }



    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageView1tap:)];
    [imageview1 addGestureRecognizer:tap];
//    imageview1.userInteractionEnabled = YES;
    // Do any additional setup after loading the view, typically from a nib.
     */
}
- (void)sssss{
     self.motionManager = [CMMotionManager new];
    if ([self.motionManager isAccelerometerAvailable]) {
        NSLog(@"可用");
    }
    if ([self.motionManager isAccelerometerActive] == NO) {
        [self.motionManager startAccelerometerUpdates];
    }

    //判断加速度计可不可用，判断加速度计是否开启
    if ([self.motionManager isAccelerometerAvailable] ){
        //告诉manager，更新频率是100Hz
        self.motionManager.accelerometerUpdateInterval = 0.02;
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        //Push方式获取和处理数据
        [self.motionManager startAccelerometerUpdatesToQueue:queue
                                      withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
         {
             double x = accelerometerData.acceleration.x;
             NSLog(@"x = %.4f",x);
             if (x >= 0) {
                 NSInteger i =  x*100/10;
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [UIView animateWithDuration:0.5 animations:^{
                         imageview1.layer.transform = CATransform3DMakeRotation(i*-M_PI*0.1,0,0,1);
                     }];
                });
             }else if (x < 0){
                 NSInteger j = -x * 100 /10;
                  dispatch_async(dispatch_get_main_queue(), ^{
                     [UIView animateWithDuration:0.5 animations:^{
                         imageview1.layer.transform = CATransform3DMakeRotation(j*M_PI*0.1,0,0,1);
                     }];
                 });
             }

         }];
    }
}
- (void)useGyroPush{
    //初始化全局管理对象
    CMMotionManager *manager = [[CMMotionManager alloc] init];
    self.motionManager = manager;
     //判断陀螺仪可不可以，判断陀螺仪是不是开启
    if ([manager isGyroAvailable] && [manager isGyroActive]){

        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        //告诉manager，更新频率是100Hz
        manager.gyroUpdateInterval = 0.01;
        //Push方式获取和处理数据
        [manager startGyroUpdatesToQueue:queue
                             withHandler:^(CMGyroData *gyroData, NSError *error)
         {
             NSLog(@"Gyro Rotation x = %.04f", gyroData.rotationRate.x);
             NSLog(@"Gyro Rotation y = %.04f", gyroData.rotationRate.y);
             NSLog(@"Gyro Rotation z = %.04f", gyroData.rotationRate.z);
         }];
    }
}

- (void)startAnimal:(NSMutableArray *)imageArray{

    NSLog(@"imageArray = %@",imageArray);
     imageview1.animationImages = [NSArray arrayWithArray:imageArray];
    NSLog(@"imageview1.animationImages = %@",imageview1.animationImages);
    imageview1.animationDuration = 8.0;
    imageview1.animationRepeatCount = 1;
    [imageview1 startAnimating];


}
- (void)imageView1tap:(UITapGestureRecognizer *)tap{

    NSLog(@"图片点击");

    //第二个
 //   [self headPhotoAnimation];

    //第一个
//    CABasicAnimation *rotationAnimation;
//    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI ];
//    rotationAnimation.duration = 1.0;
//    rotationAnimation.cumulative = YES;
//    rotationAnimation.repeatCount = 3.0;
//    [imageview1.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];

//    //福到啦
//    [UIView animateWithDuration:2.0 animations:^{
//        imageview1.layer.affineTransform =  CGAffineTransformMakeRotation(M_PI);
//
//    }];


}

- (void)headPhotoAnimation
{
   [self rotate360WithDuration:2.0 repeatCount:1];
    imageview1.animationDuration = 2.0;

    // 图片数组
    imageview1.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"123.jpg"],
                                      [UIImage imageNamed:@"123.jpg"],[UIImage imageNamed:@"1.jpg"],
                                      [UIImage imageNamed:@"1.jpg"],[UIImage imageNamed:@"123.jpg"],
                                      [UIImage imageNamed:@"123.jpg"], nil];
    imageview1.animationRepeatCount = 1;
    [imageview1 startAnimating];
}

- (void)rotate360WithDuration:(CGFloat)aDuration repeatCount:(CGFloat)aRepeatCount
{
    CAKeyframeAnimation *theAnimation = [CAKeyframeAnimation animation];

    // 旋转角度， 多一个重复的旋转，配合重复的图片，可以看到有一个停留的效果
    theAnimation.values = [NSArray arrayWithObjects:
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0,1,0)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0,1,0)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(2*M_PI, 0,1,0)],
                           nil];
    theAnimation.cumulative = YES;
    theAnimation.duration = aDuration;
    theAnimation.repeatCount = aRepeatCount;
    theAnimation.removedOnCompletion = YES;

    [imageview1.layer addAnimation:theAnimation forKey:@"transform"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
