//
//  MediaAttachmentHelper.m
//  KeyBoardView
//
//  Created by 余强 on 16/3/28.
//  Copyright © 2016年 你好，我是余强，一位来自上海的ios开发者，现就职于bdcluster(上海大数聚科技有限公司)。这个工程致力于完成一个优雅的IM实现方案，如果您有兴趣，请来到项目交流群：533793277. All rights reserved.
//

#import "MediaAttachmentHelper.h"
#import "CacheHelper.h"
#import "UIImage+Addition.h"


#define KImageScale 0.9
@implementation MediaAttachmentHelper


+ (instancetype)helper
{
    static dispatch_once_t onceToken;
    static MediaAttachmentHelper * helper = nil;
    dispatch_once(&onceToken, ^{
        helper = [[self alloc]init];
    });
    return helper;
}


- (void)imageHandle:(NSData *)data completionCache:(void(^)(NSString *))completionCache
{
  //doSth
    
    
    UIImage *image = [UIImage ThumbnailWithImage:[UIImage imageWithData:data] scale:KImageScale];
    NSData *handleImageData = UIImageJPEGRepresentation(image, 1);
    
    
       [[CacheHelper helper]saveMediaTypeWithMediaType:MessageBodyTypePhoto FileData:handleImageData completion:^(NSString *mediaPath) {
       
         completionCache ? completionCache(mediaPath) :nil;
        
    }];
    
    
}

- (void)audioHandle:(NSData *)data completionCache:(void(^)(NSString *))completionCache
{
    //doSth
    [[CacheHelper helper]saveMediaTypeWithMediaType:MessageBodyTypeVoice FileData:data completion:^(NSString *mediaPath) {
       
          completionCache ? completionCache(mediaPath) :nil;
        
    }];
}

- (void)videoHandle:(NSData *)data  completionCache:(void(^)(NSString *videoPath,NSString *videoThumbPath))completionCache
{
    //doSth
    
    
    //先存视频，
     [[CacheHelper helper]saveMediaTypeWithMediaType:MessageBodyTypeVideo FileData:data completion:^(NSString *videoPath) {
         
         UIImage *thumbImage = [UIImage VideoThumbImage:[NSURL fileURLWithPath:videoPath]];
         
        UIImage *mergeImage = [UIImage addImage:thumbImage addMsakImage:[NSBundle imageWithBundle:BundleName imageName:@"play@2x"] maskRect:CGRectMake(thumbImage.size.width/2-45, thumbImage.size.height/2-45, 90, 90)];
         
         //再存视频缩略图
         [[CacheHelper helper]saveMediaTypeWithMediaType:MessageBodyTypePhoto FileData:UIImageJPEGRepresentation(mergeImage, 1) completion:^(NSString *videoThumbPath) {
             
             completionCache ? completionCache(videoPath,videoThumbPath) : nil;
         }];
     }];
   
}


@end
