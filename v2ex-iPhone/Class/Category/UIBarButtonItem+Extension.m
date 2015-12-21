//  UIBarButtonItem+Extension.m

#import "UIBarButtonItem+Extension.h"
#import "UIControl+BlocksKit.h"
#import "UIView+Extension.h"

@implementation UIBarButtonItem (Extension)
/**
 *  创建一个item
 *  
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    if(highImage){
        [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    }
    // 设置尺寸
    btn.size = btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image handler:(void(^)(id sender))action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn bk_addEventHandler:^(id sender) {
        action(sender);
        [UIView animateWithDuration:0.2 animations:^{
            btn.alpha = 1.0;
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [btn bk_addEventHandler:^(id sender) {
        btn.alpha = 0.3;
    } forControlEvents:UIControlEventTouchDown];
    
    [btn bk_addEventHandler:^(id sender) {
        [UIView animateWithDuration:0.3 animations:^{
            btn.alpha = 1.0;
        }];
    } forControlEvents:UIControlEventTouchCancel|UIControlEventTouchUpOutside|UIControlEventTouchDragOutside];
    
    btn.size = btn.currentBackgroundImage.size;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}
@end
