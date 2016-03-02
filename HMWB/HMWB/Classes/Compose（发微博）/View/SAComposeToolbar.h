//
//  SAComposeToolbar.h
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/2.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SAComposeToolbarButtonTypeCamera,   //拍照
    SAComposeToolbarButtonTypePicture,  // 相册
    SAComposeToolbarButtonTypeMention,  //@
    SAComposeToolbarButtonTypeTrend,    //#
    SAComposeToolbarButtonTypeEmotion //表情
}SAComposeToolbarButtonType;

@class SAComposeToolbar;

@protocol  SAComposeToolbarDelegate <NSObject>
@optional
- (void)composeToolbar:(SAComposeToolbar *)toolbar didClickButton:(SAComposeToolbarButtonType)buttonType;
@end

@interface SAComposeToolbar : UIView
@property (nonatomic, weak) id<SAComposeToolbarDelegate>delegate;
@end
