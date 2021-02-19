//
//  BOCeClassifySelect.h
//  Industrial
//
//  Created by boce on 2020/7/10.
//  Copyright © 2020 boce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@protocol BOCeClassifydelegate <NSObject>

@optional

/// tableView didSelectCell
/// @param model model
-(void)BOCeClassifyCellDidSelect:(NSString *_Nonnull)model;

/// didSelect Model
/// @param model model
-(void)BOCeClassifyButtonDidSelect:(NSArray *_Nonnull)model;

/// Select Model error
/// @param model model
-(void)BOCeClassifyButtonDidError:(NSString *_Nonnull)model;

/// Cancle Model 
/// @param model model
-(void)BOCeClassifyButtonDidCancle:(NSString *_Nonnull)model;

@end

NS_ASSUME_NONNULL_BEGIN

@interface BOCeClassifySelect : UIView

/// 表数据源
@property(strong,nonatomic)NSMutableArray *dataArray;

@property(assign,nonatomic)id<BOCeClassifydelegate>delegate;

@property(strong,nonatomic)UICollectionView *collectView;

@property(strong,nonatomic)NSMutableArray *CollectDataArray;

-(void)show;

-(void)disMiss;

@end
//label
@interface BOCeLabel : UILabel

@end
//CollectCell
@interface BOCeClassifyCollectCell : UICollectionViewCell

@property(strong,nonatomic)BOCeLabel *titleLable;

@end

NS_ASSUME_NONNULL_END
