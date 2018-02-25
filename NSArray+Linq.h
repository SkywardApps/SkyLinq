//
//  NSArray+NSArray_Linq.h
//  Senio
//
//  Created by Nicholas Elliott on 2/24/18.
//  Copyright © 2018 Skyward App Company, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Linq.h"

@interface NSArray<__covariant ObjectType> (Linq)

@property (readonly) Linq* query;

@end
