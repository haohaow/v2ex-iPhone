//
//  WHMacros.h
//  NGA-iPhone
//
//  Created by hhw on 15/10/18.
//  Copyright (c) 2015年 wuhao. All rights reserved.
//

#ifndef NGA_iPhone_WHMacros_h
#define NGA_iPhone_WHMacros_h

// RGB颜色
#define WHColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define WHRandomColor WHColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#ifdef DEBUG
#define WHLog(...) NSLog(__VA_ARGS__)
#else
#define WHLog(...)
#endif

//api url
#define API_SITEINFO @"api/site/info.json"

#endif
