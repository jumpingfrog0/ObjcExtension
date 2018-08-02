// SDImageCache+MZDLocalPathCacheSupport.m
// Pods
//
// Created by sheldon on 2018/6/28.
//

#import "SDImageCache+MZDLocalPathCacheSupport.h"
#import <objc/runtime.h>

NSString *kMZDSDWebCacheLocalhost = @"mzdwebimage://localhost";

@implementation SDImageCache (MZDLocalPathCacheSupport)

+ (void)load
{
    SEL originalSelector = @selector(defaultCachePathForKey:);
    SEL swizzledSelector = @selector(jf_defaultCachePathForKey:);
    
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    
    BOOL result = class_addMethod(self,
                                  originalSelector,
                                  method_getImplementation(swizzledMethod),
                                  method_getTypeEncoding(swizzledMethod));
    
    if (result) {
        class_replaceMethod(self,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (NSString *)jf_defaultCachePathForKey:(NSString *)key
{
    if ([key hasPrefix:kMZDSDWebCacheLocalhost]) {
        return [key stringByReplacingOccurrencesOfString:kMZDSDWebCacheLocalhost withString:@""];
    }
    else {
        return [self jf_defaultCachePathForKey:key];
    }
}

- (void)jf_storeImage:(UIImage *)image forPath:(NSString *)path
{
    [self jf_storeImage:image recalculateFromImage:YES imageData:nil forPath:path toDisk:YES];
}

- (void)jf_storeImage:(UIImage *)image forPath:(NSString *)path toDisk:(BOOL)toDisk
{
    [self jf_storeImage:image recalculateFromImage:YES imageData:nil forPath:path toDisk:toDisk];
}

- (void)jf_storeImage:(UIImage *)image recalculateFromImage:(BOOL)recalculate imageData:(NSData *)imageData forPath:(NSString *)path toDisk:(BOOL)toDisk
{
    NSURL *url = [NSURL URLWithString:kMZDSDWebCacheLocalhost];
    url = [url URLByAppendingPathComponent:path];
    [self storeImage:image recalculateFromImage:recalculate imageData:imageData forKey:url.absoluteString toDisk:toDisk];
}

- (void)jf_storeImageDataToDisk:(NSData *)imageData forPath:(NSString *)path
{
    if (!imageData) {
        return;
    }
    
    Ivar var =  class_getInstanceVariable(SDImageCache.class, "_fileManager");
    NSFileManager *fileManager = (NSFileManager *)object_getIvar(self, var);
    
    NSURL *url = [NSURL URLWithString:kMZDSDWebCacheLocalhost];
    url = [url URLByAppendingPathComponent:path];
    
    // defaultCachePathForKey 方法被替换为返回 path 路径
    NSString *cachePathForKey = [self defaultCachePathForKey:url.absoluteString];
    NSString *cacheDirectory = [cachePathForKey stringByDeletingLastPathComponent];
    if (![fileManager fileExistsAtPath:cacheDirectory]) {
        [fileManager createDirectoryAtPath:cacheDirectory withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    
    [fileManager createFileAtPath:cachePathForKey contents:imageData attributes:nil];
}

- (UIImage *)jf_imageFromMemoryCacheForPath:(NSString *)path
{
    NSURL *url = [NSURL URLWithString:kMZDSDWebCacheLocalhost];
    url = [url URLByAppendingPathComponent:path];
    return [self imageFromMemoryCacheForKey:url.absoluteString];
}

- (UIImage *)jf_imageFromDiskCacheForPath:(NSString *)path
{
    NSURL *url = [NSURL URLWithString:kMZDSDWebCacheLocalhost];
    url = [url URLByAppendingPathComponent:path];
    return [self imageFromDiskCacheForKey:url.absoluteString];
}

- (void)jf_removeImageForPath:(NSString *)path
{
    [self jf_removeImageForPath:path withCompletion:nil];
}

- (void)jf_removeImageForPath:(NSString *)path withCompletion:(MZDSDWebImageNoParamsBlock)completion
{
    [self jf_removeImageForPath:path fromDisk:YES withCompletion:completion];
}

- (void)jf_removeImageForPath:(NSString *)path fromDisk:(BOOL)fromDisk
{
    [self jf_removeImageForPath:path fromDisk:fromDisk withCompletion:nil];
}

- (void)jf_removeImageForPath:(NSString *)path fromDisk:(BOOL)fromDisk withCompletion:(MZDSDWebImageNoParamsBlock)completion
{
    NSURL *url = [NSURL URLWithString:kMZDSDWebCacheLocalhost];
    url = [url URLByAppendingPathComponent:path];
    [self removeImageForKey:url.absoluteString fromDisk:fromDisk withCompletion:completion];
}

@end
