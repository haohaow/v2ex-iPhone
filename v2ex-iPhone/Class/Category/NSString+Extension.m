//
//  NSString+Extension.m
//  
//
//  Created by hhw on 15/11/12.
//
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
+ (CGFloat)getTextWidthWithString:(NSString *)text Font:(UIFont *)font
{
        NSDictionary *attributes = @{
                                     NSFontAttributeName: font,
                                     };
    CGRect textBounds = [text boundingRectWithSize:(CGSize){CGFLOAT_MAX, CGFLOAT_MAX}
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:attributes
                                                       context:nil];
    return CGRectGetWidth(textBounds);

}

+ (CGFloat)getTextHeighWithString:(NSString *)text Font:(UIFont *)font Width:(CGFloat)width
{
    NSDictionary *attributes = @{
                                 NSFontAttributeName: font,
                                 };
    CGRect textBounds = [text boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:attributes
                                           context:nil];

    return CGRectGetHeight(textBounds);
    
}

+ (CGFloat)getTextHeighWithString:(NSString *)text Font:(UIFont *)font
{
    return [self getTextHeighWithString:text Font:font Width:CGFLOAT_MAX];
}

@end
