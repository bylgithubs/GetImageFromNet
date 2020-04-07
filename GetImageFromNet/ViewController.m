//
//  ViewController.m
//  GetImageFromNet
//
//  Created by Civet on 2020/4/7.
//  Copyright © 2020 PersonalONBYL. All rights reserved.
//

#import "ViewController.h"

//#define USER_DOCUMENTS_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject]stringByAppendingPathComponent:CURRENT_USER]
//#define USER_Chat_Folder_Path [USER_DOCUMENTS_PATH             stringByAppendingPathComponent:@"chat"]


@interface ViewController ()

@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSSearchPathForDirectoriesInDomains:方法用于查找目录，返回指定范围内的指定名称的目录的路径集合;
//NSDocumentDirectory:NSDocumentDirectory表明我们要搜索的是Documents目录。如果我们将其换成NSCachesDirectory就表示我们搜索的是Library/Caches目录;
//NSUserDomainMask表示搜索的范围限制于当前应用的沙盒目录。还可以写成NSLocalDomainMask（表示/Library）、NSNetworkDomainMask（表示/Network）等

    
    NSString *USER_DOCUMENTS_PATH =[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject]stringByAppendingPathComponent:@"administration"];
    NSString *USER_Data_Folder_Path = [USER_DOCUMENTS_PATH             stringByAppendingPathComponent:@"data"];
    
    NSString *path1 = USER_DOCUMENTS_PATH;
    NSString *path2 = USER_Data_Folder_Path;
    
    
    self.url = @"https://mfbd.fujfu.com/static/img/subject@2x.64961c9.png";
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.url]];
    [self saveData:imageData withName:self.url.lastPathComponent toPath:USER_Data_Folder_Path];
    UIImage *image = [self getImageFromPath:[USER_Data_Folder_Path stringByAppendingPathComponent:self.url.lastPathComponent]];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, image.size.width, image.size.height)];
    [self.imageView setBackgroundColor:[UIColor grayColor]];
    [self.imageView setImage:image];
    [self.view addSubview:self.imageView];
}

- (void)saveData:(NSData *)data withName:(NSString *)name toPath:(NSString *)path{
    if (data == nil) {
        return;
    }
    NSFileManager *fileManage = [NSFileManager defaultManager];
    BOOL isDirection = NO;
    BOOL isExisted = [fileManage fileExistsAtPath:path isDirectory:&isDirection];
    if (!(isDirection == YES && isExisted == YES)) {
        [fileManage createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *dataAllPath = [path stringByAppendingPathComponent:name];
    [data writeToFile:dataAllPath atomically:YES];
}

- (UIImage *)getImageFromPath:(NSString *)path{
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
}

@end
