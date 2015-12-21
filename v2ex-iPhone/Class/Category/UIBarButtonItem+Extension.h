//  UIBarButtonItem+Extension.h

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image handler:(void(^)(id sender))action;
@end
