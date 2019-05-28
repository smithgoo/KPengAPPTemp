//
//  NSString+custom.m
//  ugo
//
//  Created by tokee on 15/8/28.
//  Copyright (c) 2015年 tokee. All rights reserved.
//

#import "NSString+custom.h"

@implementation NSString (custom)

- (NSString *)transformToPinyin {
    NSMutableString *mutableString = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    return mutableString;
}

@end
