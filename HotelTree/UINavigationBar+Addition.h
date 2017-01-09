//
//  UINavigationBar+Addition.h
//  HotelTree
//
//  Created by Lucas Luo on 12/31/16.
//  Copyright © 2016 RJT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Addition)
/**
 * Hide 1px hairline of the nav bar
 */
- (void)hideBottomHairline;

/**
 * Show 1px hairline of the nav bar
 */
- (void)showBottomHairline;

/**
 * Makes the navigation bar background transparent.
 */
- (void)makeTransparent;

/**
 * Restores the default navigation bar appeareance
 **/
- (void)makeDefault;

@end
