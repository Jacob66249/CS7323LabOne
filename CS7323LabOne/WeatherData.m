//
//  WeatherData.m
//  CS7323LabOne
//
//  Created by mingyun zhang on 9/18/24.
//

// WeatherData.m
// CS7323LabOne
//
// Created by mingyun zhang on 9/18/24.
//

#import "WeatherData.h"

@interface WeatherData ()

@property (nonatomic, strong) NSMutableArray<UIImage *> *images;

@end

@implementation WeatherData

+ (instancetype)sharedInstance {
    static WeatherData *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _images = [NSMutableArray array];
        [self loadImages];
    }
    return self;
}

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
            @"image": @"new_york",
            @"date": @"2024-09-19"
        },
        @{
            @"city": @"Dallas",
            @"temperature": @"25",
            @"condition": @"Cloudy",
            @"forecast": @"Overcast skies with a slight chance of light showers in the afternoon.",
            @"humidity": @"60%",
            @"windSpeed": @"15 km/h",
            @"description": @"A mostly cloudy day with moderate temperatures. Ideal for a walk in the park.",
            @"image": @"dallas",
            @"date": @"2024-09-19"
        },
        @{
            @"city": @"Denver",
            @"temperature": @"18",
            @"condition": @"Rainy",
            @"forecast": @"Persistent rain expected throughout the day with possible thunderstorms.",
            @"humidity": @"80%",
            @"windSpeed": @"20 km/h",
            @"description": @"A rainy day with cooler temperatures. Good day to stay indoors and enjoy a warm drink.",
            @"image": @"denver",
            @"date": @"2024-09-19"
        }
    ];
}

- (void)loadImages {
    NSArray *weatherArray = [self getWeatherData];
    for (NSDictionary *data in weatherArray) {
        NSString *imageName = data[@"image"];
        UIImage *image = [UIImage imageNamed:imageName];
        if (image) {
            [self.images addObject:image];
        }
    }
}

- (NSInteger)numberOfImages {
    return self.images.count;
}

- (UIImage *)getImageAtIndex:(NSInteger)index {
    if (index < self.images.count) {
        return self.images[index];
    }
    return nil;
}

@end
