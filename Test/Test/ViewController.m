//
//  ViewController.m
//  Test
//
//  Created by tempus-MAC on 2016/12/14.
//  Copyright © 2016年 tempus_kally. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"

static NSString * const MGJ_ROUTER_WILDCARD_CHARACTER = @"~";

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (nonatomic) NSMutableDictionary *routes;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSDictionary *testDic = @{@"key1":@"value1",@"key2":@"value2",@"key3":@"value3"};
    NSLog(@"testDic[@\"key1\"] = %@",testDic[@"key1"]);
    
    NSString *urlString = @"file:///directory/directory%202/file";
    NSArray *urlComponents = [[NSURL URLWithString:urlString] pathComponents];
    NSLog(@"urlComponents is %@",[urlComponents description]);
    
    NSArray *componentsArray = [self pathComponentsFromURL1:urlString];
    NSLog(@"componentsArray is %@",componentsArray);
    
    NSMutableDictionary *urlPatternDic = [NSMutableDictionary dictionaryWithDictionary:[self addURLPattern:urlString]];
    NSLog(@"urlPatternDic is %@",urlPatternDic);
}

- (NSMutableDictionary *)routes {
    if (!_routes) {
        _routes = [[NSMutableDictionary alloc] init];
    }
    return  _routes;
}

- (NSMutableDictionary *)addURLPattern:(NSString *)URLPattern {
    NSArray *pathComponents = [self pathComponentsFromURL1:URLPattern];
    
    NSInteger index = 0;
    NSMutableDictionary *subRoutes = self.routes;
    
    while (index < pathComponents.count) {
        NSString *pathComponent = pathComponents[index];
        if (![subRoutes objectForKey:pathComponent]) {
            subRoutes[pathComponent] = [[NSMutableDictionary alloc] init];
            
        }
        subRoutes = subRoutes[pathComponent];
        index ++;
        
    }
    return subRoutes;
    
}

- (NSArray *)pathComponentsFromURL1:(NSString *)URL {
    NSMutableArray *pathComponents = [NSMutableArray array];
    if ([URL rangeOfString:@"://"].location != NSNotFound) {
        NSArray *pathSegements = [URL componentsSeparatedByString:@"://"];
        //如果 URL 包含协议，那么把协议作为第一个元素放进去
        [pathComponents addObject:pathSegements[0]];
        
        //如果只有协议，那么放一个占位符
        if ((pathSegements.count == 2 && ((NSString *)pathSegements[1]).length) ||pathSegements.count < 2
            ) {
            [pathComponents addObject:MGJ_ROUTER_WILDCARD_CHARACTER];
        }
        
        URL = [URL substringFromIndex:[URL rangeOfString:@"://"].location + 3];
    }
    
    for (NSString *pathComponent in [[NSURL URLWithString:URL] pathComponents]) {
        if ([pathComponent isEqualToString:@"/"]) {
            continue;
        }
        if ([[pathComponent substringToIndex:1] isEqualToString:@"?"]) {
            break;
        }
        [pathComponents addObject:pathComponent];
    }
    return [pathComponents copy];
}

- (IBAction)goToNextPage:(id)sender {
    ViewController1 *viewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController1ID"];
    viewCtrl.callBackBlock = ^(int result){
        self.resultLabel.text = [NSString stringWithFormat:@"%ld",(long)result];
    };
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
