//
//  ViewController.m
//  BarcodeScannerDemo
//
//  Created by vladimir zivkovic on 3/28/13.
//  Copyright (c) 2013 Manateeworks. All rights reserved.
//

#import "ViewController.h"
#import "BarcodeScanner.h"

// !!! Rects are in format: x, y, width, height !!!
#define RECT_LANDSCAPE_1D       0, 0, 100, 100
#define RECT_LANDSCAPE_2D       0, 0, 100, 100
#define RECT_PORTRAIT_1D        0, 0, 100, 100
#define RECT_PORTRAIT_2D        0, 0, 100, 100
#define RECT_FULL_1D            0, 0, 100, 100
#define RECT_FULL_2D            0, 0, 100, 100


@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initDecoder];
    }
    
    return self;
}

- (void) loadView {
    [super loadView];
    /*[self scanImage:@"testimage_39.jpg"];
    [self scanImage:@"testimage_128.jpg"];
    [self scanImage:@"testimage_dm.jpg"];
    [self scanImage:@"testimage_i25.jpg"];
    [self scanImage:@"testimage_pdf.jpg"];
    [self scanImage:@"testimage_qr.jpg"];
    [self scanImage:@"testimage_rss.jpg"];*/
    [self scanImage:@"testimage_upc.jpg"];
    
}

//used internally for debugging purpose
-(NSImage*) imageFromBuffer:(unsigned char *) imageData width:(int) width height: (int) height {
    
    NSBitmapImageRep *colorRep = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:nil
                                                                         pixelsWide:width
                                                                         pixelsHigh:height
                                                                      bitsPerSample:8
                                                                    samplesPerPixel:3
                                                                           hasAlpha:NO
                                                                           isPlanar:NO
                                                                     colorSpaceName:NSCalibratedRGBColorSpace
                                                                        bytesPerRow:(3*width)
                                                                       bitsPerPixel:24];
    
    NSInteger rowBytes = width * 3;;
    NSLog(@"Row Bytes: %ld",(long)rowBytes);
    unsigned char * pix = [colorRep bitmapData];
    
    for (int i = 0 ; i < height * width; i++) {
        pix[i*3] = imageData[i];
        pix[i*3+1] = imageData[i];
        pix[i*3+2] = imageData[i];
        
    }
    
    NSImage *theImage = [[NSImage alloc] initWithSize:NSMakeSize(width, height)];
    [theImage addRepresentation:colorRep];
   
    return theImage;
    
}


