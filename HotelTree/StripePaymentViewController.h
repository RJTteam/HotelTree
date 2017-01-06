//
//  PaymentViewController.h
//  Stripe
//
//  Created by Alex MacCaw on 3/4/13.
//
//

#import <UIKit/UIKit.h>

@class StripePaymentViewController;

@protocol PaymentViewControllerDelegate<NSObject>

- (void)paymentViewController:(StripePaymentViewController *)controller didFinish:(NSError *)error;

@end

@interface StripePaymentViewController : UIViewController

@property (nonatomic) NSDecimalNumber *amount;
@property (nonatomic, weak) id<PaymentViewControllerDelegate> delegate;

@end
