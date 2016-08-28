//
//  JSAppsTableController.m
//  SyncDownLoadImg
//
//  Created by ShenYj on 16/8/23.
//  Copyright © 2016年 ___ShenYJ___. All rights reserved.
//

#import "JSAppsTableController.h"
#import "JSAppsModel.h"
#import "JSAppCell.h"
#import "UIImageView+JSWebCache.h"

static NSString * const reuseIdentifier = @"reuseIdentifier";

@implementation JSAppsTableController{
    
    NSArray <JSAppsModel *>      *_data;              //  数据容器
    
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
        // 成员变量初始化
        _data = [JSAppsModel loadAppsData];
        
        
    }
    return self;
}

- (NSString *)title{
    return @"应用程序列表";
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.tableView registerClass:[JSAppCell class] forCellReuseIdentifier:reuseIdentifier];
    
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JSAppCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    JSAppsModel *model = _data[indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.download;
    
    // 使用UIImage+JSWebCache分类设置图片
    [cell.imageView js_imageUrlString:model.icon withPlaceHolderImage:@"user_default"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 68;
}

#pragma mark -- UITableViewDataDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"----->ImageCacheCounts:%zd ----> OperationCacheCounts:%zd ---->CurrentOperationCounts:%zd",_imageCache.count,_operationCache.count,_queue.operationCount);
    
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}


#pragma mark  --  代码重构前的Cell数据源方法

//- (UITableViewCell *)originalDemotableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    JSAppCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
//    
//    JSAppsModel *model = _data[indexPath.row];
//    cell.textLabel.text = model.name;
//    cell.detailTextLabel.text = model.download;
//    
//    // 设置占位图
//    cell.imageView.image = [UIImage imageNamed:@"user_default"];
//    
//    // 从缓存中取出图片
//    if ([_imageCache objectForKey:model.icon]) {
//        cell.imageView.image = [_imageCache objectForKey:model.icon];
//        NSLog(@"从内存图片缓存池中获取图片");
//        return cell;
//    }
//    
//    // 从沙盒中获取图片
//    NSData *data = [NSData dataWithContentsOfFile:[_cachePath stringByAppendingPathComponent:model.icon.lastPathComponent]];
//    if (data) {
//        cell.imageView.image = [UIImage imageWithData:data];
//        
//        // 进行内存缓存
//        [_imageCache setObject:[UIImage imageWithData:data] forKey:model.icon];
//        
//        NSLog(@"从本地沙盒获取图片:(%@)",[_cachePath stringByAppendingPathComponent:model.icon.lastPathComponent]);
//        return cell;
//    }
//
//    // 判断操作是否存在
//    if ([_operationCache objectForKey:model.icon]) {
//        NSLog(@"图片正在下载中...");
//        return cell;
//    }
//
//    
//    /*    block内部使用self,不能够说一定存在循环引用
//     self -> _operationCache和_queue -> downLoadImageOperation -> block -> self
//            _operationCache     ->    手动清除downLoadImageOperation
//            _queue              ->    当队列中的操作执行完毕后downLoadImageOperation会自动销毁
//     */
//    //__weak typeof(self) weakSelf = self;
//    
//
//    NSBlockOperation *downLoadImageOperation = [NSBlockOperation blockOperationWithBlock:^{
//
//        [NSThread sleepForTimeInterval:5]; // 模拟延迟
//
//        // 下载图片
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.icon]];
//        UIImage *image = [UIImage imageWithData:data];
//
//        // 将下载好的图片进行内存缓存
//        // model.downloadImage = image;
//        [_imageCache setObject:image forKey:model.icon];
//
//        // 将下载好的图片做本地缓存
//        [data writeToFile:[_cachePath stringByAppendingPathComponent:model.icon.lastPathComponent] atomically:YES];
//
//        // 返回主线程刷新UI
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//
//            // cell.imageView.image = image; 避免重用Cell中有正在执行的下载操作导致图片混乱,直接刷新TableView从内存获取图片
//            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//
//            // 清除操作缓存池中对应的操作
//            [_operationCache removeObjectForKey:model.icon];
//
//            /*      [_operationCache removeAllObjects];
//             假设操作的完成时间足够长,因为下载操作异步执行,CPU会随机执行线程上的操作,如果设置了优先级或执行某一线程的概率较高,那么可以肯定,完成有先后,只是不够明显
//             一旦某个操作提前完成执行了清空操作缓存池,当再次滚动TableView的时候,可能还会出现同一个下载操作重复添加到队列中的问题
//             所以不应该使用removeAllObjects方法来移除
//             */
//
//        }];
//    }];
//    
//    // 添加到队列中
//    [_queue addOperation:downLoadImageOperation];
//    
//    // 将每一个下载图片的操作都添加到操作缓存池中(如果操作已经存在,就不再重复执行)
//    [_operationCache setObject:downLoadImageOperation forKey:model.icon];
//    
//    return cell;
//}

@end
