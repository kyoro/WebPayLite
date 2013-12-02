# WebPay Lite
WebPay Lite is client library for WebPay Payment Gateway via Objective-C.
This library provides simple access to WebPay. Charge and Tokenize features are available. You can create payment function for your iOS Apps. iOS 6.0+ devices are supported. (ARC and JSON Framework are required)

# Features
- Easy to use. file copies only.
- Other libraries are not needed. Authentication and Base64 encoding features are included.
- Simple and Light weight library.
- Stripe.com is supported (If you want, because same style API :)

# How to use

### Set delegate and declare class variables
```
@interface ViewController : UIViewController <WebPayLiteDelegate>{
    WebPayLite *wpl;
}
```

### Initialize

```
//WebPayLite
wpl = [[WebPayLite alloc] init];
wpl.delegate = self;
wpl.secretKey = @"YOUR_SECRET_KEY";
```
### Charge or Tokenize

```
    NSDictionary *params = @{ @"card[number]" : @"4242424242424242",
                              @"card[exp_month]" : @"12",
                              @"card[exp_year]" : @"18" ,
                              @"card[cvc]" : @"123",
                              @"card[name]" : @"KYOSUKE INOUE",
                              @"amount" : @"100",
                              @"currency" : @"jpy",
                              @"description" : @"Test Charge"
                              };
    [wpl createCharge:params];
```

That's it!

# License
```
The MIT License

Copyright (c) 2013 Kyosuke INOUE

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
```

# Contact
- kyoro[AT]hakamastyle.net
- <http://kyoro353.hatenablog.com/>

