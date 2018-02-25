//
//  Linq.m
//  Senio
//
//  Created by Nicholas Elliott on 2/24/18.
//  Copyright © 2018 Skyward App Company, LLC. All rights reserved.
//

#import "Linq.h"
#import "NSArray+Linq.h"

@interface Linq ()
{
    NSObject<NSFastEnumeration>* source;
}

@end

@implementation Linq

+(Linq*)from:(NSObject<NSFastEnumeration>*)source
{
    return [[Linq alloc] initWithSource: source];
}

- (instancetype) initWithSource:(NSObject<NSFastEnumeration>*)source
{
    if((self = [super init]))
    {
        self->source = source;
    }
    return self;
}


- (selectMethod)select {
    return ^(select f)
    {
        return [self select:f].query;
    };
}

- (NSArray *)select:(select)f
{
    NSArray* result = @[];
    for(id item in source)
    {
        result = [result arrayByAddingObject:f(item)];
    }
    return result;
}

- (filterMethod)where {
    return ^(filter f)
    {
        return [self where:f].query;
    };
}

- (NSArray *)where:(filter)f
{
    NSArray* result = @[];
    for(id item in source)
    {
        if(f(item))
            result = [result arrayByAddingObject:item];
    }
    return result;
}

- (groupByMethod)groupBy
{
    return ^(groupBy f)
    {
        return [self groupBy:f];
    };
}

- (NSDictionary *)groupBy:(groupBy)f
{
    NSMutableDictionary* groups = [[NSMutableDictionary alloc] init];
    for(id item in source)
    {
        id key = f(item);
        if(groups[key] == nil)
        {
            groups[key] = [NSArray array];
        }
        groups[key] = [groups[key] arrayByAddingObject:item];
    }
    return groups;
}

- (selectManyMethod)selectMany
{
    return ^(selectMany f)
    {
        return [self selectMany:f].query;
    };
}

- (NSArray *)selectMany:(selectMany)f
{
    NSArray* result = @[];
    for(id item in source)
    {
        NSArray* subslice = f(item);
        if(subslice.count > 0)
        {
            result = [result arrayByAddingObjectsFromArray:subslice];
        }
    }
    return result;
    
}

- (orderByMethod)orderBy
{
    return ^(orderBy f)
    {
        return [self orderBy:f].query;
    };
}

- (NSArray *)orderBy:(orderBy)f
{
    NSArray* array;
    if([source isKindOfClass:NSArray.class])
    {
        array = source;
    }
    else
    {
        array = @[];
        for(id item in source)
        {
            array = [array arrayByAddingObject:item];
        }
    }
    
    return [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [f(obj1) compare:f(obj2)];
    }];
}


- (orderByMethod)orderByDesc
{
    return ^(orderBy f)
    {
        return [self orderByDesc:f].query;
    };
}

- (NSArray *)orderByDesc:(orderBy)f
{
    NSArray* array;
    if([source isKindOfClass:NSArray.class])
    {
        array = source;
    }
    else
    {
        array = @[];
        for(id item in source)
        {
            array = [array arrayByAddingObject:item];
        }
    }
    
    return [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [f(obj2) compare:f(obj1)];
    }];
}

- (selectArray)skip
{
    return ^(int count)
    {
        return [self skip:count].query;
    };
}

- (NSArray *)skip:(int)count
{
    NSArray* result = @[];
    NSUInteger index = 0;
    for(id item in source)
    {
        if(index >= count)
            result = [result arrayByAddingObject:item];
        ++index;
    }
    return result;
}

- (selectArray)take
{
    return ^(int count)
    {
        return [self take:count].query;
    };
}

- (NSArray *)take:(int)count
{
    NSArray* result = @[];
    NSUInteger index = 0;
    for(id item in source)
    {
        if(index < count)
            result = [result arrayByAddingObject:item];
        else
            break;
        
        ++index;
    }
    return result;
}

- (id)first
{
    if([source isKindOfClass:NSArray.class])
    {
        NSArray* array = source;
        return array.count > 0 ? array[0] : nil;
    }
    
    for(id item in source)
    {
        return item;
    }
    
    return nil;
}

- (id)last
{
    if([source isKindOfClass:NSArray.class])
    {
        NSArray* array = source;
        return array.count > 0 ? array[array.count-1]  : nil;
    }
    
    id lastItem = nil;
    for(id item in source)
    {
        lastItem = item;
    }
    
    return lastItem;
}

- (NSArray *)array
{
    if([source isKindOfClass:NSArray.class])
    {
        return source;
    }
    
    NSArray* array = @[];
    for(id item in source)
    {
        array = [array arrayByAddingObject:item];
    }
    return array;
}

@end
