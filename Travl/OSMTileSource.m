//
//  OSMTileSource.m
//  Travl
//
//  Created by Kristoffer Skjutar on 2015-07-12.
//  Copyright (c) 2015 Kristoffer Skjutar. All rights reserved.
//

#import "OSMTileSource.h"

@implementation OSMTileSource

- (id) init
{
    self = [super init];
    if (self) {
        self.retryCount = 3;
        self.requestTimeoutSeconds = 10;
        self.offline = NO;
    }
    return self;
}

- (NSURL *)URLForTile:(RMTile)tile
{
     if (self.offline) {
         return nil;
     }
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://tile.openstreetmap.org/%u/%u/%u.png", tile.zoom, tile.x, tile.y]];
}

- (NSArray *)URLsForTile:(RMTile)tile
{
    if (self.offline) {
        return [NSArray array];
    }
    return [NSArray arrayWithObject:[self URLForTile:tile]];
}

- (NSString *)uniqueTilecacheKey
{
    return @"StamenWatercolor";
}

- (NSString *)shortName
{
    return @"Watercolor";
}

- (NSString *)longDescription
{
    return @"Reminiscent of hand drawn maps, our watercolor maps apply raster effect area washes and organic edges over a paper texture to add warm pop to any map. Watercolor was inspired by the Bicycle Portraits project. Thanks to Cassidy Curtis for his early advice.";
}

- (NSString *)shortAttribution
{
    return @"<style>body { text-align: left; font-size: 12px; }</style>Map tiles by Stamen Design, under CC BY 3.0. Data by OpenStreetMap, under CC BY SA.";
}


@end
