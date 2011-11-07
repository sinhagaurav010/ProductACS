//
//  DetailsViewController.m
//  ACSProduct
//
//  Created by preet dhillon on 16/10/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//


/*
 Address = "Lane 288 talking road,London";
 Cost = "120.00";
 Deal = "10%";
 DealDesc = "10% off in buisness special offer";
 DealExpires = 20Dec2011;
 Desc = "test london test london test london test london test london test london";
 Email = "info@acs.com";
 Images =     {
 Image =         (
 "http://londoncontemporaryart.files.wordpress.com/2009/02/london_art_fair_500_rgb.jpg",
 ImageLink2,
 ImageLink3
 );
 };
 ListType = Cat;
 Loc = London;
 Name = "288 The Melting Point";
 Phone = 1234532;
 Type = "Arts and Entertainment";
 URL = "http://www.acs.com";
 }
 
 */
/*
 Address = "Lane 288 talking road,London";
 Cost = "120.00";
 Deal = "10%";
 DealDesc = "10% off in buisness special offer";
 DealExpires = 20Dec2011;
 Desc = "test london test london test london test london test london test london";
 Email = "info@acs.com";
 Images =         {
 Image =             (
 "http://www.urban75.org/london/images/shunt-club-london-bridge-09.jpg",
 ImageLink2,
 ImageLink3
 );
 };
 Lat = "51.505858";
 ListType = Cat;
 Loc = London;
 Long = "-0.150461";
 Name = "288 The Melting Point";
 Phone = 1234532;
 Type = "Clubs and Bar";
 URL = "http://www.acs.com";
 */


#import "DetailsViewController.h"
#import "SA_OAuthTwitterEngine.h"
@implementation DetailsViewController
@synthesize dictInfo,isFromFav,stringTitle;
@synthesize loginDialog=_loginDialog,facebookName=_facebookName ,session=_session,posting=_posting,textOfTwitPost;

#define kOAuthConsumerKey @"PS8ZqNdOdUuqlWEadaSw"		//REPLACE With Twitter App OAuth Key  
#define kOAuthConsumerSecret @"hn8FPaMGdcKS0BvsTD9eJoXC65GxDHNzczuIRMowVs"		//REPLACE With Twitter App OAuth Secret

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



-(IBAction)touchForDeal:(id)sender
{
    DealsInfoViewController *dealsController = [[DealsInfoViewController alloc] init];
    dealsController.dictDealInfo = [[NSMutableDictionary alloc] initWithDictionary:dictInfo];
    [self.navigationController pushViewController:dealsController animated:YES];
    [dealsController release];
}
-(void)imageButtonClicked:(id)sender
{
    SlideShowViewController *myInfoScreenController = [[SlideShowViewController alloc]init];
    myInfoScreenController.arrayImagesSlide = [[dictInfo objectForKey:FIELDIMAGES] objectForKey:FIELDIMAGE];
	myInfoScreenController.hidesBottomBarWhenPushed = YES;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration: .75];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
	[[self navigationController] pushViewController:myInfoScreenController animated:NO];
	[UIView commitAnimations];
    
}
-(IBAction)touchForMap:(id)sender
{
    MapViewController *mapController = [[MapViewController alloc] init];
    mapController.isFromDetail = 1;
    mapController.arrayMapLocs = [[NSMutableArray alloc] init];
    [mapController.arrayMapLocs addObject:dictInfo];
    
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration: .75];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp
                           forView:self.navigationController.view 
                             cache:NO];
    [self.navigationController pushViewController:mapController animated:NO];
	[UIView commitAnimations];
    
    [mapController release];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    self.navigationItem.title = [dictInfo objectForKey:FIELDNAME];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(back)];
    self.navigationItem.leftBarButtonItem = saveButton;
    [saveButton release];
    
    if(isFromFav == 1)
        buttonFav.hidden = YES;
    
    UIBarButtonItem *imageButton = [[UIBarButtonItem alloc] initWithTitle:@"Images"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(imageButtonClicked:)];
    self.navigationItem.rightBarButtonItem = imageButton;
    [imageButton release];
	
    arrayInfo = [[NSMutableArray alloc] initWithArray:[[NSArray alloc]initWithObjects:@"Name",@"Address",@"Email",@"Phone",@"Url", nil]];
    tableInfo.backgroundView = nil;
    tableInfo.backgroundColor = [UIColor clearColor];
    
    [viewForWebView.layer setCornerRadius:35.0f];
    [viewForWebView.layer setMasksToBounds:YES];
    
    //    webViewInfo.backgroundColor = [UIColor colorWithRed:.96
    //                                                  green:.57
    //                                                   blue:.12
    //                                                  alpha:1.0];
    
    [webViewInfo loadHTMLString:[dictInfo objectForKey:FIELDDESC] baseURL:nil];
    
    //faceBook Api key
    
    static NSString* kApiKey =@"269931136375850";                     //@"267034743322029";
	static NSString* kApiSecret =  @"b06407f685cd601ac1ba2e3eecf872c9";                     //@"d05205f6b5c000764fb376366089ae10";
    

    _session = [[FBSession sessionForApplication:kApiKey secret:kApiSecret delegate:self] retain];
    
	// Load a previous session from disk if available.  Note this will call session:didLogin if a valid session exists.
    //    if([_session resume])
   // [_session resume];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

