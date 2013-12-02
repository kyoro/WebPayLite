//
//  ViewController.m
//  WebPayLite
//
//  Created by Kyosuke INOUE on 2013/12/01.
//  Copyright (c) 2013 OpenSwipe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    //WebPayLite
    wpl = [[WebPayLite alloc] init];
    wpl.delegate = self;
    wpl.secretKey = @"test";

    //Close Keybord
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSoftKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];


}

//Close Keyboard
- (void)closeSoftKeyboard {
    [self.view endEditing: YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnChargeTouch:(id)sender {
    NSDictionary *params = @{ @"card[number]" : self.txtCardNumber,
                              @"card[exp_month]" : self.txtExpireMonth,
                              @"card[exp_year]" : [NSString stringWithFormat:@"20%@",self.txtExpireYear] ,
                              @"card[cvc]" : self.txtCvc,
                              @"card[name]" : self.txtName,
                              @"amount" : self.txtAmount,
                              @"currency" : @"usd",
                              @"description" : @"transaction test"
                              };
    [wpl createCharge:params];
}

- (void)WebPayLiteDelegateCompleted:(NSString *)jsonBody {
    NSLog(@"%@",jsonBody);
    
}

-(void)WebPayLiteDelegateError:(NSError *)error {
       NSLog(@"ERROR");


}
-(void)WebPayLiteDelegateFailed:(NSString *)jsonBody statusCode:(int)status {
       NSLog(@"%@",jsonBody);

}


@end


