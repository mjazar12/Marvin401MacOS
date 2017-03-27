//
//  ViewController.h
//  BarcodeScannerDemo
//
//  Created by vladimir zivkovic on 3/28/13.
//  Copyright (c) 2013 Manateeworks. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController {
    
    NSImageView *imageView;
    
}

- (NSString *) scanImage: (NSString *)imageName;

@end