- (void)viewWillAppear:(BOOL)animated {
//    	if([_engine isAuthorized])
//    	{
//           // [_engine clearAccessToken];
//    		[self PostTweet:nil];
//    }
}


#pragma mafrk -add to Fav-
-(IBAction)touchToAddFav:(id)sender
{
    isSaveToFav = 1;
    NSMutableArray *arrayFav = [[NSMutableArray alloc] initWithArray:(NSMutableArray*)[ModalController getContforKey:SAVEFAV]];
    NSLog(@"%@",arrayFav);
    [arrayFav addObject:dictInfo];
    [ModalController saveTheContent:arrayFav withKey:SAVEFAV];
    [arrayFav release];
}

#pragma mark -mail composer-
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	[self dismissModalViewControllerAnimated:YES];
}


-(void)clickOn:(NSString *)stringEmailId withMsgBody:(NSString*)strbody
{
    //NSLog(@"clickon");
	NSArray *arrayRec = [NSArray arrayWithObjects:stringEmailId,nil];
    //NSLog(@"%d",[MFMailComposeViewController canSendMail]);
	if ([MFMailComposeViewController canSendMail])
	{
		MFMailComposeViewController *mcvc = [[[MFMailComposeViewController alloc] init] autorelease];
		mcvc.mailComposeDelegate = self;
		//[mcvc setSubject:EMAILSUB];
		[mcvc setToRecipients:arrayRec];
        //		NSString *messageBdy = [NSString stringWithFormat:@"Name %@<br>Phone %@ <br>Address %@<br>%@<br>City %@ <br>%@<br> %@<br>special features%@",textname.text,textphone.text,textAddress.text,buttonTime.titleLabel.text,textCity.text,buttonBed.titleLabel.text,buttonBath.titleLabel.text,textfea.text];
        if(strbody)
            [mcvc setMessageBody:strbody isHTML:NO];
		//[mcvc addAttachmentData:UIImageJPEGRepresentation(imageToEmail, 1.0f) mimeType:@"image/jpeg" fileName:@"pickerimage.jpg"];
		[self presentModalViewController:mcvc animated:YES];
	}	
    else
    {
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Info"
                                                           message:@"Please Configure Email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alerView show];
        [alerView release];
    }
}
#pragma mark -
#pragma mark - UITableView delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// The number of sections is based on the number of items in the data property list.
	return [arrayInfo count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [arrayInfo objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return 1;	
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 3:
        {
            NSString *stringURL = [NSString stringWithFormat:@"tel:%@",[dictInfo objectForKey:FIELDPHONE]];
            NSLog(@"%@",stringURL);
            NSURL *url = [NSURL URLWithString:stringURL];
            [[UIApplication sharedApplication] openURL:url];
        }
            break;
        case 4:
        {
            NSString *stringURL = [NSString stringWithFormat:[dictInfo objectForKey:FIELDURL]];
            NSLog(@"%@",stringURL);
            NSURL *url = [NSURL URLWithString:stringURL];
            [[UIApplication sharedApplication] openURL:url];
        }
            break;
        case 2:
        {
            [self clickOn:[dictInfo objectForKey:FIELDEMAIL] withMsgBody:nil];
        }
            break;
            
        default:
            break;
    }
    
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	
	// Retrieve or create a cell
	UITableViewCellStyle style =  UITableViewCellStyleDefault;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseCell"];
    if (!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"BaseCell"] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [dictInfo objectForKey:FIELDNAME];
            break;
        case 1:
            cell.textLabel.text = [dictInfo objectForKey:FIELDADD];
            break;
        case 2:
            cell.textLabel.text = [dictInfo objectForKey:FIELDEMAIL];
            break;
        case 3:
            cell.textLabel.text = [dictInfo objectForKey:FIELDPHONE];
            break;
        case 4:
            cell.textLabel.text = [dictInfo objectForKey:FIELDURL];
            break;
        default:
            break;
    }
    //	ListCell *cell = (ListCell *)[tableView dequeueReusableCellWithIdentifier:@"ListCell"];
    //	if (!cell) 
    //	{
    //		cell = [[[NSBundle mainBundle] loadNibNamed:@"ListCell" owner:self options:nil] lastObject];
    //		cell.backgroundColor=[UIColor whiteColor];
    //		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //	}
    //	
    //    
    //    cell.costLabel.text = [NSString stringWithFormat:@"$%@",[[arrayList objectAtIndex:indexPath.row] objectForKey:FIELDCOST]];
    //    cell.venueNameLabel.text = [[arrayList objectAtIndex:indexPath.row] objectForKey:FIELDNAME];
    //    cell.dealLabel.text = [[arrayList objectAtIndex:indexPath.row] objectForKey:FIELDDEAL];
    //    cell.distanceLabel.text = @" ";
    //    
    //    cell.venueImage.image = [(UIImageView*)[arrayImages objectAtIndex:indexPath.row] image];
    return (UITableViewCell *)cell;
	
}

