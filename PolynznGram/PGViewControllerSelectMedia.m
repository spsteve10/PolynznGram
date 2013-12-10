//
//  PGViewControllerSelectMedia.m
//  PolynznGram
//
//  Created by sonny  on 10/8/13.
//  Copyright (c) 2013 PolyApps. All rights reserved.
//

#import "PGViewControllerSelectMedia.h"

@interface PGViewControllerSelectMedia () <UIGestureRecognizerDelegate>

@end



@implementation PGViewControllerSelectMedia

@synthesize imageView = _imageView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self addGestureRecognizersToView:self.imageView];
    
	// Do any additional setup after loading the view.
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)addPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
        UIImageView *iview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 95, 149)];
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        iview.image = chosenImage;
        
        if(self.imageView.image == NULL)
         self.imageView.image = chosenImage;
        else
        {
            [self.imageView addSubview:iview ];
            self.imageView.userInteractionEnabled = YES;
            iview.userInteractionEnabled = YES;
            self.imageView.clipsToBounds = YES;
            [self.imageView bringSubviewToFront:iview];
            [self addGestureRecognizersToView:iview];
        }

        
        /*UIGraphicsBeginImageContext(self.imageView.image.size);
        [self.imageView.image drawInRect:CGRectMake(0,0,self.imageView.image.size.width,self.imageView.image.size.height)];
        [chosenImage drawInRect:CGRectMake(10,10,chosenImage.size.width,chosenImage.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        self.imageView.image = newImage;*/
        
        //return newImage;
       
        
        
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)addGestureRecognizersToView:(UIView *)view {
    view.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(onPan:)];
    panRecognizer.delegate = self;
    [view addGestureRecognizer:panRecognizer];
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(onPinch:)];
    pinchRecognizer.delegate = self;
    [view addGestureRecognizer:pinchRecognizer];
    
    UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                                   action:@selector(onRotate:)];
    rotationRecognizer.delegate = self;
    [view addGestureRecognizer:rotationRecognizer];
}

- (void)onPan:(UIPanGestureRecognizer *)pan {
    CGPoint offset = [pan translationInView:self.view];
    CGPoint center = pan.view.center;
    center.x += offset.x;
    center.y += offset.y;
    pan.view.center = center;
    
    [pan setTranslation:CGPointZero inView:self.view];
}

- (void)onPinch:(UIPinchGestureRecognizer *)pinch {
    CGFloat scale = [pinch scale];
    UIView *view = pinch.view;
    view.transform = CGAffineTransformScale(view.transform, scale, scale);
    [pinch setScale:1];
}

- (void)onRotate:(UIRotationGestureRecognizer *)rotation {
    CGFloat angle = [rotation rotation];
    rotation.view.transform = CGAffineTransformRotate(rotation.view.transform, angle);
    [rotation setRotation:0];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UISwipeGestureRecognizer class]]) {
        CGPoint touchPoint = [gestureRecognizer locationInView:self.view];
        UIView *hitTestView = [self.view hitTest:touchPoint withEvent:nil];
        if ([hitTestView isKindOfClass:[UIImageView class]]) {
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


@end
