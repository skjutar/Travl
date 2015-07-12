//
//  ViewController.m
//  Travl
//
//  Created by Kristoffer Skjutar on 2015-07-12.
//  Copyright (c) 2015 Kristoffer Skjutar. All rights reserved.
//

#import "ViewController.h"
#import "Mapbox.h"
#import "OSMTileSource.h"

@interface ViewController ()<RMTileCacheBackgroundDelegate>

@property OSMTileSource *source;
@property CLLocationCoordinate2D southwest;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RMTileCache *cache = [[RMTileCache alloc] init];
    cache.backgroundCacheDelegate = self;
    self.source = [[OSMTileSource alloc] init];
    self.southwest = CLLocationCoordinate2DMake(57.658590, 11.880036);
    CLLocationCoordinate2D northWest = CLLocationCoordinate2DMake(57.729415, 12.010155);
    
    [cache beginBackgroundCacheForTileSource:self.source southWest:self.southwest northEast:northWest minZoom:7 maxZoom:15];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tileCache:(RMTileCache *)tileCache didBackgroundCacheTile:(RMTile)tile withIndex:(NSUInteger)tileIndex ofTotalTileCount:(NSUInteger)totalTileCount
{
    NSLog(@"%lu of %lu", (unsigned long)tileIndex, (unsigned long)totalTileCount);
}

- (void)tileCacheDidFinishBackgroundCache:(RMTileCache *)tileCache
{
    self.source.offline = YES;
    RMMapView *mapView = [[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:self.source];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    mapView.adjustTilesForRetinaDisplay = YES; // these tiles aren't designed specifically for retina, so make them legible
    [self.view addSubview:mapView];
    mapView.zoom = 12;
    [mapView setCenterCoordinate:self.southwest];
}

@end
