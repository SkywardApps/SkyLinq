//
//  NSArray+NSArray_Linq.h
//  Senio
//
//  Created by Nicholas Elliott on 2/24/18.
//  Copyright © 2018 Skyward App Company, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SkyLinq.h"

/**
 * Simple category for an NSArray that will provide easy access to Linq queries.
 */
@interface NSArray<__covariant ObjectType> (SkyLinq)

/// Access a Linq wrapper for this array
@property (readonly) SkyLinq* query;

@end
