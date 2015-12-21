//
//  NSString+Extension.h
//  
//
//  Created by hhw on 15/11/12.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Extension)
+ (CGFloat)textWidthWithString:(NSString *)text Font:(UIFont *)font;
+ (CGFloat)textHeighWithString:(NSString *)text Font:(UIFont *)font Width:(CGFloat)width;
+ (CGFloat)textHeighWithString:(NSString *)text Font:(UIFont *)font;
/** 获取时间点的输出 */
+ (NSString *)dateDescWithDate:(NSString *)dateStr DateFormat:(NSString *)format;
@end