- (void) initDecoder {
    //register your copy of library with given key
    int registerResult = MWB_registerSDK("key");
    
    switch (registerResult) {
        case MWB_RTREG_OK:
            NSLog(@"Registration OK");
            break;
        case MWB_RTREG_INVALID_KEY:
            NSLog(@"Registration Invalid key");
            break;
        case MWB_RTREG_INVALID_CHECKSUM:
            NSLog(@"Registration Invalid checksum");
            break;
        case MWB_RTREG_INVALID_APPLICATION:
            NSLog(@"Registration Invalid application");
            break;
        case MWB_RTREG_INVALID_SDK_VERSION:
            NSLog(@"Registration Invalid SDK Version");
            break;
        case MWB_RTREG_INVALID_KEY_VERSION:
            NSLog(@"Registration Invalid Key Version");
            break;
        case MWB_RTREG_INVALID_PLATFORM:
            NSLog(@"Registration Invalid Platform");
            break;
        case MWB_RTREG_KEY_EXPIRED:
            NSLog(@"Registration Key Expired");
            break;
            
        default:
            NSLog(@"Registration Unknown Error");
            break;
    }
    
    // choose code type or types you want to search for
    
    // Our sample app is configured by default to search all supported barcodes...
    MWB_setActiveCodes(MWB_CODE_MASK_25    |
                       MWB_CODE_MASK_39     |
                       MWB_CODE_MASK_93     |
                       MWB_CODE_MASK_128    |
                       MWB_CODE_MASK_AZTEC  |
                       MWB_CODE_MASK_DM     |
                       MWB_CODE_MASK_EANUPC |
                       MWB_CODE_MASK_PDF    |
                       MWB_CODE_MASK_QR     |
                       MWB_CODE_MASK_CODABAR |
                       MWB_CODE_MASK_DOTCODE |
                       MWB_CODE_MASK_11     |
                       MWB_CODE_MASK_MSI    |
                       MWB_CODE_MASK_RSS);
    
    // But for better performance, only activate the symbologies your application requires...
    // MWB_setActiveCodes( MWB_CODE_MASK_25 );
    // MWB_setActiveCodes( MWB_CODE_MASK_39 );
    // MWB_setActiveCodes( MWB_CODE_MASK_128 );
    // MWB_setActiveCodes( MWB_CODE_MASK_AZTEC );
    // MWB_setActiveCodes( MWB_CODE_MASK_DM );
    // MWB_setActiveCodes( MWB_CODE_MASK_EANUPC );
    // MWB_setActiveCodes( MWB_CODE_MASK_PDF );
    // MWB_setActiveCodes( MWB_CODE_MASK_QR );
    // MWB_setActiveCodes( MWB_CODE_MASK_CODABAR );
    // MWB_setActiveCodes( MWB_CODE_MASK_RSS );
    // MWB_setActiveCodes( MWB_CODE_MASK_DOTCODE );
    // MWB_setActiveCodes( MWB_CODE_MASK_11 );
    // MWB_setActiveCodes( MWB_CODE_MASK_MSI );
    
    
    // Our sample app is configured by default to search both directions...
    MWB_setDirection(MWB_SCANDIRECTION_HORIZONTAL | MWB_SCANDIRECTION_VERTICAL);
    // set the scanning rectangle based on scan direction(format in pct: x, y, width, height)
  /*  MWB_setScanningRect(MWB_CODE_MASK_25,     RECT_FULL_1D);
    MWB_setScanningRect(MWB_CODE_MASK_39,     RECT_FULL_1D);
    MWB_setScanningRect(MWB_CODE_MASK_128,    RECT_FULL_1D);
    MWB_setScanningRect(MWB_CODE_MASK_AZTEC,  RECT_FULL_2D);
    MWB_setScanningRect(MWB_CODE_MASK_DM,     RECT_FULL_2D);
    MWB_setScanningRect(MWB_CODE_MASK_EANUPC, RECT_FULL_1D);
    MWB_setScanningRect(MWB_CODE_MASK_PDF,    RECT_FULL_1D);
    MWB_setScanningRect(MWB_CODE_MASK_CODABAR,RECT_FULL_1D);
    MWB_setScanningRect(MWB_CODE_MASK_QR,     RECT_FULL_2D);
    MWB_setScanningRect(MWB_CODE_MASK_DOTCODE,RECT_FULL_2D);
    MWB_setScanningRect(MWB_CODE_MASK_RSS,    RECT_FULL_1D);
    MWB_setScanningRect(MWB_CODE_MASK_11,     RECT_FULL_1D);
    MWB_setScanningRect(MWB_CODE_MASK_MSI,    RECT_FULL_1D);*/
    
    
    // But for better performance, set like this for PORTRAIT scanning...
    // MWB_setDirection(MWB_SCANDIRECTION_VERTICAL);
    // set the scanning rectangle based on scan direction(format in pct: x, y, width, height)
    // MWB_setScanningRect(MWB_CODE_MASK_25,     RECT_PORTRAIT_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_39,     RECT_PORTRAIT_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_128,    RECT_PORTRAIT_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_AZTEC,  RECT_PORTRAIT_2D);
    // MWB_setScanningRect(MWB_CODE_MASK_DM,     RECT_PORTRAIT_2D);
    // MWB_setScanningRect(MWB_CODE_MASK_EANUPC, RECT_PORTRAIT_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_PDF,    RECT_PORTRAIT_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_CODABAR,RECT_PORTRAIT_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_QR,     RECT_PORTRAIT_2D);
    // MWB_setScanningRect(MWB_CODE_MASK_DOTCODE,RECT_PORTRAIT_2D);
    // MWB_setScanningRect(MWB_CODE_MASK_RSS,    RECT_PORTRAIT_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_11,     RECT_PORTRAIT_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_MSI,    RECT_PORTRAIT_1D);
    
    // or like this for LANDSCAPE scanning - Preferred for dense or wide codes...
    // MWB_setDirection(MWB_SCANDIRECTION_HORIZONTAL);
    // set the scanning rectangle based on scan direction(format in pct: x, y, width, height)
    // MWB_setScanningRect(MWB_CODE_MASK_25,     RECT_LANDSCAPE_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_39,     RECT_LANDSCAPE_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_128,    RECT_LANDSCAPE_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_AZTEC,  RECT_LANDSCAPE_2D);
    // MWB_setScanningRect(MWB_CODE_MASK_DM,     RECT_LANDSCAPE_2D);
    // MWB_setScanningRect(MWB_CODE_MASK_EANUPC, RECT_LANDSCAPE_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_PDF,    RECT_LANDSCAPE_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_QR,     RECT_LANDSCAPE_2D);
    // MWB_setScanningRect(MWB_CODE_MASK_CODABAR,RECT_LANDSCAPE_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_DOTCODE,RECT_LANDSCAPE_2D);
    // MWB_setScanningRect(MWB_CODE_MASK_RSS,    RECT_LANDSCAPE_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_11,     RECT_LANDSCAPE_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_MSI,    RECT_LANDSCAPE_1D);
    
    
    // set decoder effort level (1 - 5)
    // for live scanning scenarios, a setting between 1 to 3 will suffice
    // levels 4 and 5 are typically reserved for batch scanning
    MWB_setLevel(3);
    
    //get and print Library version
    int ver = MWB_getLibVersion();
    int v1 = (ver >> 16);
    int v2 = (ver >> 8) & 0xff;
    int v3 = (ver & 0xff);
    NSString *libVersion = [NSString stringWithFormat:@"%d.%d.%d", v1, v2, v3];
    NSLog(@"Lib version: %@", libVersion);
    
    
}

