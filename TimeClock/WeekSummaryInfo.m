//
//  WeekSummaryInfo.m
//  TimeClock
//
//  Created by Ryan Wilcox on 11/6/22.
//  Copyright © 2022 Franz Scholz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeekSummaryInfo.h"
#import "Entry.h"

@implementation WeekSummaryInfo

- (instancetype)init {
    if (!(self = [super init]))
        return nil;
   
    _entriesForThisWeek = [[NSMutableArray alloc] init];
    
    return self;
}

- (void) appendEntry: (Entry*) entry {
    [self.entriesForThisWeek addObject:entry];
}


- (NSNumber*) sumHoursForWeek {
    NSInteger sum = 0;
    for (Entry* currentEntry in self.entriesForThisWeek) {
      sum += [[currentEntry duration] intValue];
    }
    
    return [NSNumber numberWithLong: sum];
}


- (id)copyWithZone:(NSZone *)zone {
    WeekSummaryInfo *result = [[[self class] allocWithZone:zone] init];

    // If your class has any properties then do
    result.weekStartName = self.weekStartName;
    result.entriesForThisWeek = self.entriesForThisWeek;

    return result;
}



@end
