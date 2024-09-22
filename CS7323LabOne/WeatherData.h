//
//  WeatherData.h
//  CS7323LabOne
//
//  Created by mingyun zhang on 9/18/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WeatherData : NSObject

// Shared instance for singleton pattern
+ (instancetype)sharedInstance;

// Method to get the weather data array
- (NSArray *)getWeatherData;

// Method to get the number of images available
- (NSInteger)numberOfImages;

// Method to get an image at a specific index
- (UIImage *)getImageAtIndex:(NSInteger)index;

@end
