//
//  CustomView.h
//  Transform
//
//  Created by macmini25 on 07/07/15.
//  Copyright (c) 2015 macmini25. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NSCellType) {
    NSNullCellType = 0,
    NSTextCellType = 1,
    NSImageCellType = 2
};

@interface CustomView : UIView
@property (strong, nonatomic) UIImageView *resizingControl;
@property (assign, nonatomic) CGPoint prevPoint;
@property (nonatomic) CGFloat deltaAngle;
@property (nonatomic , assign) NSCellType type;
-(void)setUpView;
@end
