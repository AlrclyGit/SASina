//
//  SADropdownMenu.h
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/18.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import <UIKit/UIKit.h>


//设置代理
@class SADropdownMenu;

@protocol SADropdownMenuDelegate <NSObject>

@optional
//显示时调用
- (void)DropdownMenuDidShow:(SADropdownMenu *)menu;
//销毁时调用
- (void)DropdownMenuDidDismiss:(SADropdownMenu *)menu;
@end



@interface SADropdownMenu : UIView

/**
 *设置代理
 */
@property (nonatomic,weak) id<SADropdownMenuDelegate> delegate;

/**
  *下拉菜单
  */

+ (instancetype)menu;

/**
 *显示
 */
- (void)showFrom:(UIView *)from;

/**
 *销毁
 */
- (void)dismiss;

/**
 *传入的Veiw
 */
@property (nonatomic,strong) UIView *content;

/**
 *传入View控制器
 */
@property (nonatomic,strong) UIViewController *contentController;
@end
