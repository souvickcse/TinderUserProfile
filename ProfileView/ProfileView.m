#import "ProfileView.h"
#import <PureLayout.h>
#import <UIImageView+WebCache.h>
#define UserProfileHeight 200
#define PageControlMaxHeight 200
#define PageControlCellHeightWidth 10
@interface ProfileView () {
    float currentY;
    float currentUserHeight;
    NSLayoutConstraint *constraintImageViewTop;
    BOOL shouldAllowParentScroll;
    int currentPageControlIndex;
}
@end
@implementation ProfileView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self != nil) {
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 10.0;
    self.layer.masksToBounds = YES;
    currentPageControlIndex = 1;
    
    self.isUserDetailsOn = NO;
    self.paddingProfileView = 10;
    self.heightProfileView = UserProfileHeight;
    self.arrImageViews = [[NSMutableArray alloc]init];
}

- (void)designUserProfile:(NSDictionary *)userDetails {
    UILabel *lblName = [[UILabel alloc]init];
    [self.viewUserDetails addSubview:lblName];
    lblName.textColor = [UIColor whiteColor];
    lblName.font = [UIFont systemFontOfSize:20];
    lblName.text = [userDetails valueForKey:@"name"];
    [lblName autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15.0];
    [lblName autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15.0];
    [lblName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:8.0];
    
    UILabel *lblDistance = [[UILabel alloc]init];
    [self.viewUserDetails addSubview:lblDistance];
    lblDistance.textColor = [UIColor whiteColor];
    lblDistance.font = [UIFont systemFontOfSize:15];
    lblDistance.text = [NSString stringWithFormat:@"%@ miles away",[userDetails valueForKey:@"distance"]];
    [lblDistance autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:52.0];
    [lblDistance autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:52.0];
    [lblDistance autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:8.0];
    
    UILabel *lblGender = [[UILabel alloc]init];
    [self.viewUserDetails addSubview:lblGender];
    lblGender.textColor = [UIColor whiteColor];
    lblGender.font = [UIFont systemFontOfSize:15];
    lblGender.text = [NSString stringWithFormat:@"%@",[userDetails valueForKey:@"gender"]];
    [lblGender autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:52.0];
    [lblGender autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:112.0];
    [lblGender autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:8.0];
    
    UILabel *lblLikeCount = [[UILabel alloc]init];
    [self.viewUserDetails addSubview:lblLikeCount];
    lblLikeCount.textColor = [UIColor whiteColor];
    lblLikeCount.font = [UIFont systemFontOfSize:15];
    lblLikeCount.text = [userDetails valueForKey:@"like"];
    
    [lblLikeCount autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:52.0];
    [lblLikeCount autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:170.0];
    [lblLikeCount autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:8.0];
    
    UIView *lineView = [[UIView alloc]init];
    [self.viewUserDetails addSubview:lineView];
    lineView.backgroundColor = [UIColor whiteColor];
    [lineView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:24.0];
    [lineView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:73.0];
    [lineView autoSetDimension:ALDimensionHeight toSize:100];
    [lineView autoSetDimension:ALDimensionWidth toSize:2];
    
    UIView *roundView1 = [[UIView alloc]init];
    [self.viewUserDetails addSubview:roundView1];
    roundView1.backgroundColor = [UIColor whiteColor];
    roundView1.layer.cornerRadius = 10.0;
    roundView1.layer.masksToBounds = YES;
    [roundView1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15.0];
    [roundView1 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:53.0];
    [roundView1 autoSetDimension:ALDimensionHeight toSize:20];
    [roundView1 autoSetDimension:ALDimensionWidth toSize:20];
    
    UIView *roundView2 = [[UIView alloc]init];
    [self.viewUserDetails addSubview:roundView2];
    roundView2.backgroundColor = [UIColor whiteColor];
    roundView2.layer.cornerRadius = 10.0;
    roundView2.layer.masksToBounds = YES;
    [roundView2 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15.0];
    [roundView2 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:113.0];
    [roundView2 autoSetDimension:ALDimensionHeight toSize:20];
    [roundView2 autoSetDimension:ALDimensionWidth toSize:20];
    
    UIView *roundView3 = [[UIView alloc]init];
    [self.viewUserDetails addSubview:roundView3];
    roundView3.backgroundColor = [UIColor whiteColor];
    roundView3.layer.cornerRadius = 10.0;
    roundView3.layer.masksToBounds = YES;
    [roundView3 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15.0];
    [roundView3 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:173.0];
    [roundView3 autoSetDimension:ALDimensionHeight toSize:20];
    [roundView3 autoSetDimension:ALDimensionWidth toSize:20];
}

