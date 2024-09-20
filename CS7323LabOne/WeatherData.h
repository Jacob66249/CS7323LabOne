// WeatherData.h
// CS7323LabOne
//
// Created by mingyun zhang on 9/18/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WeatherData : NSObject

+ (instancetype)sharedInstance;
- (NSArray *)getWeatherData;
- (NSInteger)numberOfImages;
- (UIImage *)getImageAtIndex:(NSInteger)index;

@end
