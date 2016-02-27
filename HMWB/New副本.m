//获取最上面的窗口
//self.view.window == [UIApplication sharedApplication].keyWindow
//UIWindow *window = [UIApplication sharedApplication].keyWindow;
//建议使用[UIApplication sharedApplication].keyWindow 获得窗口
//以下方的方式获得的窗口，是当前最上面的窗口
UIWindow *window = [[UIApplication sharedApplication].windows lastObject];

//添加蒙板
UIView *cover = [[UIView alloc] init];
cover.backgroundColor = [UIColor clearColor];
cover.frame = window.bounds;
[window addSubview:cover];

//添加带箭头的灰色图片
UIImageView *dropdownMenu = [[UIImageView alloc]init];
dropdownMenu.image = [UIImage imageNamed:@"popover_background"];
dropdownMenu.userInteractionEnabled = YES;//开启交互功能
dropdownMenu. width = 217;
dropdownMenu.height = 300;

//将灰色图片添加到窗口
[cover addSubview:dropdownMenu];


//字符串转类
Class class = NSClassFromString(@"UIView");

//让a类与B类进行比较是否相同
[aaa isKindOfClass:bbb]