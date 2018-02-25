//
//  Linq.h
//  Senio
//
//  Created by Nicholas Elliott on 2/24/18.
//  Copyright © 2018 Skyward App Company, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DeclareBlockMethod(name,lambdaReturnType,lambdaParameterType,blockReturnType,messageReturnType)    \
    typedef lambdaReturnType(^name)(lambdaParameterType);    \
    typedef blockReturnType(^name##Method)(name);   \
    @property (readonly) name##Method name;         \
    - (messageReturnType) name:(name)f;

/**
 * A wrapper interface exposing LINQ-style queries on a source collection.
 * The return types will be generic-typed where possible.
 */
@interface SkyLinq<__covariant ObjectType> : NSObject

/// Construct a Linq wrapper for a specified collection.
+(SkyLinq<ObjectType>*)from:(NSObject<NSFastEnumeration>*)source;

/// Select a transformed object from each item in the collection
DeclareBlockMethod(select,id,ObjectType,SkyLinq*,NSArray*);

/// Filter the collection to only items returning YES
DeclareBlockMethod(where, BOOL,ObjectType, SkyLinq<ObjectType>*, NSArray*);

/// Group the collection into an NSDictionary with a key given by the lambda
DeclareBlockMethod(groupBy, id,ObjectType, NSDictionary*, NSDictionary*);

/// Select arrays from each item in the collection and then flatten the array of arrays.
DeclareBlockMethod(selectMany, NSArray*,ObjectType, SkyLinq*, NSArray*);

/// Sort the collection by the key returned by the lambda, in ascending order
DeclareBlockMethod(orderBy, id,ObjectType, SkyLinq<ObjectType>*, NSArray<ObjectType>*);

/// Sort the collection by the key returned by the lambda, in descending order
DeclareBlockMethod(orderByDesc, id,ObjectType, SkyLinq<ObjectType>*, NSArray<ObjectType>*);

/// Skip a number of items from the beginning of the collection
typedef SkyLinq<ObjectType>*(^selectArray)(int);
@property (readonly) selectArray skip;
- (NSArray<ObjectType>*) skip:(int)count;

/// Take a number of items out of the collection
@property (readonly) selectArray take;
- (NSArray<ObjectType>*) take:(int)count;

/// Get the first item from the collection
@property (readonly) ObjectType first;

/// Get the last item from the collection
@property (readonly) ObjectType last;

/// Transform the current query results into an NSArray
@property (readonly) NSArray<ObjectType>* array;

@end
