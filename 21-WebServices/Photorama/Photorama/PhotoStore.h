#import <UIKit/UIKit.h>
@class Photo;

/**
 * @class PhotoStore
 * @description  Store for photos. Responsible for initiating Flickr web
 *               service requests
 */
@interface PhotoStore : NSObject

/**
 * Connects to api.flickr.com and retrieves the list of interesting
 * photos.
 * @param completion Required completion handler
 */
- (void)fetchInterestingPhotosWithCompletion:(void(^)(NSArray *))completion;

/**
 * Fetch image for a Photo using its remoteURL
 * @param photo A Photo (required)
 * @param completion A completion handler (required)
 */
- (void)fetchImageForPhoto:(Photo *)photo
                completion:(void(^)(UIImage *))completion;

@end
