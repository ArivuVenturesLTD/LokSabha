//
//  CollectionViewManager.h
//  PDKTStickySectionHeadersCollectionViewLayoutDemo
//
//  Created by Daniel García on 31/12/13.
//  Copyright (c) 2013 Produkt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDKTStickySectionHeadersCollectionViewLayout.h"
#import "APExtendedPageController.h"


@interface CollectionViewManager : NSObject<UICollectionViewDataSource,UICollectionViewDelegate,PDKTStickySectionHeadersCollectionViewLayoutDelegate> {
    APExtendedPageController * _pageController;

}
@property (weak,nonatomic) UICollectionView *collectionView;
@end
