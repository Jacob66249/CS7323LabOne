//
//  WeatherData.m
//  CS7323LabOne
//
//  Created by mingyun zhang on 9/18/24.
//

#import "WeatherData.h"

@implementation WeatherData : NSObject

- (NSArray *)getWeatherData {
    return @[
        @{
            @"city": @"New York",
            @"temperature": @"22",
            @"condition": @"Sunny",
            @"forecast": @"Expect clear skies throughout the day with no precipitation.",
            @"humidity": @"45%",
            @"windSpeed": @"10 km/h",
            @"description": @"A beautiful sunny day with mild temperatures. Perfect for outdoor activities.",
            @"image": @"new_york"
        },
        @{
            @"city": @"Dallas",
            @"temperature": @"25",
            @"condition": @"Cloudy",
            @"forecast": @"Overcast skies with a slight chance of light showers in the afternoon.",
            @"humidity": @"60%",
            @"windSpeed": @"15 km/h",
            @"description": @"A mostly cloudy day with moderate temperatures. Ideal for a walk in the park.",
            @"image": @"dallas"
        },
        @{
            @"city": @"Denver",
            @"temperature": @"18",
            @"condition": @"Rainy",
            @"forecast": @"Persistent rain expected throughout the day with possible thunderstorms.",
            @"humidity": @"80%",
            @"windSpeed": @"20 km/h",
            @"description": @"A rainy day with cooler temperatures. Good day to stay indoors and enjoy a warm drink.",
            @"image": @"denver"
        }
    ];
}

@end


