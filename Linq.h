//
//  Linq.h
//  Senio
//
//  Created by Nicholas Elliott on 2/24/18.
//  Copyright © 2018 Skyward App Company, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Linq<__covariant ObjectType> : NSObject

+(Linq<ObjectType>*)from:(NSObject<NSFastEnumeration>*)source;

typedef id(^select)(ObjectType);
typedef Linq*(^selectMethod)(select);
@property (readonly) selectMethod select;
- (NSArray*) select:(select)f;

typedef BOOL(^filter)(ObjectType);
typedef Linq<ObjectType>*(^filterMethod)(filter);
@property (readonly) filterMethod where;
- (NSArray*) where:(filter)f;

typedef id(^groupBy)(ObjectType);
typedef NSDictionary*(^groupByMethod)(groupBy);
@property (readonly) groupByMethod groupBy;
- (NSDictionary*) groupBy:(groupBy)f;

typedef NSArray*(^selectMany)(ObjectType);
typedef Linq*(^selectManyMethod)(selectMany);
@property (readonly) selectManyMethod selectMany;
- (NSArray*)selectMany:(selectMany)f;

typedef id(^orderBy)(ObjectType);
typedef Linq<ObjectType>*(^orderByMethod)(orderBy);
@property (readonly) orderByMethod orderBy;
- (NSArray<ObjectType>*)orderBy:(orderBy)f;
@property (readonly) orderByMethod orderByDesc;
- (NSArray<ObjectType>*)orderByDesc:(orderBy)f;


typedef Linq<ObjectType>*(^selectArray)(int);
@property (readonly) selectArray skip;
- (NSArray<ObjectType>*) skip:(int)count;
@property (readonly) selectArray take;
- (NSArray<ObjectType>*) take:(int)count;

@property (readonly) ObjectType first;
@property (readonly) ObjectType last;

@property (readonly) NSArray<ObjectType>* array;

@end
