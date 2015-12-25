//
//  ViewController.m
//  ThirdSDKDemo
//
//  Created by Aelop on 15/12/25.
//  Copyright © 2015年 com.aelop. All rights reserved.
//

#import "ViewController.h"
#import <ShareSDK/ShareSDK.h>
@interface ViewController ()
{

    ShareType type;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ClickShareButton:(id)sender {
    
    UIAlertController *alvc=[UIAlertController alertControllerWithTitle:@"选择登陆" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *sina=[UIAlertAction actionWithTitle:@"新浪微博" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        type=ShareTypeSinaWeibo;
        [self share];
    }];
    UIAlertAction *qq=[UIAlertAction actionWithTitle:@"QQ空间" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        type=ShareTypeQQSpace;
        [self share];
    }];
    UIAlertAction *wx=[UIAlertAction actionWithTitle:@"微信朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        type=ShareTypeWeixiTimeline;
        [self share];
    }];
    UIAlertAction *twitter=[UIAlertAction actionWithTitle:@"Twitter" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        type=ShareTypeTwitter;
        [self share];
    }];
    UIAlertAction *facebook=[UIAlertAction actionWithTitle:@"Facebook" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        type=ShareTypeFacebook;
        [self share];
    }];
    
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        type=ShareTypeFacebook;
       
    }];
    [alvc addAction:sina];
    [alvc addAction:wx];
    
    [alvc addAction:qq];
    
    [alvc addAction:twitter];
    [alvc addAction:facebook];
     [alvc addAction:cancel];
    [self presentViewController:alvc animated:YES completion:^{
        
        
           }];
    
    
}
-(void)share{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"res3" ofType:@"jpg"];
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享"
                                       defaultContent:@""
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"ShareSDK"
                                                  url:@"http://www.mob.com"
                                          description:NSLocalizedString(@"TEXT_TEST_MSG", @"这是一条测试信息")
                                            mediaType:SSPublishContentMediaTypeNews];
    
    
    [ShareSDK clientShareContent:publishContent
                            type:type
                   statusBarTips:YES
                          result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                              
                              if (state == SSPublishContentStateSuccess)
                              {
                                  NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功!"));
                              }
                              else if (state == SSPublishContentStateFail)
                              {
                                  NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败!"), [error errorCode], [error errorDescription]);
                              }
                          }];
    

    

}


- (IBAction)ClickLogButton:(id)sender {
    
    
    UIAlertController *alvc=[UIAlertController alertControllerWithTitle:@"选择登陆" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *sina=[UIAlertAction actionWithTitle:@"新浪微博" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        type=ShareTypeSinaWeibo;
        [self Auth];
    }];
    UIAlertAction *qq=[UIAlertAction actionWithTitle:@"QQ" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        type=ShareTypeQQSpace;
        [self Auth];
    }];
    UIAlertAction *wx=[UIAlertAction actionWithTitle:@"微信" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        type=ShareTypeWeixiSession;
        [self Auth];
    }];
    UIAlertAction *twitter=[UIAlertAction actionWithTitle:@"Twitter" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        type=ShareTypeTwitter;
        [self Auth];
    }];
    UIAlertAction *facebook=[UIAlertAction actionWithTitle:@"Facebook" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        type=ShareTypeFacebook;
        [self Auth];
    }];
    
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
     
        
    }];
    [alvc addAction:sina];
    [alvc addAction:wx];
    
    [alvc addAction:qq];
    
    [alvc addAction:twitter];
    [alvc addAction:facebook];
    [alvc addAction:cancel];
    [self presentViewController:alvc animated:YES completion:^{
        
        
    }];

    
}


-(void)Auth{

    
    //现授权
    
    [ShareSDK authWithType:type
                   options:nil
                    result:^(SSAuthState state, id<ICMErrorInfo> error) {
                        
                        switch (state)
                        {
                            case SSAuthStateBegan:
                                NSLog(@"begin to auth");
                                break;
                            case SSAuthStateSuccess:
                             
                                
                                //授权成功再登陆
                                [self login];

                                break;
 
                            case SSAuthStateCancel:
                            {
                                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"授权已取消" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                                [alert show];
                            }
                                break;
                            case SSAuthStateFail:
                            { UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"授权失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                                [alert show];
                            }
                                break;
                            default:
                                break;
                        }
                    }];

    
    
   
}

-(void)login{


    [ShareSDK getUserInfoWithType:type
                      authOptions:nil
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                               if (result)
                               {
                                   
                                   if (type==ShareTypeSinaWeibo) {
                                       self.UserInfo.text=[NSString stringWithFormat:@"%d登陆,用户名:%@",type,[[userInfo sourceData] objectForKey:@"name"]];
                                       
                                       NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:[[userInfo sourceData] objectForKey:@"avatar_hd"]]];
                                       [self.userIcon setImage:[UIImage imageWithData:imageData]];
                                   }
                                   else if(type==ShareTypeQQSpace){
                                   
                                       self.UserInfo.text=[NSString stringWithFormat:@"%d登陆,用户名:%@",type,[[userInfo sourceData] objectForKey:@"nickname"]];
                                       
                                       NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:[[userInfo sourceData] objectForKey:@"figureurl"]]];
                                       [self.userIcon setImage:[UIImage imageWithData:imageData]];
                                   
                                   }
                               
                               }
                               
                           }];
    
    

}



- (IBAction)CancelAuth:(id)sender {
    
    
    UIAlertController *alvc=[UIAlertController alertControllerWithTitle:@"取消授权" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *sina=[UIAlertAction actionWithTitle:@"新浪微博" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        type=ShareTypeSinaWeibo;
         [self logout];
    }];
    UIAlertAction *qq=[UIAlertAction actionWithTitle:@"QQ" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        type=ShareTypeQQSpace;
        [self logout];
    }];
    UIAlertAction *wx=[UIAlertAction actionWithTitle:@"微信" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        type=ShareTypeWeixiTimeline;
         [self logout];
       
    }];
    UIAlertAction *twitter=[UIAlertAction actionWithTitle:@"Twitter" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        type=ShareTypeTwitter;
         [self logout];
      
    }];
    UIAlertAction *facebook=[UIAlertAction actionWithTitle:@"Facebook" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        type=ShareTypeFacebook;
         [self logout];
        
    }];
    
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        type=ShareTypeFacebook;
         [self logout];
    }];
    [alvc addAction:sina];
    [alvc addAction:wx];
    
    [alvc addAction:qq];
    
    [alvc addAction:twitter];
    [alvc addAction:facebook];
    [alvc addAction:cancel];
    [self presentViewController:alvc animated:YES completion:^{
        
        
    }];
    

    
    

    
    
}

-(void)logout{
    
    //取消授权
    [ShareSDK cancelAuthWithType:type];

}











@end
