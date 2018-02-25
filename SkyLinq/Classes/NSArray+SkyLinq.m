//
//  NSArray+NSArray_Linq.m
//  Senio
//
//  Created by Nicholas Elliott on 2/24/18.
//  Copyright © 2018 Skyward App Company, LLC. All rights reserved.
//

#import "NSArray+SkyLinq.h"

@implementation NSArray (SkyLinq)

- (SkyLinq *)query
{
    return [SkyLinq from:self];
}

@end