- (void)setUpImageViewWithImageArr:(NSArray *)arrImg userDetails:(NSDictionary *)userDetails {

    /*Clear the subview first incase for re-setup*/
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.arrImages = [[NSMutableArray alloc] initWithArray:arrImg];

    /*Image holder setup*/
    self.viewImageHolder = [[UIView alloc] init];
    [self addSubview:self.viewImageHolder];
    [self.viewImageHolder autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    constraintImageViewTop = [self.viewImageHolder autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.viewImageHolder autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.viewImageHolder autoSetDimension:ALDimensionHeight toSize:self.arrImages.count*self.frame.size.height];
    self.viewImageHolder.backgroundColor = [UIColor clearColor];

    /*User view setup*/
    self.viewUserDetails = [[UIView alloc] init];
    [self addSubview:self.viewUserDetails];
    [self.viewUserDetails autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:self.paddingProfileView];
    [self.viewUserDetails autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:self.paddingProfileView];
    [self.viewUserDetails autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:self.paddingProfileView];
    self.constraintUserViewHeight = [self.viewUserDetails autoSetDimension:ALDimensionHeight toSize:0.0];
    self.viewUserDetails.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.85];
    self.viewUserDetails.layer.cornerRadius = 10.0;
    self.viewUserDetails.layer.masksToBounds = YES;
    
    [self designUserProfile:userDetails];

    UIImageView *imageViewPrevious = nil;

    for(int i=0; i<self.arrImages.count; i++) {

        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor clearColor];
        [self.viewImageHolder addSubview:imageView];
        if(!imageViewPrevious) {
            [imageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
        } else {
            [imageView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imageViewPrevious withOffset:0];
        }

        [imageView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
        [imageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
        [imageView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.masksToBounds = YES;
        imageViewPrevious = imageView;

        NSString *imageUrl = [self.arrImages objectAtIndex:i];
        NSURL *url = [NSURL URLWithString:imageUrl];
        [imageView sd_setImageWithURL:url];
        [self.arrImageViews addObject:imageView];
    }

    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDectected:)];
    panGesture.delegate = (id)self;
    [self addGestureRecognizer:panGesture];

    self.tblPageControl = [[UITableView alloc] init];
    self.tblPageControl.dataSource=(id)self;
    self.tblPageControl.delegate=(id)self;
    self.tblPageControl.allowsSelection = NO;
    self.tblPageControl.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tblPageControl registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tblPageControl.backgroundColor = [UIColor clearColor];
    self.tblPageControl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tblPageControl reloadData];
    self.tblPageControl.rowHeight = PageControlCellHeightWidth;
    self.tblPageControl.estimatedRowHeight = PageControlCellHeightWidth;
    self.tblPageControl.sectionFooterHeight = 0.0;
    self.tblPageControl.sectionHeaderHeight = 0.0;
    self.tblPageControl.estimatedSectionFooterHeight = 0.0;
    self.tblPageControl.estimatedSectionHeaderHeight = 0.0;
    [self addSubview:self.tblPageControl];
    [self.tblPageControl autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [self.tblPageControl autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [self.tblPageControl autoSetDimension:ALDimensionWidth toSize:PageControlCellHeightWidth+20];
    if((self.arrImages.count+1)*PageControlCellHeightWidth>PageControlMaxHeight) {
        [self.tblPageControl autoSetDimension:ALDimensionHeight toSize:PageControlMaxHeight];
        self.tblPageControl.scrollEnabled = YES;
    } else {
        [self.tblPageControl autoSetDimension:ALDimensionHeight toSize:(self.arrImages.count+1)*PageControlCellHeightWidth];
        self.tblPageControl.scrollEnabled = NO;
    }
    self.tblPageControl.insetsLayoutMarginsFromSafeArea = NO;

}

- (void)panDectected:(UIPanGestureRecognizer *)gesture {

    static CGPoint lastTranslate;
    static CGPoint prevTranslate;
    static NSTimeInterval lastTime;
    static NSTimeInterval prevTime;

    CGPoint translate = [gesture translationInView:self];
    CGPoint vel = [gesture velocityInView:self];

    BOOL isUpWards = NO;
    if (vel.y > 0) {
        isUpWards = NO;
    } else {
        isUpWards = YES;
    }

    if (gesture.state == UIGestureRecognizerStateBegan) {
        lastTime = [NSDate timeIntervalSinceReferenceDate];
        lastTranslate = translate;
        prevTime = lastTime;
        prevTranslate = lastTranslate;
        if(self.constraintUserViewHeight.constant > 0) {
            self.isUserDetailsOn = YES;
        } else {
            self.isUserDetailsOn = NO;
        }

    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        prevTime = lastTime;
        prevTranslate = lastTranslate;
        lastTime = [NSDate timeIntervalSinceReferenceDate];
        lastTranslate = translate;

        float imageViewTop = translate.y+currentY;
        float userDetailsHeight = translate.y+currentUserHeight;

        if(imageViewTop>0.0) {
            imageViewTop = 0.0;
            constraintImageViewTop.constant = imageViewTop;
            if(userDetailsHeight>self.heightProfileView) {
                self.constraintUserViewHeight.constant = self.heightProfileView;
            } else {
                self.constraintUserViewHeight.constant = userDetailsHeight;
            }
        } else {
            if(self.constraintUserViewHeight.constant>0) {
                self.constraintUserViewHeight.constant = userDetailsHeight;
            } else {
                currentUserHeight = 0;
                if(!self.isUserDetailsOn) {
                    if(imageViewTop<-((self.arrImages.count-1)*self.frame.size.height)) {
                        constraintImageViewTop.constant = -((self.arrImages.count-1)*self.frame.size.height);
                    } else {
                        constraintImageViewTop.constant = imageViewTop;
                    }
                }
            }
        }

    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        prevTime = lastTime;
        prevTranslate = lastTranslate;
        lastTime = [NSDate timeIntervalSinceReferenceDate];
        lastTranslate = translate;

        float imageViewTop = translate.y+currentY;
        if(!self.isUserDetailsOn) {
            if(imageViewTop>0.0) {
                imageViewTop = 0.0;
                constraintImageViewTop.constant = imageViewTop;
            } else {
                if(!self.isUserDetailsOn) {
                    if(imageViewTop<-((self.arrImages.count-1)*self.frame.size.height)) {
                        constraintImageViewTop.constant = -((self.arrImages.count-1)*self.frame.size.height);
                    } else {
                        constraintImageViewTop.constant = imageViewTop;
                    }
                }
            }

            if(!self.isUserDetailsOn) {
                if(isUpWards) {
                    for(int i=0;i<self.arrImages.count;i++) {
                        if(constraintImageViewTop.constant>-(i*self.frame.size.height)+20) {
                            constraintImageViewTop.constant = -i*self.frame.size.height;
                            break;
                        }
                    }
                } else {
                    if(constraintImageViewTop.constant<0) {
                        for(int i=0;i<self.arrImages.count;i++) {
                            if(constraintImageViewTop.constant>-(i+1)*self.frame.size.height-20) {
                                constraintImageViewTop.constant = -i*self.frame.size.height;
                                break;
                            }
                        }
                    }
                }
            }
        }

        currentY = constraintImageViewTop.constant;
        if(isUpWards) {
            if(self.constraintUserViewHeight.constant>self.heightProfileView-20) {
                self.constraintUserViewHeight.constant = self.heightProfileView;
                currentUserHeight = self.constraintUserViewHeight.constant;
            } else {
                self.constraintUserViewHeight.constant = 0.0;
                currentUserHeight = self.constraintUserViewHeight.constant;
            }
        } else {
            if(self.constraintUserViewHeight.constant>20) {
                self.constraintUserViewHeight.constant = self.heightProfileView;
                currentUserHeight = self.constraintUserViewHeight.constant;
            } else {
                self.constraintUserViewHeight.constant = 0.0;
                currentUserHeight = self.constraintUserViewHeight.constant;
            }
        }

        self.isUserDetailsOn = NO;

        /*Setup Page Number*/
        if(self.constraintUserViewHeight.constant>0) {
            currentPageControlIndex = 0;
        } else {
            currentPageControlIndex = fabs(constraintImageViewTop.constant/self.frame.size.height)+1;
        }
        [self.tblPageControl beginUpdates];
        [self.tblPageControl reloadData];
        [self.tblPageControl endUpdates];

        [UIView animateWithDuration:0.3 animations:^{
            [self layoutIfNeeded];
        }];
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return shouldAllowParentScroll;
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint velocity = [panGestureRecognizer velocityInView:self];
    if(fabs(velocity.y) > fabs(velocity.x)) {
        shouldAllowParentScroll = NO;
        return YES;
    } else {
        shouldAllowParentScroll = YES;
        return NO;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrImages.count+1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return PageControlCellHeightWidth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section; {
    return 0.0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section; {
    return 0.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier   forIndexPath:indexPath] ;
    cell.backgroundColor = [UIColor clearColor];

    UIView *view;
    if([cell viewWithTag:23]) {
        view = [cell viewWithTag:23];
    } else {
        view = [[UIView alloc] initWithFrame:CGRectMake(2.0, 2.0, PageControlCellHeightWidth-4.0, PageControlCellHeightWidth-4.0)];
        view.layer.cornerRadius = (PageControlCellHeightWidth-4.0)/2.0;
        view.tag = 23;
    }
    
    if(currentPageControlIndex == indexPath.row) {
        view.backgroundColor = [UIColor blackColor];
    } else {
        view.backgroundColor = [UIColor whiteColor];
    }
    
    [cell addSubview:view];
    return cell;
}

@end
