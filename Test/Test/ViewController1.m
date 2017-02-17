//
//  ViewController1.m
//  Test
//
//  Created by tempus-MAC on 2017/2/14.
//  Copyright © 2017年 tempus_kally. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()

@property (weak, nonatomic) IBOutlet UITextField *field1;
@property (weak, nonatomic) IBOutlet UITextField *field2;

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (IBAction)addBtnAction:(id)sender {
    int a = [_field1.text intValue]+[_field2.text intValue];
    if (self.callBackBlock) {
        self.callBackBlock(a);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
