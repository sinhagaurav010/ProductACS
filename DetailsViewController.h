//
//  DetailsViewController.h
//  ACSProduct
//
//  Created by preet dhillon on 16/10/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#import <QuartzCore/QuartzCore.h>
#import "DealsInfoViewController.h"
#import "ModalController.h"
#import "SlideShowViewController.h"
#import "MapViewController.h"
#import <MessageUI/MessageUI.h>
#import "FBConnect/FBConnect.h"
#import "FBConnect/FBSession.h"
#import "SA_OAuthTwitterController.h"

@class SA_OAuthTwitterEngine;

@interface DetailsViewController : UIViewController<MFMailComposeViewControllerDelegate,FBSessionDelegate,FBRequestDelegate,SA_OAuthTwitterControllerDelegate,FBDialogDelegate>
{
    IBOutlet UIView *viewForWebView;
    IBOutlet UIWebView *webViewInfo;
    NSMutableArray *arrayTableInfo;
    IBOutlet UITableView *tableInfo;
    NSMutableArray *arrayInfo;
    IBOutlet UIButton *buttonFav;
    IBOutlet UIButton *buttonEail;
    IBOutlet UIButton *buttonFaceBook;
    IBOutlet UIButton *buttonTwitter;
    
    FBSession* _session;
	FBLoginDialog *_loginDialog;
	NSString *_facebookName;
    BOOL _posting;
    
    SA_OAuthTwitterEngine *_engine;
    
}

- (void)publishFeed;



-(void)clickOn:(NSString *)stringEmailId withMsgBody:(NSString*)strbody;
@property (nonatomic, retain) FBSession *session;
@property (nonatomic, retain) FBLoginDialog *loginDialog;
@property (nonatomic, copy) NSString *facebookName;
@property (nonatomic, assign) BOOL posting;
- (void)getFacebookName ;
- (void)postToWall;

@property(retain) NSString *textOfTwitPost;
@property(assign)BOOL isFromFav;
-(IBAction)touchToAddFav:(id)sender;
-(IBAction)ShareFace:(id)sender;
-(IBAction)ShareTwitter:(id)sender;
-(IBAction)EmailToFriend:(id)sender;

-(IBAction)touchForDeal:(id)sender;
-(IBAction)touchForMap:(id)sender;
@property(retain) NSString *stringTitle;
@property(retain) NSMutableDictionary *dictInfo;
-(void)PostTweet:(id)sender;

@end