#define mark -Integration of SocailNetworking-
-(IBAction)ShareFace:(id)sender
{
    NSLog(@"#############in connectFB");
    if (![_session isConnected]) {
        NSLog(@"@@@@@@@@@@@@@@@@in  session isconnected in facebookname");
		self.loginDialog = nil;
		_loginDialog = [[FBLoginDialog alloc] init];	
		[_loginDialog show];	
	}
    else
    {
        FBPermissionDialog *dialog = [[FBPermissionDialog alloc] init] ;
        dialog.tag=-1;
        dialog.delegate = self;
        dialog.permission = @"publish_stream";
        [dialog show];
        //  [self publishFeed];
    }
	// If we have a session and a name, post to the wall!
    //	else if (_facebookName != nil) {
    //        NSLog(@"in connectFB in facebookname");
    //        
    //        //[self publishFeed];
    //	}
    
}
-(IBAction)ShareTwitter:(id)sender
{
    
    // Twitter Initialization / Login Code Goes Here
    NSLog(@"in ShareTwitter ");
    
    if(!_engine){  
        _engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self];  
        _engine.consumerKey    = kOAuthConsumerKey;  
        _engine.consumerSecret = kOAuthConsumerSecret;  
    }  	
    
    if(![_engine isAuthorized])
    {  
        UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine:_engine delegate:self];  
        if (controller)
        {  
            [self presentModalViewController: controller animated: YES];  
        }  
    }    
    else{    
    NSLog(@"message on tweet ===[dictInfo objectForKey:FIELDDESC]%@",[dictInfo objectForKey:FIELDDESC]);
       // [_engine sendUpdate:[NSString stringWithFormat:@"%@",[dictInfo objectForKey:FIELDDESC]]];
		//str=@"";
		[self PostTweet:nil];
		NSLog(@"Twitter logged in");
    }
    
    
}
-(IBAction)EmailToFriend:(id)sender
{
    [self clickOn:nil   withMsgBody:[dictInfo objectForKey:FIELDDESC]];
}


