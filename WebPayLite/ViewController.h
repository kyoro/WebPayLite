//
//  ViewController.h
//  WebPayLite
//
//  Created by Kyosuke INOUE on 2013/12/01.
//  Copyright (c) 2013 OpenSwipe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtCardNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtExpireMonth;
@property (weak, nonatomic) IBOutlet UITextField *txtExpireYear;
@property (weak, nonatomic) IBOutlet UITextField *txtCvc;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtAmount;

- (IBAction)btnChargeTouch:(id)sender;

@end
