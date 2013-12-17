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
    wpl.apiKey = @"YOUR_PUBLIC_KEY";

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

- (IBAction)btnCreateTokenTouch:(id)sender {
    NSDictionary *params = @{ @"card[number]" : self.txtCardNumber.text,
                              @"card[exp_month]" : self.txtExpireMonth.text,
                              @"card[exp_year]" : [NSString stringWithFormat:@"20%@",self.txtExpireYear.text] ,
                              @"card[cvc]" : self.txtCvc.text,
                              @"card[name]" : self.txtName.text,
                              @"description" : @"tokenize test"
                              };
    [wpl createToken:params];
}

- (void)WebPayLiteDelegateCompleted:(NSString *)jsonBody {
    NSLog(@"%@",jsonBody);
    NSDictionary *jsonObject = [NSJSONSerialization
                                JSONObjectWithData: [jsonBody dataUsingEncoding:NSUTF8StringEncoding]
                                options: NSJSONReadingAllowFragments
                                error:nil];
    NSString *token = [jsonObject objectForKey:@"id"];
    self.txtToken.text = token;

    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Succeed!"
                          message:[NSString stringWithFormat:@"Token: %@",token]
                          delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];

    [alert show];
    
}

-(void)WebPayLiteDelegateError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Network Error"
                          message:[error description]
                          delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
}

-(void)WebPayLiteDelegateFailed:(NSString *)jsonBody statusCode:(int)status {
    NSLog(@"%@",jsonBody);
    NSDictionary *jsonObject = [NSJSONSerialization
                                JSONObjectWithData: [jsonBody dataUsingEncoding:NSUTF8StringEncoding]
                                options: NSJSONReadingAllowFragments
                                error:nil];
    NSString *message = [[jsonObject objectForKey:@"error"] objectForKey:@"message"];

    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Transaction Faild"
                          message:message
                          delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
}


@end


