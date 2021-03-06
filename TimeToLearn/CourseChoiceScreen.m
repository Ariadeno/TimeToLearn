//
//  CourseChoiceScreen.m
//  TimeToLearn
//
//  Created by admin on 5/8/14.
//  Copyright (c) 2014 TIS. All rights reserved.
//

#import "CourseChoiceScreen.h"

@interface CourseChoiceScreen ()

@end

@implementation CourseChoiceScreen

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
    CALayer *btnLayer = [_videoBtn layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    CALayer *btnLayer2 = [_magazineBtn layer];
    [btnLayer2 setMasksToBounds:YES];
    [btnLayer2 setCornerRadius:5.0f];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    for (Les* les in self.currentCursus.lessen){
        if(les.voltooid == NO){
            self.currentLes = les;
            return;
        }
    }
    
    [self performSegueWithIdentifier:@"pushBackToCoursesOverview" sender:self];
}

- (IBAction)btnMagazine:(id)sender
{
    [self performSegueWithIdentifier:@"pushToMagazineScreen" sender:self];
}

- (IBAction)btnVideo:(id)sender
{
    [self performSegueWithIdentifier:@"pushToVideoScreen" sender:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqual:@"pushToMagazineScreen"]){
        MagazineScreen *mags = (MagazineScreen*)[segue destinationViewController];
        mags.currentCursus = self.currentCursus;
        mags.currentGebruiker = self.currentGebruiker;
        mags.currentLes = self.currentLes;
    } else {
        if([segue.identifier isEqual:@"pushToVideoScreen"]){
            VideoScreen *vids = (VideoScreen*)[segue destinationViewController];
            vids.currentCursus = self.currentCursus;
            vids.currentGebruiker = self.currentGebruiker;
            vids.currentLes = self.currentLes;
        } else {
            if([segue.identifier isEqualToString:@"pushBackToCoursesOverview"]){
                CoursesOverview *co = (CoursesOverview*)[segue destinationViewController];
                co.currentGebruiker = self.currentGebruiker;
                co.toCursus = self.currentCursus;
            }
        }
    }
}

@end
