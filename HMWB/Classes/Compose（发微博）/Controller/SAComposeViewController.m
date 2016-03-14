//
//  SAComposeViewController.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/1.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAComposeViewController.h"
#import "SAAccountTool.h"
#import "SAEmotionTextView.h"
#import "SAHttpTool.h"
#import "MBProgressHUD+MJ.h"
#import "SAComposeToolbar.h"
#import "SAComposePhotosView.h"
#import "SAEmotionKeyboard.h"
#import "SAEmotion.h"


@interface SAComposeViewController () <UITextViewDelegate , SAComposeToolbarDelegate , UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/** 输入控件*/
@property (nonatomic , weak) SAEmotionTextView * textView;
/** 键盘的工具条*/
@property (nonatomic , weak) SAComposeToolbar * toolBar;
/** 相册（存放选中的图片）*/
@property (nonatomic , weak) SAComposePhotosView * photosView;
/** 表情键盘*/
@property (nonatomic , strong) SAEmotionKeyboard * emotionkeyboard;
/** 是否正在切换键盘*/
@property (nonatomic , assign) BOOL switchingKeybaord;
@end



@implementation SAComposeViewController

#pragma mark - 懒加载方法
- (SAEmotionKeyboard *)emotionkeyboard {
    if (_emotionkeyboard == nil) {
        _emotionkeyboard = [[SAEmotionKeyboard alloc]init];
        _emotionkeyboard.width = self.view.width;
        _emotionkeyboard.height = 258;
    }
    return _emotionkeyboard;
}

#pragma mark - 系统方法

/**
 * 创建时调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化导航栏内容
    [self settupNav];
    
    //添加输入控件
    [self setupTextView];
    
    //添加工具条
    [self setupToolBar];
    
    //添加相册
    [self setupPhotoView];
    
    //设置输入的边距
    //self.automaticallyAdjustsScrollViewInsets;
}

/**
 * 类销毁时调用
 */
- (void)dealloc{
    [SANotificationCenter removeObserver:self];
}


#pragma mark - 初始化方法

/**
 * 添加相册
 */
- (void)setupPhotoView{
    SAComposePhotosView *PhotoView = [[SAComposePhotosView alloc] init];
    PhotoView.width = self.view.width;
    PhotoView.height = self.view.height;
    PhotoView.y = 100;
    [self.textView addSubview:PhotoView];
    _photosView = PhotoView;
}

/**
 * 初始化导航栏内容
 */
- (void)settupNav{
    //设置发送界面的按钮
    self.view.backgroundColor  = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    //设置发送界面的文字
    NSString *name = [SAAccountTool account].name;
    NSString *prefix = @"发微博";
    if (name) {
        UILabel *titleView = [[UILabel alloc] init];
        titleView.width = 200;
        titleView.height = 44;
        titleView.textAlignment = NSTextAlignmentCenter;//文字居中
        titleView.numberOfLines = 0;//自动换行
        //设置文字内容
        NSString *name = [SAAccountTool account].name;
        
        NSString *str = [NSString stringWithFormat:@"%@\n%@",prefix,name];
        //创建一个带有属性的字符串（比如颜色属性、字体属性）
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str ];
        //添加属性
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[str rangeOfString:prefix]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
        //添加到Text
        titleView.attributedText = attrStr;
        self.navigationItem.titleView = titleView;
    }
    else{
        self.title = prefix;
    }
    
}

/**
 * 添加输入控件
 */
- (void)setupTextView{
    SAEmotionTextView *textView = [[SAEmotionTextView alloc] init];
    textView.alwaysBounceVertical = YES; //垂直方向始终有弹簧效果
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:15];
    textView.delegate = self;
    textView.placeholder = @"分享你的新鲜事...";
    //textView.attributedText = ;

    
    //textView.placeholderColor = [UIColor redColor];
    [self.view addSubview:textView];
    _textView = textView;
    
    //文字改变通知
    [SANotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    //键盘通知
    [SANotificationCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //表情选中的通知
    [SANotificationCenter addObserver:self selector:@selector(emotionDidSelect:) name:@"SAEmotionDidSelectNotification" object:nil];
    
    //删除文字的通知
    [SANotificationCenter addObserver:self selector:@selector(emotionDidDelete) name:@"SAEmotionDidDeleteNotification" object:nil];
    
    //键盘的frame发生改变就会调用（位置和尺寸）
    //    UIKeyboardWillChangeFrameNotification;
    //    UIKeyboardDidChangeFrameNotification;
    //键盘显示就会调用（位置和尺寸）
    //    UIKeyboardWillShowNotification;
    //    UIKeyboardWillHideNotification;
    //键盘隐藏就会调用（位置和尺寸）
    //    UIKeyboardDidHideNotification;
    //    UIKeyboardDidShowNotification;
}

/**
 * 加载完View后调用
 */
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    // 成为第一响应者(能输入文本的控件一旦成为第一响应者，就会叫出相应的键盘
    [self.textView becomeFirstResponder];
}


/**
 * 添加工具条
 */
