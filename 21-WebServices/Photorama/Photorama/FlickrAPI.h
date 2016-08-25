#import <Foundation/Foundation.h>

/**
 * @class FlickrAPI
 * @description  Contains all the knowledge and logic that is specific
 *               to the Flickr web service.
 */
@interface FlickrAPI : NSObject

/**
 * Processes the JSON data received from Flickr.
 * @param jsonData - an NSData JSON object received
 * @return An array of Photo objects
 */
+ (NSArray *)photosFromJSONData:(NSData *)jsonData;

/** @return URL for Flickr Interesting Photos API method */
+ (NSURL *)interestingPhotosURL;

@end
