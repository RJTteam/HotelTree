//
// HotelBack0View.h
// Generated by Core Animator version 1.3.2 on 1/6/17.
//
// DO NOT MODIFY THIS FILE. IT IS AUTO-GENERATED AND WILL BE OVERWRITTEN
//

@import UIKit;

IB_DESIGNABLE
@interface HotelBack0View : UIView

@property (strong, nonatomic) NSDictionary *viewsByName;

// HotelBackGround
- (void)addHotelBackGroundAnimation;
- (void)addHotelBackGroundAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion;
- (void)addHotelBackGroundAnimationWithBeginTime:(CFTimeInterval)beginTime andFillMode:(NSString *)fillMode andRemoveOnCompletion:(BOOL)removedOnCompletion;
- (void)removeHotelBackGroundAnimation;

- (void)removeAllAnimations;

@end