-(IBAction)PostTweet:(id)sender
{
	UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Post Tweet Info" message:[NSString stringWithFormat:@"%@",[dictInfo objectForKey:FIELDDESC]] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
	
    
    [alert show];
	[alert release];
}
#pragma mark FBSessionDelegate methods

- (void)session:(FBSession*)session didLogin:(FBUID)uid {
    NSLog(@"uid________-------%llu",uid);
    FBPermissionDialog *dialog = [[FBPermissionDialog alloc] init] ;
    dialog.tag=-1;
    dialog.delegate = self;
    dialog.permission = @"publish_stream";
    [dialog show];
    // [self publishFeed];
    //	[self getFacebookName];
    //	[self postToWall];
    
    
}

- (void)dialogDidSucceed:(FBDialog*)dialog{
    if([dialog isKindOfClass:[FBPermissionDialog class]])
    {
        NSLog(@"her eiiii");
        [self publishFeed];
    }
}
- (void)publishFeed{
	
    //	categoryListArray = [[CategoryDataDict objectForKey:[keyArray objectAtIndex:whichSectionSelected]] copy];
    //	
    //	NSLog(@"[CategoryDataDict allValues] = %@",categoryListArray);
    //	[[categoryListArray objectAtIndex:whichRowSelected]getValue:&catDataStruct];
	
	//titleLabel.text = [NSString stringWithFormat:@"%@",p.newsTitle];
	//descriptionLabel.text = [NSString stringWithFormat:@"%@",p.newsDescription];
	//dateAndTimeLabel.text = [NSString stringWithFormat:@"%@",p.newsPubDate];
	NSString *tid=[NSString stringWithFormat:@"%l", _session.uid];
	NSString *body = [dictInfo objectForKey:FIELDDESC];
    //	if (isShareMail) {
    //		body = [NSString stringWithFormat:@"%@",[self flattenHTML:[detailsDictionary objectForKey:@"description"]]];
    //	}else {
    //		body = [NSString stringWithFormat:@"%@",[self flattenHTML:[[dealsDataArray objectAtIndex:dealsMailShowIndex] objectForKey:@"dealDetails"]]];
    //	}
	
	
    //  NSString *body    = [NSString stringWithFormat:@"%@",[self flattenHTML:[detailsDictionary objectForKey:@"description"]]];
	
	//  NSString *body    = @"This News is posted through News Paper App";
	
	//  float latitude = appDelegate.currentLocation.coordinate.latitude;
	//  float longitude = appDelegate.currentLocation.coordinate.longitude;
	
	// NSString *attach = [NSString stringWithFormat:@"{\"name\":\"Here I Am\",\"href\":\"http://maps.google.com/?q=%f,%f\",\"latitude\":\"%f\",\"longitude\":\"%f\",\"description\":\"Shared using GeoMashable on the iPad\",\"media\":[{\"type\":\"image\",\"src\":\"http://www.geomashable.com/images/icon.png\",\"href\":\"http://www.geomashable.com\"}],\"properties\":{\"Download\":{\"text\":\"Click here to Download now\",\"href\":\"http://www.geomashable.com\"}}}",latitude,longitude,latitude,longitude];
	
	// NSString *actionLinks = @"[{\"text\":\"iPhone\",\"href\":\"http://www.geomashable.com\"}]";
	// NSArray *obj = [NSArray arrayWithObjects:body,attach,actionLinks,[NSString stringWithFormat:@"%@", tid],nil];
	// NSArray *keys = [NSArray arrayWithObjects:@"message",@"attachment",@"action_links",@"target_id",nil];
	NSString *actionLinks = @"[{\"text\":\"iPhone\",\"href\":\"http://www.google.com\"}]";
	
	
    NSArray *obj = [NSArray arrayWithObjects:body,actionLinks,[NSString stringWithFormat:@"%@", tid],nil];
    NSArray *keys = [NSArray arrayWithObjects:@"message",@"action_links",@"target_id",nil];
    NSDictionary *params = [NSDictionary dictionaryWithObjects:obj forKeys:keys];
    [[FBRequest requestWithDelegate:self] call:@"facebook.stream.publish" params:params];
}


