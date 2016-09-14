//
//  JSMModel.h
//  Demos
//
//  Created by ShenYj on 16/9/14.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSMModel : NSObject

/**
 *  图片名称
 */
@property (nonatomic,copy) NSString *image;
/**
 *  歌曲名称(展示名称)
 */
@property (nonatomic,copy) NSString *name;
/**
 *  歌手名称
 */
@property (nonatomic,copy) NSString *singer;
/**
 *  歌曲完整名称(设置歌曲时使用)
 */
@property (nonatomic,copy) NSString *mp3;


@end
