#import "FlickrAPI.h"
#import "Photo.h"

NSString * const APIKey                  = @"1bbf018517c61b3b60c9c94d659dc000";
NSString * const BaseURLString           = @"https://api.flickr.com/services/rest";
NSString * const InterestingPhotosMethod = @"flickr.interestingness.getList";


@implementation FlickrAPI

+ (NSURL *)interestingPhotosURL {
    NSDictionary *parameters = @{@"extras":@"url_h,date_taken"};
    NSURL *url = [self flickrURLForMethod:InterestingPhotosMethod
                               parameters:parameters];
    return url;
}

/*!
 * Private method. Create NSURL from flick API method and parameters.
 * @param method - Flick API method name
 * @param params - dictionary containing query parameters
 * @return URL
 */
+ (NSURL *)flickrURLForMethod:(NSString *)method
                   parameters:(NSDictionary *)params {
    NSURLComponents *components = [NSURLComponents componentsWithString:BaseURLString];
    NSMutableArray *queryItems = [NSMutableArray array];
    
    NSMutableDictionary *allParams = [@{ @"method"         : method,
                                         @"format"         : @"json",
                                         @"nojsoncallback" : @"1",
                                         @"api_key"        : APIKey  } mutableCopy];
    [allParams addEntriesFromDictionary:params];
    
    for (NSString *queryKey in allParams.allKeys) {
        NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:queryKey
                                                                value:allParams[queryKey]];
        [queryItems addObject:queryItem];
    }
    
    components.queryItems = queryItems;
    return components.URL;
}


+ (NSArray *)photosFromJSONData:(NSData *)jsonData {
    
    NSMutableArray *photos = [NSMutableArray array];
    
    NSError *parseError = nil;
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:0
                                                      error:&parseError];
    
    if (jsonObject != nil) {
        // Get the jsonObject->"photos"->"photo", an array of dictionaries,
        // with each dictionary representing one photo
        NSDictionary *jsonPhotosDict = jsonObject[@"photos"];
        NSArray *jsonPhotosArray = jsonPhotosDict[@"photo"];
        for (NSDictionary *jsonSinglePhotoDict in jsonPhotosArray) {
            Photo *photo = [FlickrAPI photoFromJSON:jsonSinglePhotoDict];
            if (photo) {
                [photos addObject:photo];
            }
        }
    } else {
        NSLog(@"Failed to parse JSON data. Error: %@", parseError);
    }
    
    return photos;
}

/**
 * Parses the JSON representation of a single photo and creates a Photo model object.
 * @param jsonDict a JSON dictionary representing a single photo (from the "photos" array)
 * @return a Photo
 */
+ (Photo *)photoFromJSON:(NSDictionary *)jsonDict {
    
    NSString *photoID = jsonDict[@"id"];
    NSString *title   = jsonDict[@"title"];
    NSURL *URL        = [NSURL URLWithString:jsonDict[@"url_h"]];
    NSDate *dateTaken = [[FlickrAPI dateFormatter] dateFromString:jsonDict[@"datetaken"]];
    
    if (!photoID || !title || !URL || !dateTaken) {
        return nil;
    }
    
    Photo *photo = [[Photo alloc] initWithTitle:title
                                        photoID:photoID
                                      remoteURL:URL
                                      dateTaken:dateTaken];
    return photo;
}


// MARK: - Utility

+ (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *formatter = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.dateFormat = @"yyy-MM-dd HH:mm:ss";
    });
    
    return formatter;
}


@end