- (void)session:(FBSession*)session willLogout:(FBUID)uid {
	//_logoutButton.hidden = YES;
    _facebookName = nil;
}

#pragma mark Get Facebook Name Helper

- (void)getFacebookName {
    
    NSLog(@"in getFacebookName");
	NSString* fql = [NSString stringWithFormat:
					 @"select uid,name from user where uid == %lld", _session.uid];
	NSDictionary* params = [NSDictionary dictionaryWithObject:fql forKey:@"query"];
	[[FBRequest requestWithDelegate:self] call:@"facebook.fql.query" params:params];
}

#pragma mark FBRequestDelegate methods

- (void)request:(FBRequest*)request didLoad:(id)result {
	if ([request.method isEqualToString:@"facebook.fql.query"]) {
		NSArray* users = result;
		NSDictionary* user = [users objectAtIndex:0];
		NSString* name = [user objectForKey:@"name"];
        NSLog(@"$$$$$$$$$$$$$$$$$$ name in facebook====%@",name);
		self.facebookName = name;	
        //		_logoutButton.hidden = NO;
        //		[_logoutButton setTitle:[NSString stringWithFormat:@"Facebook: Logout as %@", name] forState:UIControlStateNormal];
        if (_posting) {
			[self postToWall];
            _posting = NO;
		}
	}
}

#pragma mark Post to Wall Helper

- (void)postToWall {
	NSLog(@"in post wall of facebook");
	
        FBStreamDialog* dialog = [[[FBStreamDialog alloc] init] autorelease];
    	dialog.userMessagePrompt = @"Enter your message:";
    // dialog.actionLinks = @"[{\"text\":\"Get MyGrades!\",\"href\":\"http://www.raywenderlich.com/\"}]";
    // dialog.attachment = [NSString stringWithFormat:@"{\"name\":\"%@ days %@ hours %@ minutes Mayan Calendar End and Beyond from @2012MayanAlarm iPhone® App\"}"];
    // dialog.actionLinks=@"UPDATE from http://2012mayanalarm.com";
    
    [dialog show];
}


#pragma mark SA_OAuthTwitterEngineDelegate
- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
    
	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}

//=============================================================================================================================
#pragma mark TwitterEngineDelegate
- (void) requestSucceeded: (NSString *) requestIdentifier {
	NSLog(@"Request %@ succeeded", requestIdentifier);
}

- (void) requestFailed: (NSString *) requestIdentifier withError: (NSError *) error {
	NSLog(@"Request %@ failed with error: %@", requestIdentifier, error);
}


#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)actionsheet clickedButtonAtIndex:(NSInteger)buttonIndex { 
	if(buttonIndex==1)
	{
       [_engine sendUpdate:actionsheet.message];
        NSLog(@"%@",actionsheet.message);        
	}
    if([_engine isAuthorized])
    {
        [_engine clearAccessToken];
    }
}



- (void)viewDidUnload
{
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
