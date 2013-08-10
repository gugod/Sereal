//
//  SrlObject.m
//  Sereal
//
//  Created by xant on 8/10/13.
//  Copyright (c) 2013 Andrea Guzzo. All rights reserved.
//

#import "SrlObject.h"

@interface SrlObject ()
@end

@implementation SrlObject
@synthesize className, objData;

+ (id)srlObject:(NSString *)name data:(id)data
{
    SrlObject *obj = [[self alloc] initWithName:name data:data];
    return obj;
}

- (id)initWithName:(NSString *)name data:(id)data
{
    self = [super init];
    if (self) {
        className = name;
        objData = data;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ : %@", self.className, self.objData];
}
@end