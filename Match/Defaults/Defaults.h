//
//  Defaults.h
//  Waistcoat
//
//  Created by zhy on 2017/9/14.
//  Copyright © 2017年 zhy. All rights reserved.
//

#ifndef Defaults_h
#define Defaults_h

#ifdef DEBUG
#define FxLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define FxLog(...)
#endif

#define MainColor RGB(255,128,0)

#define KJPUSHKEY @"00f477e0a4f38f9752d1c852"

#define kDeviceWidth [UIScreen mainScreen].bounds.size.width

#define KDeviceHeight [UIScreen mainScreen].bounds.size.height

#define isIPhoneX (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 812)

#define kStatusBarHeight     (isIPhoneX ? 44 : 20)
#define kNavigationBarHeight self.navigationController.navigationBar.frame.size.height
#define kHomeBarHeight       (isIPhoneX ? 34 : 0)
#define kTabBarHeight       49

#define SharedApp ((AppDelegate*)[[UIApplication sharedApplication] delegate])

#define RGBA(r,g,b,a)      [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define KNickName  @"nickName"
#define KPassword  @"password"
#define KStatus    @"status"
#define KDefautKey @"user"
#define MainUrl  @"MainUrl"

#endif /* Defaults_h */
