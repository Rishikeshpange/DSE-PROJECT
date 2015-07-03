

//
//  LoginViewController.m
//  test
//
//  Created by admin on 02/03/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//
#import "RequestDelegate.h"
#import "TBXML.h"
#import "DetailViewController.h"
#import "MBProgressHUD.h"
#import "LoginViewController.h"
#import "SSKeychain.h"
#import "SSKeychainQuery.h"

//#import "AppDelegate.h"
@interface LoginViewController ()
{
    NSString *userName,*passWord;
      NSArray *logingetUD;
      int *imageflag;
}
@end

@implementation LoginViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"login..");
    imageflag=0;
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
     [self.Btnremeberme setImage: [UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
   
//    self.username.text=@"JJOSHI1001680";
//    self.password.text=@"TATA2015";
    
    [self.username setBackgroundColor:[UIColor clearColor]];
    [self.username.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.username.layer setBorderWidth:1.0];
    [self.username.layer setCornerRadius:16.0f];
    self.username.textAlignment = NSTextAlignmentCenter;
    if ([self.username respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        self.username.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"USER ID" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
    // self.username.placeholder = @"Username";
    
    [self.password setBackgroundColor:[UIColor clearColor]];
    [self.password.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.password.layer setBorderWidth:1.0];
    [self.password.layer setCornerRadius:16.0f];
    self.password.placeholder = @"Password";
    self.password.textAlignment = NSTextAlignmentCenter;
    if ([self.password respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        self.password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"PASSWORD" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
    self.LoginButton.layer.cornerRadius = 16; // this value vary as per your desire
    self.LoginButton.clipsToBounds = YES;
    
    
    globalVariables_ = [ [ GlobalVariables alloc ]init];
    userDetailsVal_ = [UserDetails_Var sharedmanager];
    if (!GlobalVariablesArray_){
        GlobalVariablesArray_ = [[NSMutableArray alloc]init];
    }
    else{
        [GlobalVariablesArray_ removeAllObjects];
    }
    
    NSString *password = [SSKeychain passwordForService:@"AnyService" account:@"AnyUser"];
    NSString *usernamme = [SSKeychain passwordForService:@"AnyService" account:@"AnyUser1"];
    
      NSLog(@"username & Password Save:%@ %@",usernamme,password);
    
    self.username.text=usernamme;
    self.password.text=password;
    
    
    if(!usernamme)
    {
        
        [self.Btnremeberme setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        
    }
    else{
        
         [self.Btnremeberme setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
       // self.Btnremeberme.image=[UIImage imageNamed:@"checked.png"];
        imageflag=1;
    }
   // [self callArtifactRequest];

  // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"\n View Will Appear.....");
    
    // [[NSNotificationCenter defaultCenter]removeObserver:self name:@"artifactFound" object:nil];
    //  [[NSNotificationCenter defaultCenter]removeObserver:self name:@"artifactFailed" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(artifactFound:) name:@"artifactFound" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(artifactFailed:) name:@"artifactFailed" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(authenticateOIDFound:) name:@"authenticateOIDFound" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestDateFound:) name:@"requestDateFound" object:nil];//Abhishek //For Date
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userDetailsFound:) name:@"userDetailsFound" object:nil];//Abhishek //For use details
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userDetailsFailed:) name:@"userDetailsFailed" object:nil];//Abhishek //For use details
    
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSLog(@"\nView Did Dissapears...!!!!");
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"artifactFound" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"artifactFailed" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"authenticateOIDFound" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"requestDateFound" object:nil];//abhishek // For Date
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"userDetailsFound" object:nil];//abhishek // For Date
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"userDetailsFailed" object:nil];//abhishek // For userdetails
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginScreeb:(id)sender {
    
    
     [self showAlert];
    if(self.username.text.length==0 || self.password.text.length==0)
    {
        [self hideAlert];
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Please enter USER ID and PASSWORD correctly" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else{
        
        if(imageflag==0)
        {
            [SSKeychain setPassword:@"" forService:@"AnyService" account:@"AnyUser"];
            [SSKeychain setPassword:@"" forService:@"AnyService" account:@"AnyUser1"];
        }
        else{
            
            
            [SSKeychain setPassword:self.password.text forService:@"AnyService" account:@"AnyUser"];
            [SSKeychain setPassword:self.username.text forService:@"AnyService" account:@"AnyUser1"];
            
        }
        

        [self callArtifactRequest];
        
        userName=self.username.text;
        passWord=self.password.text;
        NSLog(@"Username : - %@",self.username.text);
        NSLog(@"Password : - %@",self.password.text);
    }

    
    /*
//    AppDelegate* app_delegate=[[UIApplication sharedApplication] delegate];
////    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
////    UISplitViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SplitView"];
//    //self.window = [[UIApplication sharedApplication] keyWindow];
//    app_delegate.window.rootViewController= vc;
    
   
    userName=self.username.text;
    passWord=self.password.text;
    NSLog(@"Username : - %@",userName);
    NSLog(@"Password : - %@",passWord);
    
//    AppDelegate* app_delegate=[[UIApplication sharedApplication] delegate];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//    UISplitViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SplitView"];
//    //self.window = [[UIApplication sharedApplication] keyWindow];
//    app_delegate.window.rootViewController= vc;

    
   if(appdelegate.artifact.length > 0)
    {
        [self showAlert];
        [self callDateRequest];
        [self CallUserDetails];
        [self callauthenticateOIDRequest];
    }
    else
    {
        NSLog(@"SamlArt Not found's.....");
        
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"The internet connection seems to be offline!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"] animated:NO];
    }
    */
    
    /*
     
     NSLog(@"PostData: %@",post);

     NSURL *url=[NSURL URLWithString:@"http://192.168.1.104:82/WebServices/ValidateUser.svc/Validate"];
     
     NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
     
     NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
     
     NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
     [request setURL:url];
     [request setHTTPMethod:@"POST"];
     [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
     [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
     //[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Accept"];
     [request setHTTPBody:postData];
     
     NSLog(@"Request URL is: %@", request);
     
     NSError *error = [[NSError alloc] init];
     NSHTTPURLResponse *response = nil;
     NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
     
     NSLog(@"Response code: %ld", (long)[response statusCode]);
     
     if ([response statusCode] >= 200 && [response statusCode] < 300)
     {
     NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
     
     NSLog(@"Response ==> %@", responseData);
     
     NSError *error = nil;
     
     BOOL isTurnableToJSON = [NSJSONSerialization isValidJSONObject:urlData];
     
     if (isTurnableToJSON){
     
     NSLog(@"Is Valid Json Object");
     
     }else{
     
     NSLog(@"Is not valid Json Object");
     
     }
     
     NSDictionary *jsonData = [NSJSONSerialization
     JSONObjectWithData:urlData
     options:NSJSONReadingMutableContainers
     error:&error];
     
     NSLog(@" Json data is : %@",jsonData);
     }

     */

    /*
   AppDelegate *ad = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSLog(@"Close");
    ad.authenticated = YES;
    [self dismissViewControllerAnimated:NO completion:nil];
    */
    //AppDelegate* app_delegate=[[UIApplication sharedApplication] delegate];
    //    //self.window = [[UIApplication sharedApplication] keyWindow];
    //   // app_delegate.window.rootViewController= app_delegate.splitViewController;
    //      [self.navigationController pushViewController:app_delegate.splitViewController animated:YES];
    //
    //    AppDelegate* app_delegate=[[UIApplication sharedApplication] delegate];
    
  //  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
  //  UISplitViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SplitView"];
    //self.window = [[UIApplication sharedApplication] keyWindow];
  //  app_delegate.window.rootViewController= vc;

    

   // [self dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)btnRemember:(id)sender {
    
    if(imageflag==0)
    {
        
        [self.Btnremeberme setImage: [UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        
        
        [SSKeychain setPassword:self.password.text forService:@"AnyService" account:@"AnyUser"];
        [SSKeychain setPassword:self.username.text forService:@"AnyService" account:@"AnyUser1"];
        
        
        NSLog(@"Remember mi ");
        imageflag=1;
    }
    else{
        
        
        [self.Btnremeberme setImage: [UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        imageflag=0;
        
        
        
        
    }
    
    
    NSLog(@"Remember mi ");
    
    
    
    
    /*
     NSLog(@"Click...Remember");
     [[NSUserDefaults standardUserDefaults] setValue:self.username.text forKey:@"username"];
     [[NSUserDefaults standardUserDefaults] setValue:self.password.text forKey:@"password"];
     [[NSUserDefaults standardUserDefaults] synchronize];
     */
}


-(void)callArtifactRequest
{
//    JJOSHI1001680
//    NANO2014
    
    // NSString *loginServices1 = @"{\"objBasicDetails\":{\"UserName\":\"YMANGAT3000380\",\"USER_PASS\":\"NANO2015\"}}";
//    NSString *envelopeText = @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\"><SOAP:Body><GetWebAuthByKey xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.tmwebauthwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\"><key>mob123</key></GetWebAuthByKey></SOAP:Body></SOAP:Envelope>";
      NSString *envelopeText = @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\"><SOAP:Body><GetWebAuthByKey xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.tmwebauthwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\"><key>NeevMobOne</key></GetWebAuthByKey></SOAP:Body></SOAP:Envelope>";
    //use for SAMSONJ1001680 dse project for usrname and TML2015 For pwd
    NSString * envelopeText1 = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
    @"<SOAP:Header>"
    @"<wsse:Security xmlns:wsse=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd\">"
    @"<wsse:UsernameToken xmlns:wsse=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd\">"
    @"<wsse:Username>%@</wsse:Username>"
    @"<wsse:Password>%@</wsse:Password>"
    @"</wsse:UsernameToken>"
    @"</wsse:Security>"
    @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
    @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\"/>"
    @"</header>"
    @"</SOAP:Header>"
    @"<SOAP:Body>"
    @"<samlp:Request xmlns:samlp=\"urn:oasis:names:tc:SAML:1.0:protocol\" MajorVersion=\"1\" MinorVersion=\"1\" IssueInstant=\"2010-05-03T06:53:51Z\" RequestID=\"aa23159489-0126-1853-28ca-d7024556c36\">"
    @"<samlp:AuthenticationQuery>"
    @"<saml:Subject xmlns:saml=\"urn:oasis:names:tc:SAML:1.0:assertion\">"
    @"<saml:NameIdentifier Format=\"urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified\">%@</saml:NameIdentifier>"
    @"</saml:Subject>"
    @"</samlp:AuthenticationQuery>"
    @"</samlp:Request>"
    @"</SOAP:Body>"
    @"</SOAP:Envelope>",self.username.text,self.password.text,self.username.text];
    
    /*
     NSString * envelopeText = [NSString stringWithFormat:
     
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
     @"<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">\n"
     @"<soap:Body>"
     @"<S_UserAlertList xmlns=\"Mimic_WCFService\">"
     @"<sJSON>%@</sJSON>"
     @"</S_UserAlertList>"
     @"</soap:Body>"
     @"</soap:Envelope>",loginServices1];*/
    
    //    @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
    //
    //    @"<SOAP:Body>"
    //
    //    @"<GetWebAuthByKey xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.tmwebauthwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
    //
    //    @"<key>mob123</key>"
    //
    //    @"</GetWebAuthByKey>"
    //
    //    @"</SOAP:Body>"
    //
    //    @"</SOAP:Envelope>";
    
    NSData *envelope = [envelopeText1 dataUsingEncoding:NSUTF8StringEncoding];
    //    <string name="URL">https://tmcrmappsqa.inservices.tatamotors.com/cordys/com.eibus.web.soap.Gateway.wcp?organization=o=MobileApps,cn=cordys,cn=cbop,o=tatamotors.com</string>
  //  NSURL * theurl = [NSURL URLWithString:@"http://tmcrmapps.inservices.tatamotors.com/cordys/com.eibus.web.soap.Gateway.wcp?organization=o=MobileApps,cn=cordys,cn=cbop,o=tatamotors.com"];
      NSURL * theurl = [NSURL URLWithString:@"http://tmcrmappsqa.inservices.tatamotors.com/cordys/com.eibus.web.soap.Gateway.wcp?organization=o=MobileApps,cn=cordys,cn=cbop,o=tatamotors.com"];
    
    //NSURL * theurl = [NSURL URLWithString:@"http://tmcrmappsqa.inservices.tatamotors.com/cordys/com.eibus.web.soap.Gateway.wcp?organization=o=MobileApps,cn=cordys,cn=cbop,o=tatamotors.com"];
    NSLog(@"URL IS %@",theurl);
    NSLog(@"REQUEST IS %@",envelopeText);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:50];
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText1 length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc]initiateRequest:request name:@"artifactRequest"];
}


//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
//    //[image_signature setImage:[self resizeImage:image_signature.image]];
//    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft);
//}
//-(BOOL)shouldAutorotate {
//    return YES;
//}
//- (NSUInteger)supportedInterfaceOrientations {
//   // [image_signature setImage:[self resizeImage:image_signature.image]];
//    return UIInterfaceOrientationMaskLandscapeLeft;
//}

//-(BOOL)shouldAutorotate
//{
//    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
//    
//    if (orientation==UIInterfaceOrientationLandscapeLeft || orientation==UIInterfaceOrientationLandscapeRight)
//        return YES;
//    
//     return NO;
////    if (orientation != UIInterfaceOrientationLandscapeLeft)
////    {
////        NSLog(@"UIInterfaceOrientationLandscapeLeft");
////    
////    }
//    
//  //  return YES;
//}

- (BOOL)shouldAutorotate
{
    return YES;
}


- (NSUInteger)supportedInterfaceOrientations
{
     return UIInterfaceOrientationMaskLandscapeLeft + UIInterfaceOrientationMaskLandscapeRight;
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    if ( interfaceOrientation==UIInterfaceOrientationLandscapeRight)
//        return YES;
//    
//    return NO;
//}

-(void)artifactFound:(NSNotification*)notification
{
    NSLog(@"World Cup");
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    if ([response rangeOfString:@"samlp:Response"].location == NSNotFound )
    {
        [self hideAlert];
        //  appdelegate.artifact = @"MDFn+8e5dRDaRMRIwMY7nI84eEccbx+lIiXF/JlVUNBvPm0pFry+dR4M";
        //  [appdelegate hideAlert];
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Please enter valid USER ID/PASSWORD!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else{
        @try {
//            TBXML *tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
//            TBXMLElement *body = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
//            TBXMLElement *keyResponse = [TBXML childElementNamed:@"GetWebAuthByKeyResponse" parentElement:body];
//            TBXMLElement *envelope = [TBXML childElementNamed:@"SOAP:Envelope" parentElement:keyResponse];
//            TBXMLElement *innerBody = [TBXML childElementNamed:@"SOAP:Body" parentElement:envelope];
//            TBXMLElement *samlResponse = [TBXML childElementNamed:@"samlp:Response" parentElement:innerBody];
            TBXML *tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
                TBXMLElement *body = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
            TBXMLElement *keyResponse = [TBXML childElementNamed:@"samlp:Response" parentElement:body];
            
           
            if(keyResponse)
            {
               // TBXMLElement *art = [TBXML childElementNamed:@"samlp:AssertionArtifact" parentElement:samlResponse];
                 TBXMLElement *AssertionArtifact = [TBXML childElementNamed:@"samlp:AssertionArtifact" parentElement:keyResponse];
                appdelegate.artifact = [TBXML textForElement:AssertionArtifact];
                NSLog(@"Samlp Art: %@",appdelegate.artifact);
                // NSLog(@"%@",appdelegate.artifact);
                   globalVariables_.g_Artifact = appdelegate.artifact;
                   [GlobalVariablesArray_ addObject:globalVariables_.g_Artifact];
                [appdelegate hideAlert];
                 [self callauthenticateOIDRequest];
//                [self callDateRequest];
//                [self CallUserDetails];
            }
            else
            {
                //   [appdelegate hideAlert];
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Error in connecting to server. Please try later!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
                
//
            }
//            
        }
        @catch (NSException *exception)
        {
            // [appdelegate hideAlert];
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Error in connecting to server. Please try later!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
//        
    }
    
}


-(void)artifactFailed:(NSNotification*)notification
{
    NSString *errorString=[[notification userInfo]objectForKey:@"error"];
    NSLog(@"%@",errorString);
    if([errorString isEqualToString:@"offline"])
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"The internet connection seems to be offline!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"] animated:NO];
    }
}

-(void)callDateRequest
{
    
    //  String reqDT = "<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\"><SOAP:Body><getCurrentDate xmlns=\"http://schemas.cordys.com/DateUtils\" /></SOAP:Body></SOAP:Envelope>";
    
    NSString * envelopeText = [NSString stringWithFormat:
                               
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body><getCurrentDate xmlns=\"http://schemas.cordys.com/DateUtils\" />"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>"];
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS .... %@",theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc]initiateRequest:request name:@"dateRequest"];
}

-(void)requestDateFound:(NSNotification*)notification
{
    NSError *err;
    NSString *response = [[notification userInfo]objectForKey:@"response"];
    //NSLog(@"%@",response);
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *body = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
    
    TBXMLElement *currentDate =  [TBXML childElementNamed:@"getCurrentDate" parentElement:[TBXML childElementNamed:@"getCurrentDate" parentElement:[TBXML childElementNamed:@"old" parentElement:[TBXML childElementNamed:@"tuple" parentElement:[TBXML childElementNamed:@"getCurrentDateResponse" parentElement:body]]]]];
    
    NSString * _ParseCurrentDate = [TBXML textForElement:currentDate];
    
    NSLog(@"\nCurrent date...!!!! %@",_ParseCurrentDate);
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EE, d LLLL yyyy HH:mm:ss Z"];
    NSDate *date = [dateFormat dateFromString:_ParseCurrentDate];
    
    NSLog(@"\nCurrent date...!!!! %@",date);
}


-(void)callauthenticateOIDRequest
{
    NSLog(@"inside ...CallAunthrnticate");
//    JJOSHI1001680
//    NANO2014
   
    //previous dese login usrname SAMSONJ1001680
   //pwd NANO2014
    
    NSString *envelopeText=[NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                            @"<SOAP:Body>"
                            @"<authenticateAgainstOID xmlns=\"http://schemas.cordys.com/OIDAuthentication\">"
                            @"<stringParam>%@</stringParam>"
                            @"<stringParam1>%@</stringParam1>"
                            @"</authenticateAgainstOID>"
                            @"</SOAP:Body>"
                            @"</SOAP:Envelope>",self.username.text,self.password.text];
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Envelop..%@",envelope);
    
   NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
 
    NSLog(@"URL..%@",theurl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc]initiateRequest:request name:@"authenticateOIDRequest"];
    
}
-(void)authenticateOIDFound:(NSNotification*)notification
{
    NSLog(@"ICC..");
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        NSLog(@"Dishkyauuu");
        //[appdelegate hideAlert];
        [self hideAlert];
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"The username or password you entered is incorrect.\n*The user account will be locked after 3 unsucessfull attempts." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [self hideAlert];
    }
    else{
        //NSLog(@"\nResponse....%@",response);
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        NSLog(@"Error TBXML...%@",tbxml);
        NSLog(@"Error ...%@",err);
        TBXMLElement *body = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
        
        TBXMLElement *auth1 = [TBXML childElementNamed:@"authenticateAgainstOID" parentElement:[TBXML childElementNamed:@"old" parentElement:[TBXML childElementNamed:@"tuple" parentElement:[TBXML childElementNamed:@"authenticateAgainstOIDResponse" parentElement:body]]]];
        
        TBXMLElement *auth = [TBXML childElementNamed:@"authenticateAgainstOID" parentElement:auth1];
        NSLog(@"Authentication....%@",[TBXML textForElement:auth]);
        if (auth)
        {
            NSLog(@"\nLogin Authentications ... is true....");
            [self callDateRequest];
            [self CallUserDetails];
        }
        else
        {
            NSLog(@"\n Login Autntications .... are fail.... ");
            
            
        }
    }
    
}

