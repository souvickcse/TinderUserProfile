# TinderUserProfile
## Tinder/Bumble like user image with user details scroll animation 

![ScreenRecroding](https://github.com/souvickcse/TinderUserProfile/raw/master/ScreenRecording.gif)
* Add ProfileView.m,ProfileView.h class to your project.
* Set the class of the UiView to ProfileView. You need to have PureLayout & SDWebImage.


Call to this to populate the image list: `- (void)setUpImageViewWithImageArr:(NSArray *)arrImg userDetails:(NSDictionary *)userDetails;`

**arrImg** have the list of the links of the images.

**userDetails** have the user details for showing in the user details part. Please check `- (void)designUserProfile:(NSDictionary *)userDetails` for modifing the key value of the dictionary and ui of the user details.

It is using PureLayout for adding autolayout. And SDWebImage for downloading the images.
