//
//  ViewController.h
//  ThirdSDKDemo
//
//  Created by Aelop on 15/12/25.
//  Copyright © 2015年 com.aelop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *UserInfo;

- (IBAction)ClickShareButton:(id)sender;


- (IBAction)ClickLogButton:(id)sender;

- (IBAction)CancelAuth:(id)sender;

@end

