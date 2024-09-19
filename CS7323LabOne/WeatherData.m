//
//  WatherData.m
//  CS7323LabOne
//
//  Created by mingyun zhang on 9/18/24.
//

#import <Foundation/Foundation.h>

@implementation WeatherData : NSObject 

- (NSArray *)getWeatherData {
    return @[
        @{@"city": @"New York", @"temperature": @75, @"condition": @"Sunny"},
        @{@"city": @"Los Angeles", @"temperature": @68, @"condition": @"Cloudy"},
        @{@"city": @"Chicago", @"temperature": @60, @"condition": @"Rainy"}
    ];
}

@end

