//
//  WeekSummaryInfo.h
//  TimeClock
//
//  Created by Ryan Wilcox on 11/7/22.
//  Copyright © 2022 Franz Scholz. All rights reserved.
//

#ifndef WeekSummaryInfo_h
#define WeekSummaryInfo_h

@class Entry;

@interface WeekSummaryInfo : NSObject<NSCopying>

@property (nonatomic, retain) NSString * weekStartName;
@property (nonatomic, retain) NSMutableArray* entriesForThisWeek;

- (void) appendEntry: (Entry*) entry;

- (NSNumber*) sumHoursForWeek;
@end

#endif /* WeekSummaryInfo_h */
