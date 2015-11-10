//
//  WHMemberModel.h
//  
//
//  Created by hhw on 15/11/10.
//
//

#import <Foundation/Foundation.h>

@interface WHMemberModel : NSObject

@property (nonatomic,copy) NSString *memberId;
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *tagline;
@property (nonatomic,copy) NSString *avatar_mini;
@property (nonatomic,copy) NSString *avatar_normal;
@property (nonatomic,copy) NSString *avatar_large;

@end
