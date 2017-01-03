#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "MBProgressHUD.h"

@interface FLImageView : UIView
@property (assign, nonatomic) UIImage *originalImage;
-(UIImage *)image;
@end

@interface FLHubPhotoViewController : UIViewController
@property (assign, nonatomic) FLImageView *imageView;
@end

@interface FLVideoContentView : UIView
@property (assign, nonatomic) NSURL *videoURL;
@end

@interface FLBaseContentHolderView : UIView
@property (assign, nonatomic) FLVideoContentView *videoView; 
@end

@interface FLPostCollectionViewCell : UIView
@property (assign, nonatomic) FLBaseContentHolderView *postView;
@end

@interface FLCollageSinglePhotoView : UIView
@property (assign, nonatomic) FLImageView* photoView;
@end

@interface FLCollageSinglePhotoViewController : UIViewController
@property (assign, nonatomic) FLCollageSinglePhotoView* photoView;
@end

@interface FLPollSinglePhotoViewController : UIViewController
@property (assign, nonatomic) FLImageView *photoView;
@end

%hook FLHubPhotoViewController

-(void)viewDidLoad
{
	UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
		initWithTarget:self 
		action:@selector(handleLongPress:)];
	longPress.minimumPressDuration = 1.5;
	[self.view addGestureRecognizer:longPress];
	%orig;
}

%new
-(void)handleLongPress:(UILongPressGestureRecognizer *)sender
{
	UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

	[actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

        // Cancel button tappped.
		[self dismissViewControllerAnimated:YES completion:^{
		}];
	}]];

	[actionSheet addAction:[UIAlertAction actionWithTitle:@"Save Image" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

		UIImage *snapshot = self.imageView.originalImage;

		[[PHPhotoLibrary sharedPhotoLibrary] performChanges:^
		{
			PHAssetChangeRequest *changeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:snapshot];
			changeRequest.creationDate          = [NSDate date];
		} 
		completionHandler:^(BOOL success, NSError *error) 
		{
			if (success) 
			{
				NSLog(@"successfully saved");
			}
			else 
			{
				NSLog(@"error saving to photos: %@", error);
			}
		}];

		[self dismissViewControllerAnimated:YES completion:^{
		}];
	}]];

    // Present action sheet.
	[self presentViewController:actionSheet animated:YES completion:nil];
}

%end


@interface FLPhotoDetailViewController : UIViewController
@property (assign, nonatomic) FLImageView *photoView;
@end

%hook FLPhotoDetailViewController

-(void)viewDidLoad
{
	UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
		initWithTarget:self 
		action:@selector(handleLongPress:)];
	longPress.minimumPressDuration = 1.5;
	[self.view addGestureRecognizer:longPress];
	%orig;
}



%new
-(void)handleLongPress:(UILongPressGestureRecognizer *)sender
{
	UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

	[actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

        // Cancel button tappped.
		[self dismissViewControllerAnimated:YES completion:^{
		}];
	}]];

	[actionSheet addAction:[UIAlertAction actionWithTitle:@"Save Image" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

		UIImage *snapshot = [self.photoView image];

		[[PHPhotoLibrary sharedPhotoLibrary] performChanges:^
		{
			PHAssetChangeRequest *changeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:snapshot];
			changeRequest.creationDate          = [NSDate date];
		} 
		completionHandler:^(BOOL success, NSError *error) 
		{
			if (success) 
			{
				NSLog(@"successfully saved");
			}
			else 
			{
				NSLog(@"error saving to photos: %@", error);
			}
		}];

		[self dismissViewControllerAnimated:YES completion:^{
		}];
	}]];

    // Present action sheet.
	[self presentViewController:actionSheet animated:YES completion:nil];
}

%end

%hook FLCollageSinglePhotoViewController

-(void)viewDidLoad
{
	UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
		initWithTarget:self 
		action:@selector(handleLongPress:)];
	longPress.minimumPressDuration = 1.5;
	[self.view addGestureRecognizer:longPress];
	%orig;
}

