//
//  CollectionReusableView.h
//  Tools
//
//  Created by Richie on 16/12/5.
//  Copyright © 2016年 Eties. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionReusableView : UICollectionReusableView


/**
 重用标示

 @return 标示(类名)
 */
- (NSString *)cellIdentifier;


/**
 代码创建时候需要在里面 创建自己的子view
 */
- (void)subViewsCreation;

@end
