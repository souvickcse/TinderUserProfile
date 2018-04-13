#import <UIKit/UIKit.h>
@interface ProfileView : UIView
@property (strong, nonatomic) UIView *viewImageHolder;
@property (strong, nonatomic) UIView *viewUserDetails;
@property float paddingProfileView;
@property float heightProfileView;
@property BOOL isUserDetailsOn;
@property NSLayoutConstraint *constraintUserViewHeight;
@property (strong, nonatomic) NSMutableArray *arrImages;
@property (strong, nonatomic) NSMutableArray *arrImageViews;
@property (strong, nonatomic) UITableView *tblPageControl;
- (void)setUpImageViewWithImageArr:(NSArray *)arrImg userDetails:(NSDictionary *)userDetails;
@end