- (void)setupToolBar{
    SAComposeToolbar *toolbar = [[SAComposeToolbar  alloc]init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.y = self.view.height - toolbar.height;
    _toolBar = toolbar;
    toolbar.delegate = self;
    [self.view addSubview:toolbar];
    //inpuAccessoryView设置显示在键盘顶部的内容
    //self.textView.inputAccessoryView = toolbar;
    //inputView设置键盘
    // self.textView.inputView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
}


#pragma mark - 监听方法

/**
 * 表情删除按钮点击
 */
- (void)emotionDidDelete {
    //删除文字内容
    [self.textView deleteBackward];
}

/**
 *  表情按钮点击
 */
- (void)emotionDidSelect:(NSNotification *)notification {
    SAEmotion *emotion =  notification.userInfo[@"selectedEmotion"];
   
    [self.textView insertEmotion:emotion];
}

/**
 * 监听键盘改变
 */
- (void) keyboardWillChangeFrame:(NSNotification *)notification{
 
    if (self.switchingKeybaord) return;
    
    //取出包含键盘的字典
    NSDictionary *userInfo = notification.userInfo;
    
    //键盘弹出\隐藏所费的时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];//因为是包装过的，所以用Value转回来。
    //键盘弹出后的Frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //工具条的动画
    [UIView animateWithDuration:duration animations:^{
        //设置工具条的位置，随键盘变化
        self.toolBar.y = keyboardF.origin.y - self.toolBar.height;
    }];
    
    /**
     //键盘弹出后的Frame
     UIKeyboardFrameEndUserInfoKey = NSRrct:{{0,352},{320,216}},
     //键盘弹出\隐藏所费的时间
     UIKeyboardAnimationDurationUserInfoKey = 0.25,
     //键盘弹出\隐藏动画的执行节奏
     UIKeyboardAnimationCurveUserInfoKey,
     */
}

/**
 * 监听文字改变
 */
- (void)textDidChange{
    //设置发送按钮是否可以点击
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

/**
 * 监听取消按钮
 */
- (void)cancel{
    //返回视图控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 * 监听发送按钮
 */
- (void)send{
    
    if (self.photosView.photos.count) {
        [self sendWithImage];
    }
    else{
        [self sendWithOutImage];
    }

    //4.退出弹出界面
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)sendWithImage{
    
    //2.拼接请求参数
    SAAccount *accout = [SAAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = accout.access_token;
    params[@"status"] = self.textView.text;
    
    [SAHttpTool post:@"https://upload.api.weibo.com/2/statuses/upload.json" params:params success:^(id json) {
        SALog(@"发送微博成功（图片）");
        [MBProgressHUD showSuccess:@"发送成功"];

    } failure:^(NSError *error) {
        SALog(@"发送微博失败（图片）——%@",error);
        [MBProgressHUD showError:@"发送失败"];
    }];
}


- (void)sendWithOutImage{
    

    
    //2.拼接请求参数
    
    SAAccount *accout = [SAAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = accout.access_token;
    params[@"status"] = self.textView.fullText;
    
    //发送请求
    [SAHttpTool post:@"https://api.weibo.com/2/statuses/update.json" params:params success:^(id json) {
        SALog(@"发送微博成功");
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        SALog(@"发送微博失败（——%@",error);
        [MBProgressHUD showError:@"发送失败"];
    }];
}

#pragma mark - 代理方法

/**
 * imagePickerController选择完图片后调用（拍照完毕或选择相册图片完毕）
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //选择完图片返回原控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //添加图片到photoView中
    [self.photosView addPhoto:image];
}

/**
 * UITextViewDelegate代理方法
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

/**
 * SAComposeToolbarDelegate代理方法
 */
- (void)composeToolbar:(SAComposeToolbar *)toolbar didClickButton:(SAComposeToolbarButtonType)buttonType{
    switch (buttonType) {
        case SAComposeToolbarButtonTypeCamera:
            [self openCamera];//拍照
            break;
        case SAComposeToolbarButtonTypePicture:
            [self openAlbum];//相册
            break;
        case SAComposeToolbarButtonTypeMention:
            //@
            break;
        case SAComposeToolbarButtonTypeTrend:
            //#
            break;
        case SAComposeToolbarButtonTypeEmotion:
            [self switchKeyboard]; //表情/键盘
            break;
    }
}


#pragma mark - 工具条按钮方法

/**
 * 拍照
 */
- (void)openCamera{
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
    
  
}

/**
 *  相册
 */
- (void)openAlbum{
    //如果想自己写个图片选择器，得利用AssetsLibrary.framework,利用这个框架可以获得手机上所有相册图片
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}

/**
 * 调用UIImagePickerController(拍照/相册抽出来的）
 */
- (void)openImagePickerController:(UIImagePickerControllerSourceType)type{
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil ];
}

/**
 * 切换键盘
 */
- (void)switchKeyboard{

    if (self.textView.inputView == nil ) {//系统键盘
        self.textView.inputView = self.emotionkeyboard;
        self.toolBar.ShowKeyboardButton = YES;
    }
    else{//表情键盘
        self.textView.inputView = nil;
        self.toolBar.ShowKeyboardButton = NO;
    }
    
    //开始切换键盘
    self.switchingKeybaord = YES;

    //退出键盘
    [self.textView endEditing:YES];
    
    //结束
    self.switchingKeybaord = NO;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //弹出键盘
        [self.textView becomeFirstResponder];
        
        //结束
        self.switchingKeybaord = NO;
    });
 
}







@end
