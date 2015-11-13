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
+ (CGFloat)getTextWidthWithString:(NSString *)text Font:(UIFont *)font;
+ (CGFloat)getTextHeighWithString:(NSString *)text Font:(UIFont *)font Width:(CGFloat)width;
+ (CGFloat)getTextHeighWithString:(NSString *)text Font:(UIFont *)font;

@end
