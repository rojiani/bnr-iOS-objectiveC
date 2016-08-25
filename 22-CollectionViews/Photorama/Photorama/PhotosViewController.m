
#import "PhotosViewController.h"
#import "PhotoStore.h"
#import "PhotoDataSource.h"
#import "Photo.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoInfoViewController.h"

@interface PhotosViewController ()
@property (nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) PhotoDataSource  *photoDataSource;
@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Set the data source on the collection view
    self.photoDataSource = [PhotoDataSource new];
    self.collectionView.dataSource = self.photoDataSource;
    // Set UICollectionViewDelegate property
    self.collectionView.delegate = self;

    // start web service exchange when VC comes on screen
    // completion handler invoked in PhotoStore's fetch... method
    [self.photoStore fetchInterestingPhotosWithCompletion:^(NSArray *photos) {
        NSLog(@"Found %lu photos", (unsigned long)photos.count);

        if (photos.count == 0) {
            NSLog(@"Zero photos! Sad times.");
            return;
        }

        // UI Update must be done on the main thread (p. 323)
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // pass photos array to PhotoDataSource (note: PhotoDataSource has the photos array,
            // not PhotoStore)
            self.photoDataSource.photos = photos;
            // reload the collection view's cells
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        }];
    }];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowPhoto"]) {
        NSIndexPath *selectedIndexPath =
            [self.collectionView indexPathsForSelectedItems].firstObject;
        Photo *photo = self.photoDataSource.photos[selectedIndexPath.row];

        PhotoInfoViewController *destinationVC = segue.destinationViewController;
        destinationVC.photoStore = self.photoStore;
        destinationVC.photo = photo;
    }
}


// Override to download images when they will be visible (p. 336)
- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {

    Photo *photo = self.photoDataSource.photos[indexPath.row];

    // Download the image data, which could take some time
    [self.photoStore fetchImageForPhoto:photo
                             completion:^(UIImage *image) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // The index path for the photo might have changed between the
            // time the request started and finished, so find the most
            // recent index path
            NSUInteger photoIndex = [self.photoDataSource.photos indexOfObject:photo];
            NSIndexPath *photoIndexPath = [NSIndexPath indexPathForItem:photoIndex
                                                              inSection:0];

            // When the request finishes, update the cell
            PhotoCollectionViewCell *photoCell =
                (PhotoCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:photoIndexPath];
            [photoCell updateWithImage:image];
        }];
    }];
}

@end
