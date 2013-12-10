//
//  PGViewControllerSelectMedia.h
//  PolynznGram
//
//  Created by sonny  on 10/8/13.
//  Copyright (c) 2013 PolyApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PGViewControllerSelectMedia : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *takePhoto;
@property (strong, nonatomic) IBOutlet UIButton *selectPhoto;
@property (strong, nonatomic) IBOutlet UIButton *addImage;

@end
