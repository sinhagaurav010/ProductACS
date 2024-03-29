//
//  Global.h
//  City Guide
//
//  Created by Gaurav Sinha on 27/07/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import "UserLocationFinder.h"

#define TESTING 1


#define FIELDADD @"Address"
#define FIELDCOST @"Cost"
#define FIELDDEAL @"Deal"
#define FIELDDEALDES @"DealDesc"
#define FIELDDEALEXP @"DealExpires"
#define FIELDDESC @"Desc"
#define FIELDEMAIL @"Email"
#define FIELDIMAGES @"Images"
#define FIELDIMAGE @"Image"
#define FIELDLISTTYPE @"ListType"
#define FIELDNAME @"Name"
#define FIELDPHONE @"Phone"
#define FIELDTYPE @"Type"
#define FIELDURL @"URL"
#define FIELDLAT @"Lat"
#define FIELDLONG @"Long"

#define FACEBOOKAppSEC @"7e6f3e235b183cb2b24b69d414f09616"
#define FACEBOOKAppID @"308790145802337"

#define TYPECAT @"Cat"
#define TYPEFEAT @"Feat"

#define SAVEFAV @"FavACS"

BOOL isSaveToFav; 
#define TITTLELIST @"List"
#define HOMETITLE @"Home"

#define CATEGORY_FEED_URL @""
#define TAGFEED_URL @""


#define URLDATA @"http://sanganan.com/BackOfficeService.aspx"

#define IMAGEDATAACS @"imagedata"

#define VENUE_FEED_URL @""
#define IMAGE_GLOBAL_URL @""
#define VENUE_LOGO_GLOBAL_URL @""
#define DELAS_FEED_URL @""

#define TITLEFAV @"Favourites"
#define TITLENEAR @"NearBy"

#define RADIUS 8605

// This file Contains the global values 
#define CATEGORY_TABLE_NAME @"CategoryList"
#define TAG_TABLE_NAME @"TagList"
#define VENUE_LIST_TABLE @"VenueList"
#define DEAL_TABLE @"DealTable"
#define METRO_TABLE @"MetroTable"

#define NAVIGATION_BAR_COLOR [[UIColor alloc] initWithRed:0.40 green:0.42 blue:0.48 alpha:1.0]
#define LATSOURCE 51.502858
#define LONGSOURCE -0.150223
#define WEBLINK_VISIT @"Do you want to leave this application to open this website ?"
#define DIAL_A_NUMBER @"Do you want to dial this number ? "
#define KM @"km"


#define BARBUTTON(TITLE, SELECTOR) 	[[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR] autorelease]
#define SYSBARBUTTON(ITEM, SELECTOR) [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:ITEM target:self action:SELECTOR] autorelease]


#define MAPTITLE @"Map"

#define MIL @"mil"
#define DISTANCE_METER @"2"
#define FONT [UIFont fontWithName:@"Helvetica"  size:14];

NSMutableArray *arrayAllData;
//////////
BOOL KMselect;


#define LINKMAPURL @"maps://maps.google.com/maps?saddr=%@,%@&daddr=%@,%@"


NSMutableArray *sortingArray;
NSMutableString *listQueryString;

UserLocationFinder *locationUser;

NSString *latString ,*longtString;

NSMutableArray *imageArray;
NSMutableDictionary *imageDictionary;

BOOL isFilterOfMap;

NSMutableDictionary *filterDict;
NSMutableArray *dealsAllData;// Contains deals Tab all data
NSMutableArray *globalZoneArray;

//=============================================
// Global Array that contains all the values from the database
NSMutableArray *allDataArray;
BOOL isAllValueLoaded;
BOOL isGPS_On;

NSMutableArray *catDataArray,*tagDataArray;

//////////////////////////////////////////////
// Boolean that is used to check that used has made application purchase or not
