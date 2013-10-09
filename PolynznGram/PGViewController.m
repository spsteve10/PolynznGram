//
//  PGViewController.m
//  PolynznGram
//
//  Created by sonny  on 10/1/13.
//  Copyright (c) 2013 PolyApps. All rights reserved.
//

#import "PGViewController.h"

@interface PGViewController ()

@property (nonatomic) NSString* loginSource;

@end

@implementation PGViewController

@synthesize loginSource = _loginSource;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction) LoginSelected: (UIButton *)sender
{
    self.loginSource = @"facebook";
}

@end