-(unsigned char*) getGrayBytesForImage: (CGImageRef) image
{
    
#define bytesPerPixel 4
#define bitsPerComponent 8
    
    
    NSUInteger width = CGImageGetWidth(image);
    NSUInteger height = CGImageGetHeight(image);
	
    NSUInteger bytesPerRow = bytesPerPixel * width;
	
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = malloc(height * width * 4);
	unsigned char *grayData = malloc(height * width);
	CGContextRef context = CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image);
    CGContextRelease(context);
	
	for (int i=0; i<width*height;i++){
		int dst=(i<<2)+1;
		grayData[i]=rawData[dst];
	}
	free(rawData);
	
    return grayData;
}

- (NSString *) scanImage: (NSString *)imageName {
    
    
    
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource: imageName ofType:@""];
    NSData *data = [NSData dataWithContentsOfFile:resourcePath];
    
    if (!data) {
        //try with absolute path
        data = [NSData dataWithContentsOfFile: imageName];
    }
    // CGDataProviderRef imgDataProvider = CGDataProviderCreateWithCFData((CFDataRef) imageData);
    CGImageRef image = [[NSBitmapImageRep imageRepWithData: data] CGImage];
    int width = CGImageGetWidth(image);
	int height = CGImageGetHeight(image);
    
    imageView.image = [[NSImage alloc] initWithCGImage:image size:NSSizeFromCGSize(CGSizeMake(width, height))];
    
		
	//convert image to grayscale buffer which is required by decoder
	unsigned char* imageData = [self getGrayBytesForImage:image];
	
    //check image for code
    unsigned char * pResult;
    
    int resLength;
    
    resLength = MWB_scanGrayscaleImage(imageData,width,height, &pResult);
    
	
	//process and show the result
	NSString *resultString;
	if (resLength > 0){
		char *temp = (char *)malloc(resLength+1);
		memcpy(temp, pResult, resLength);
        temp[resLength] = 0;
		resultString = [NSString stringWithCString:temp encoding:NSUTF8StringEncoding];
		free(temp);
		free(pResult);
        
        int bcType = MWB_getLastType();
    	NSString *typeName=@"";
    	switch (bcType) {
    		case FOUND_128: typeName = @"Code 128";break;
    		case FOUND_39: typeName = @"Code 39";break;
    		case FOUND_AZTEC: typeName = @"AZTEC";break;
    		case FOUND_DM: typeName = @"Datamatrix";break;
    		case FOUND_EAN_13: typeName = @"EAN 13";break;
    		case FOUND_EAN_8: typeName = @"EAN 8";break;
    		case FOUND_NONE: typeName = @"None";break;
    		case FOUND_RSS_14: typeName = @"Databar 14";break;
    		case FOUND_RSS_14_STACK: typeName = @"Databar 14 Stacked";break;
    		case FOUND_RSS_EXP: typeName = @"Databar Expanded";break;
    		case FOUND_RSS_LIM: typeName = @"Databar Limited";break;
    		case FOUND_UPC_A: typeName = @"UPC A";break;
    		case FOUND_UPC_E: typeName = @"UPC E";break;
            case FOUND_QR: typeName = @"QR";break;
            case FOUND_PDF: typeName = @"PDF417";break;
            case FOUND_25_INTERLEAVED: typeName = @"Code 25 Interleaved";break;
            case FOUND_25_STANDARD: typeName = @"Code 25 Standard";break;
            case FOUND_CODABAR: typeName = @"Codabar";break;
            case FOUND_128_GS1: typeName = @"Code 128 GS1";break;
            case FOUND_DOTCODE: typeName = @"Dotcode";break;
            case FOUND_11: typeName = @"Code 11";break;
            case FOUND_MSI: typeName = @"MSI Plessey";break;
    	}
        
        resultString = [NSString stringWithFormat:@"%@ (%@)", resultString, typeName];
    } else {
		resultString = @"No barcode found in image";
	}
    
    return resultString;
    
}

- (IBAction) browse:(id)sender  {
    
    int i;
    
    // Create a File Open Dialog class.
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    
    // Set array of file types
    NSArray *fileTypesArray;
    fileTypesArray = [NSArray arrayWithObjects:@"jpg", @"png", nil];
    
    // Enable options in the dialog.
    [openDlg setCanChooseFiles:YES];
    [openDlg setAllowedFileTypes:fileTypesArray];
    [openDlg setAllowsMultipleSelection:TRUE];
    
    // Display the dialog box.  If the OK pressed,
    // process the files.
    if ( [openDlg runModal] == NSOKButton ) {
        
        // Gets list of all files selected
        NSArray *files = [openDlg URLs];
        
        // Loop through the files and process them.
        for( i = 0; i < [files count]; i++ ) {
            
            // Scan images
            NSLog(@"File path: %@", [[files objectAtIndex:i] path]);
            [self scanImage:[[files objectAtIndex:i] path]];
            
        }
        
    }
    
}


@end
