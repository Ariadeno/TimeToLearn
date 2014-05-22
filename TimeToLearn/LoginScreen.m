//
//  LoginScreen.m
//  TimeToLearn
//
//  Created by admin on 5/8/14.
//  Copyright (c) 2014 TIS. All rights reserved.
//

#import "LoginScreen.h"


@interface LoginScreen ()

@end

@implementation LoginScreen

@synthesize txtGebruikersnaam;
@synthesize txtWachtwoord;

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
    CALayer *btnLayer = [_btnLogIn layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)inloggen:(id)sender {
    if([txtGebruikersnaam.text isEqual:@"test"] && [txtWachtwoord.text isEqual:@"test"]){
        [self initializeObjects];
        [self performSegueWithIdentifier:@"pushToCoursesOverview" sender:self];
    } else {
        UIAlertView *alertView =
        [[UIAlertView alloc] initWithTitle:@"Inloggegevens" message:[NSString stringWithFormat:@"Combinatie van gebruikersnaam en wachtwoord niet correct."] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
}

- (void)initializeObjects {
    TopNavigationController* controller = (TopNavigationController*)[[self navigationController] topViewController];
    Class classGebruiker = [Gebruiker class];
    Class classBericht = [Bericht class];
    Class classCursus = [Cursus class];
    Class classVraag = [Vraag class];
    Class classVraagOptie = [VraagOptie class];
    
    [self loadJsonData:@"http://beta.morgen-media.nl/timetolearn/gebruikers.php" objectType:classGebruiker];
}

- (void) loadJsonData:(NSString*)url objectType:(Class)type
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self parseJsonData:responseObject objectType:type];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void) parseJsonData:(id)responseObject objectType:(Class)type
{
    NSArray* dictObjects = [responseObject allObjects];
    NSDictionary *dictionary = [responseObject dictionaryForKey:@"user"];
    NSDictionary* allSubObjects = [dictObjects objectAtIndex:0];
    //NSArray* dictSubObjects = [allSubObjects allKeys];
    
    /*for(NSDictionary* dict in responseObject){
        
    }*/
    
    //keys = [nsdict allKeys];
    for(id dict in allSubObjects){
        NSLog([[dict class] description]);
        for(id dictin in dict){
            NSLog([[dictin class] description]);
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([txtGebruikersnaam isFirstResponder] && [touch view] != txtGebruikersnaam) {
        [txtGebruikersnaam resignFirstResponder];
        [super touchesBegan:touches withEvent:event];
    }
    
    if([txtWachtwoord isFirstResponder] && [touch view] != txtWachtwoord) {
        [txtWachtwoord resignFirstResponder];
        [super touchesBegan:touches withEvent:event];
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
