//
//  WeatherData.m
//  CS7323LabOne
//
//  Created by mingyun zhang on 9/18/24.
//

#import "WeatherData.h"

@interface WeatherData ()

// Properties to store weather data and images
@property (nonatomic, strong) NSMutableArray<NSDictionary *> *weatherData; // Array to hold weather data dictionaries
@property (nonatomic, strong) NSMutableArray<UIImage *> *images; // Array to hold images associated with weather data

@end

@implementation WeatherData

// Singleton pattern to ensure only one instance of WeatherData exists
+ (instancetype)sharedInstance {
    static WeatherData *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

// Initialization of WeatherData
- (instancetype)init {
    self = [super init];
    if (self) {
        _weatherData = [NSMutableArray array]; // Initialize weather data array
        _images = [NSMutableArray array]; // Initialize images array
        [self loadWeatherData]; // Load weather data from JSON file
    }
    return self;
}

// Load weather data from a JSON file in the main bundle
- (void)loadWeatherData {
    // Get the file path of the JSON file named "WeatherData.json"
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"WeatherData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    // Check if data is available
    if (data) {
        NSError *error = nil;
        // Parse JSON data into an array
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (error) {
            NSLog(@"Error reading JSON file: %@", error.localizedDescription); // Log any errors during parsing
            return;
        }
        
        // Check if the parsed object is an array
        if ([jsonArray isKindOfClass:[NSArray class]]) {
            [self.weatherData addObjectsFromArray:jsonArray]; // Add the parsed JSON objects to the weather data array
            [self loadImages]; // Load images corresponding to the weather data
        }
    }
}

// Returns a copy of the weather data array
- (NSArray *)getWeatherData {
    return [self.weatherData copy];
}

// Load images based on the image names provided in weather data
- (void)loadImages {
    for (NSDictionary *data in self.weatherData) {
        NSString *imageName = data[@"image"]; // Get the image name from weather data
        UIImage *image = [UIImage imageNamed:imageName]; // Load the image
        if (image) {
            [self.images addObject:image]; // Add the image to the images array if it exists
        }
    }
}

// Returns the number of images loaded
- (NSInteger)numberOfImages {
    return self.images.count;
}

// Returns the image at a specified index
- (UIImage *)getImageAtIndex:(NSInteger)index {
    if (index < self.images.count) {
        return self.images[index];
    }
    return nil; // Return nil if the index is out of bounds
}

@end
