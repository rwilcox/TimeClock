//
//  Project+Extended.m
//  TimeClock
//
//  Created by Franz Scholz on 18.12.09.
//  Copyright (C) 2009-2022, Franz Scholz <franz@franzscholz.net>, www.franzscholz.net
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

#import "Project.h"

#import "Entry.h"
#import "Entry+Extended.h"
#import "SummarizedEntry.h"
#import "TimeClockAppDelegate.h"
#import "WeekSummaryInfo.h"

@implementation Project (Extended)

- (NSDate*) startDate
{
    return [self valueForKeyPath:@"entries.@min.startDate"];
}

- (NSDate*) endDate
{
    return [self valueForKeyPath:@"entries.@max.endDate"];
}

- (NSNumber*) totalTime
{
    return [self valueForKeyPath:@"entries.@sum.duration"];
}

- (NSArray*) timesSummarizedByDate
{
	return [SummarizedEntry accumulateEntriesFromSet:[self entries] usingDateFormatter:[SummarizedEntry yearMonthDayFormatter]];
}


- (NSString*) description
{
	return [NSString stringWithFormat:@"%@: total=%@ hours, %lu entries, %@ (%@ - %@)", self.name, [self valueForKeyPath:@"entries.@sum.duration"], (unsigned long)[self.entries count], [self timesSummarizedByDate], [self valueForKeyPath:@"entries.@min.startDate"], [self valueForKeyPath:@"entries.@max.endDate"]];
}


- (NSArray*) weeklySummaries {
    NSSet* entries = [self entries];
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"startDate"
                                                                ascending:YES];
    NSArray* sorted = [entries sortedArrayUsingDescriptors:@[descriptor]];
    NSMutableDictionary *dates = [[NSMutableDictionary alloc] init];
    
    for(Entry* currentEntry in sorted) {
        NSDate* weekStart = [self _startOfWeekFor: currentEntry.startDate];
        NSString* startAsString = [self _stringFromDate: weekStart];
        
        WeekSummaryInfo* weekInfo = [dates objectForKey: startAsString];
        if (weekInfo == nil) {
            weekInfo = [[WeekSummaryInfo alloc] init];
            weekInfo.weekStartName = startAsString;
            [dates setObject:weekInfo forKey: startAsString];
        }
        
        [weekInfo appendEntry:currentEntry];
    }
    
    NSSortDescriptor *weekDescriptor = [[NSSortDescriptor alloc] initWithKey:@"weekStartName"
                                                                ascending:YES];
    return [[dates allValues] sortedArrayUsingDescriptors:@[weekDescriptor]];
}


// from https://stackoverflow.com/a/16993178/224334
- (NSDate*) _startOfWeekFor: (NSDate*) date {
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSDate *startOfTheWeek;
    NSDate *endOfWeek;
    NSTimeInterval interval;
    [cal rangeOfUnit:NSWeekCalendarUnit
           startDate:&startOfTheWeek
            interval:&interval
             forDate:date];
    //startOfWeek holds now the first day of the week, according to locale (monday vs. sunday)
    
    return startOfTheWeek;
    //endOfWeek = [startOfTheWeek dateByAddingTimeInterval:interval-1];
    // holds 23:59:59 of last day in week.
}

- (NSString*) _stringFromDate: (NSDate*) date {
   NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
   [formatter setDateFormat:@"yyyy-MM-dd"];
   return [formatter stringFromDate:date];
}
@end