%new
-(void)handleLongPress:(UILongPressGestureRecognizer *)sender
{
	UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

	[actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

        // Cancel button tappped.
		[self  dismissViewControllerAnimated:YES completion:^{
		}];
	}]];

	[actionSheet addAction:[UIAlertAction actionWithTitle:@"Save Image" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

		UIImage *snapshot = self.photoView.photoView.originalImage;

		[[PHPhotoLibrary sharedPhotoLibrary] performChanges:^
		{
			PHAssetChangeRequest *changeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:snapshot];
			changeRequest.creationDate          = [NSDate date];
		} 
		completionHandler:^(BOOL success, NSError *error) 
		{
			if (success) 
			{
				NSLog(@"successfully saved");
			}
			else 
			{
				NSLog(@"error saving to photos: %@", error);
			}
		}];

		[self  dismissViewControllerAnimated:YES completion:^{
		}];
	}]];

    // Present action sheet.
	[self  presentViewController:actionSheet animated:YES completion:nil];
}

%end


%hook FLPollSinglePhotoViewController

-(void)viewDidLoad
{
	UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
		initWithTarget:self 
		action:@selector(handleLongPress:)];
	longPress.minimumPressDuration = 1.5;
	[self.view addGestureRecognizer:longPress];
	%orig;
}

%new
-(void)handleLongPress:(UILongPressGestureRecognizer *)sender
{
	UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

	[actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

        // Cancel button tappped.
		[self  dismissViewControllerAnimated:YES completion:^{
		}];
	}]];

	[actionSheet addAction:[UIAlertAction actionWithTitle:@"Save Image" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

		UIImage *snapshot = self.photoView.originalImage;

		[[PHPhotoLibrary sharedPhotoLibrary] performChanges:^
		{
			PHAssetChangeRequest *changeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:snapshot];
			changeRequest.creationDate          = [NSDate date];
		} 
		completionHandler:^(BOOL success, NSError *error) 
		{
			if (success) 
			{
				NSLog(@"successfully saved");
			}
			else 
			{
				NSLog(@"error saving to photos: %@", error);
			}
		}];

		[self  dismissViewControllerAnimated:YES completion:^{
		}];
	}]];

    // Present action sheet.
	[self  presentViewController:actionSheet animated:YES completion:nil];
}

%end

// IGNORE ABOVE. SAVES IMAGES 
//FLAVPlayerLayerView
//FLHubVideoCollection
//FLVideoContentHolderVIew


%hook FLPostCollectionViewCell

-(void)setPostView:(FLBaseContentHolderView *)holderView
{
	if([holderView respondsToSelector:@selector(videoView)])
	{
		if(holderView.videoView.videoURL)
		{
			UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(downloadVideo:)];
			doubleTap.numberOfTapsRequired = 3; 
			[self addGestureRecognizer:doubleTap];
		}
	}
	%orig;
}

%new
-(void)downloadVideo:(UITapGestureRecognizer *)sender
{
	[sender setEnabled:NO];
	NSLog(@"DOWNLOAD FROM URL: %@", self.postView.videoView.videoURL);
	UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

	[actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
		[sender setEnabled:YES];
        // Cancel button tappped.
		[[[UIApplication sharedApplication] keyWindow].rootViewController  dismissViewControllerAnimated:YES completion:^{
		}];
	}]];

	[actionSheet addAction:[UIAlertAction actionWithTitle:@"Save Video" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
		MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
		hud.label.text = @"Downloading";
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
			NSLog(@"Downloading Started");
			NSURL  *url = self.postView.videoView.videoURL;
			NSData *urlData = [NSData dataWithContentsOfURL:url];
			if ( urlData )
			{
				NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
				NSString  *documentsDirectory = [paths objectAtIndex:0];

				NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"tempVideo.mp4"];

				dispatch_async(dispatch_get_main_queue(), ^{
					hud.label.text = @"Saving";
					[urlData writeToFile:filePath atomically:YES];
					NSLog(@"File Saved !");
					hud.label.text = @"Importing";
					[sender setEnabled:YES];
					NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
					NSString  *documentsDirectory = [paths objectAtIndex:0];
					[[[ALAssetsLibrary alloc] init] writeVideoAtPathToSavedPhotosAlbum:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", documentsDirectory,@"tempVideo.mp4"]] completionBlock:^(NSURL *assetURL, NSError *error) {

						if(assetURL) {
							hud.label.text = @"DONE!";
							[hud hideAnimated:YES];
						} else {
							hud.label.text = @"ERROR. Try Again.";
						}
					}];


				});
			}

		});

		[[[UIApplication sharedApplication] keyWindow].rootViewController dismissViewControllerAnimated:YES completion:^{
			
		}];
	}]];

    // Present action sheet.
	[[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:actionSheet animated:YES completion:nil];
}

%end