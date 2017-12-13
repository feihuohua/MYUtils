//
//  MYTestViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/21.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYTestViewController.h"
#import "MYNetworking.h"

@interface MYTestViewController ()

@end

@implementation MYTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 通常放在appdelegate就可以了
    [MYNetworking updateBaseUrl:@"http://apistore.baidu.com"];
    [MYNetworking enableInterfaceDebug:YES];
    [MYNetworking detectNetwork];
    
    // 配置请求和响应类型，由于部分伙伴们的服务器不接收JSON传过去，现在默认值改成了plainText
    [MYNetworking configRequestType:kMYRequestTypePlainText
                       responseType:kMYResponseTypeJSON
                 shouldAutoEncodeUrl:YES
             callbackOnCancelRequest:NO];
    
    // 设置GET、POST请求都缓存
    [MYNetworking cacheGetRequest:YES shoulCachePost:YES];
    
    // 测试GET API
    NSString *url = @"http://api.map.baidu.com/telematics/v3/weather?location=嘉兴&output=json&ak=5slgyqGDENN7Sy7pw29IUvrZ";
    //   设置请求类型为text/html类型
    //  [HYBNetworking configRequestType:kHYBRequestTypePlainText];
    //  [HYBNetworking configResponseType:kHYBResponseTypeData];
    // 如果请求回来的数据是业务数据，但是是失败的，这时候需要外部开发人员才能判断是业务失败。
    // 内部处理是只有走failure的才能判断为无效数据，才不会缓存
    // 如果设置为YES,则每次会去刷新缓存，也就是不会读取缓存，即使已经缓存起来
    // 新下载的数据会重新缓存起来
    [MYNetworking getWithUrl:url refreshCache:NO params:nil progress:^(int64_t bytesRead, int64_t totalBytesRead) {
        NSLog(@"progress: %f, cur: %lld, total: %lld",
              (bytesRead * 1.0) / totalBytesRead,
              bytesRead,
              totalBytesRead);
    } success:^(id response) {
        
    } fail:^(NSError *error) {
        
    }];
    
    NSLog(@"网络状态:--->%ld", (long)[MYNetworking networkStatus]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
