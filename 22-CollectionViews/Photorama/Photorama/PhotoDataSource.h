

#import <UIKit/UIKit.h>

/**
 * @class PhotoDataSource
 * Responsible for responding to the data source questions
 */
@interface PhotoDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, copy) NSArray *photos;

- (instancetype)initWithPhotos:(NSArray *)photos NS_DESIGNATED_INITIALIZER;

@end