-(void)CallUserDetails
{
    
    //use this for dse SAMSONJ1001680
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetPositionDetailsFromLogin xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<LOGIN>%@</LOGIN>"
                               @"</GetPositionDetailsFromLogin>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",@"JJOSHI1001680"];

    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@",theurl);
    NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"userDetailsRequest"];
    
}
-(void)userDetailsFound:(NSNotification*)notification
{
    NSError *err;
    NSString *response = [[notification userInfo]objectForKey:@"response"];
    NSLog(@"userdetail :%@",response);
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    TBXMLElement *soapBody = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
    TBXMLElement *container = [TBXML childElementNamed:@"GetPositionDetailsFromLoginResponse" parentElement:soapBody];
    if(container)
    {
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        if(tuple)
        {
            container = [TBXML childElementNamed:@"S_USER" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            TBXMLElement *POSITION_NAME = [TBXML childElementNamed:@"POSITION_NAME" parentElement:container];
            NSString * _POSITION_NAME = [TBXML textForElement:POSITION_NAME];
            userDetailsVal_.POSITION_NAME = _POSITION_NAME;
            
            
            
            
            NSLog(@"\n POSITION_NAME %@",_POSITION_NAME);
            
            
            NSLog(@"\n POSITION_NAME %@",_POSITION_NAME);
            //NSArray* foo = [@"10/04/2011" componentsSeparatedByString: @"/"];
            // NSString* day = [foo objectAtIndex: 0];
            logingetUD=[_POSITION_NAME componentsSeparatedByString:@"-"];
            // NSString *str = [NSString stringWithFormat:"%@",[array objectAtIndex:[array count] - 1]];
            
            NSLog(@"Elents...on   %@",[logingetUD objectAtIndex:[logingetUD count]-1]);
            
         //   appdelegate.loginUD=[logingetUD objectAtIndex:[logingetUD count]-3];
            
            
            
            
            
            
            TBXMLElement *LOB_NAME = [TBXML childElementNamed:@"LOB_NAME" parentElement:container];
            NSString * _LOB_NAME = [TBXML textForElement:LOB_NAME];
            userDetailsVal_.LOB_NAME = _LOB_NAME;
            NSLog(@"\n LOB_NAME %@",_LOB_NAME);
            
            TBXMLElement *REGION_NAME = [TBXML childElementNamed:@"REGION_NAME" parentElement:container];
            NSString * _REGION_NAME = [TBXML textForElement:REGION_NAME];
            userDetailsVal_.REGION_NAME = _REGION_NAME;
            NSLog(@"\n REGION_NAME %@",_REGION_NAME);
            
            TBXMLElement *AREA = [TBXML childElementNamed:@"AREA" parentElement:container];
            NSString * _AREA = [TBXML textForElement:AREA];
            userDetailsVal_.AREA = _AREA;
            NSLog(@"\n _AREA %@",_AREA);
            
            TBXMLElement *STATE = [TBXML childElementNamed:@"STATE" parentElement:container];
            NSString * _STATE = [TBXML textForElement:STATE];
            userDetailsVal_.STATE = _STATE;
            NSLog(@"\n _AREA %@",_STATE);
            
            TBXMLElement *ROW_ID = [TBXML childElementNamed:@"ROW_ID" parentElement:container];
            NSString * _ROW_ID = [TBXML textForElement:ROW_ID];
            userDetailsVal_.ROW_ID = _ROW_ID;
            NSLog(@"\n _ROW_ID %@",_ROW_ID);
            
            
            TBXMLElement *POSTN = [TBXML childElementNamed:@"POSTN" parentElement:container];
            NSString * _POSTN = [TBXML textForElement:POSTN];
            userDetailsVal_.POSTN = _POSTN;
            NSLog(@"\n _POSTN %@",_POSTN);
            
            TBXMLElement *ORGNAME = [TBXML childElementNamed:@"ORGNAME" parentElement:container];
            NSString * _ORGNAME = [TBXML textForElement:ORGNAME];
            userDetailsVal_.ORGNAME = _ORGNAME;
            NSLog(@"\n _ORGNAME %@",userDetailsVal_.ORGNAME);//JUST TEST
            
            // self.loadingView.hidden=YES;
            
            // [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"tabBarController"] animated:YES];
            
            //userDetailsVal_.Login_Name = self.username.text;
//            JJOSHI1001680
//            NANO2014
            
            userDetailsVal_.Login_Name = @"JJOSHI1001680";// use this for dse SAMSONJ1001680
            NSLog(@"\n _ORGNAME %@",userDetailsVal_.Login_Name);//JUST TEST
            
            [self hideAlert];
            
            AppDelegate* app_delegate=[[UIApplication sharedApplication] delegate];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            UISplitViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SplitView"];
            //self.window = [[UIApplication sharedApplication] keyWindow];
            app_delegate.window.rootViewController= vc;
            
            //  [appdelegate hideAlert];
            /*
             DetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"detailViewController"];
             [self.navigationController pushViewController:detailViewController animated:YES];*/
            //[appdelegate hideAlert];
            
        }
        else
        {
            // [appdelegate hideAlert];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
    }
    else
    {
        // [appdelegate hideAlert];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}
-(void)userDetailsFailed:(NSNotification*)notification
{
    NSString *errorString=[[notification userInfo]objectForKey:@"error"];
    NSLog(@"\n artifactFailed%@",errorString);
    
    if([errorString isEqualToString:@"offline"])
    {
        //  [appdelegate hideAlert];
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"The internet connection seems to be offline!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"] animated:NO];
    }
    else
    {
        //  [appdelegate hideAlert];
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Request time out Please Try Later!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"] animated:NO];
        
    }
}



/*
 #pragma mark NSXML Parser Methods
 - (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
 
 NSLog(@"%@",elementName);
 
 if ([elementName isEqualToString:@"samlp:AssertionArtifact"])
 {
 self.flag=1;
 self.AssertionArtifact=[[NSMutableString alloc] init];
 NSLog(@"SamlArt : %@",elementName);
 
 }
 
 if ([elementName isEqualToString:@"getCurrentDate"])
 {
 self.flag=2;
 
 self.CurrentDate=[[NSMutableString alloc] init];
 
 }
 
 
 }
 
 - (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
 {
 
 if (self.flag== 1) {
 
 
 
 [self.AssertionArtifact appendString:string];
 NSLog(@"%@",self.AssertionArtifact);
 NSUserDefaults *strinToSave= [NSUserDefaults standardUserDefaults];
 [strinToSave setObject:self.AssertionArtifact forKey:@"AssertionArtifactString"];
 
 
 NSString *OldUrl = @"http://tmcrmappsqa.inservices.tatamotors.com/cordys/com.eibus.web.soap.Gateway.wcp?organization=o=MobileApps,cn=cordys,cn=cbop,o=tatamotors.com";
 
 self.NewUrl = [OldUrl stringByAppendingString:[NSString stringWithFormat:@"&SAMLart=%@",self.AssertionArtifact]];
 
 [strinToSave setObject:self.NewUrl forKey:@"NewUrl"];
 NSLog(@"%@",self.NewUrl);
 
 }
 
 if (self.flag== 2) {
 
 
 
 [self.CurrentDate appendString:string];
 NSLog(@"%@",self.CurrentDate);
 }
 
 
 
 }
 
 - (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
 
 if ([elementName isEqualToString:@"samlp:AssertionArtifact"])
 {
 self.AssertionArtifact=nil;
 NSString *soapMessage = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\"><SOAP:Body><getCurrentDate xmlns=\"http://schemas.cordys.com/DateUtils\" /></SOAP:Body></SOAP:Envelope>"];
 
 NSString *NewUrl=[[NSUserDefaults standardUserDefaults] valueForKey:@"NewUrl"];
 //use yourString however you want
 
 NSLog(@"%@",NewUrl);
 
 NSURL *url = [NSURL URLWithString:NewUrl];
 
 NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
 NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
 
 [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
 [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
 [theRequest setHTTPMethod:@"POST"];
 [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
 
 NSURLConnection *theConnection =
 [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
 
 if( theConnection )
 {
 self.webData = [NSMutableData data] ;
 NSLog(@"Connected");
 }
 else
 {
 NSLog(@"theConnection is NULL");
 }
 }
 
 if ([elementName isEqualToString:@"getCurrentDate"])
 {
 
 self.CurrentDate=nil;
 
 }
 
 
 }
 
 -(void)NewRequest
 {
 NSString *soapMessage = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\"><SOAP:Body><getCurrentDate xmlns=\"http://schemas.cordys.com/DateUtils\" /></SOAP:Body></SOAP:Envelope>"];
 
 NSURL *url = [NSURL URLWithString:self.NewUrl];
 
 NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
 NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
 
 [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
 [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
 [theRequest setHTTPMethod:@"POST"];
 [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
 
 NSURLConnection *theConnection =
 [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
 
 if( theConnection )
 {
 self.webData = [NSMutableData data] ;
 NSLog(@"Connected");
 }
 else
 {
 NSLog(@"theConnection is NULL");
 }
 
 }
 
 #pragma mark NSURL CONNECTION DELEGATE METHODS
 
 -(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
 {
 [self.webData setLength:0];
 }
 
 -(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
 {
 
 [self.webData appendData:data];
 
 }
 
 -(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
 {
 NSLog(@"ERROR with theConenction");
 
 }
 
 -(void)connectionDidFinishLoading:(NSURLConnection *)connection
 {
 NSLog(@"DONE. Received Bytes: %@", self.webData);
 NSString *theXML = [[NSString alloc] initWithBytes:
 [self.webData mutableBytes] length:[self.webData length] encoding:NSUTF8StringEncoding];
 
 
 
 NSData *myData = [theXML dataUsingEncoding:NSUTF8StringEncoding];
 
 NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:myData];
 
 
 xmlParser.delegate = self;
 
 [xmlParser parse];
 
 }*/


-(void)showAlert
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
-(void)hideAlert
{
    //NSLog(@"Hide...Alert..");
    [MBProgressHUD hideHUDForView:self.view animated:YES];
 
}





@end
