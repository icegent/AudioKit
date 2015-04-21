//
//  TableTests.m
//  iOSObjectiveCAudioKit
//
//  Created by Aurelius Prochazka on 4/18/15.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "AppDelegate.h"

static CGFloat const AK_ACCURACY = 0.001f;

@interface TableTests : XCTestCase

@end

@implementation TableTests {
    AppDelegate *vc;
}

- (void)setUp {
    [super setUp];
    vc = (AppDelegate *)[[NSApplication sharedApplication] delegate];
}

- (void)testTableValueLookup {
    XCTAssertEqualWithAccuracy(vc.tableTestInstrument.tableValue.value,  1,   AK_ACCURACY);
}

- (void)testStandardSineWave {
    AKTable *sine = vc.tableTestInstrument.sine;
    for (int i = 0; i < 10; i++) {
        XCTAssertEqualWithAccuracy([sine valueAtFractionalWidth:0.1 * i], sinf(0.1 * i * 2 * M_PI), AK_ACCURACY);
    }
}

- (void)testStandardSquareWave {
    AKTable *square = vc.tableTestInstrument.square;
    XCTAssertEqualWithAccuracy([square valueAtFractionalWidth:0.01],  1, AK_ACCURACY);
    XCTAssertEqualWithAccuracy([square valueAtFractionalWidth:0.49],  1, AK_ACCURACY);
    XCTAssertEqualWithAccuracy([square valueAtFractionalWidth:0.51], -1, AK_ACCURACY);
    XCTAssertEqualWithAccuracy([square valueAtFractionalWidth:0.99], -1, AK_ACCURACY);
}

- (void)testStandardTriangleWave {
    AKTable *triangle = vc.tableTestInstrument.triangle;
    XCTAssertEqualWithAccuracy([triangle valueAtFractionalWidth:0.0],  0,   AK_ACCURACY);
    XCTAssertEqualWithAccuracy([triangle valueAtFractionalWidth:0.1],  0.4, AK_ACCURACY);
    XCTAssertEqualWithAccuracy([triangle valueAtFractionalWidth:0.25], 1,   AK_ACCURACY);
    XCTAssertEqualWithAccuracy([triangle valueAtFractionalWidth:0.5],  0,   AK_ACCURACY);
    XCTAssertEqualWithAccuracy([triangle valueAtFractionalWidth:0.75], -1,  AK_ACCURACY);
}

- (void)testStandardSawtoothWave {
    AKTable *sawtooth = vc.tableTestInstrument.sawtooth;
    for (int i = 0; i < 10; i++) {
        XCTAssertEqualWithAccuracy([sawtooth valueAtFractionalWidth:0.1 * i], -1 + 2 * (0.1 * i), AK_ACCURACY);
    }
}
- (void)testStandardReverseSawtoothWave {
    AKTable *reverseSatooth = vc.tableTestInstrument.reverseSawtooth;
    for (int i = 0; i < 10; i++) {
        XCTAssertEqualWithAccuracy([reverseSatooth valueAtFractionalWidth:0.1 * i], 1 - 2 * (0.1 * i), AK_ACCURACY);
    }
}

- (void)testExponentialTable {
    AKTable *exponentialTable = vc.tableTestInstrument.exponential;
    XCTAssertEqualWithAccuracy([exponentialTable valueAtFractionalWidth:0.0],  0.1, AK_ACCURACY);
    XCTAssertEqualWithAccuracy([exponentialTable valueAtFractionalWidth:0.25], 1,   AK_ACCURACY);
    XCTAssertEqualWithAccuracy([exponentialTable valueAtFractionalWidth:0.5],  0.1, AK_ACCURACY);
    XCTAssertEqualWithAccuracy([exponentialTable valueAtFractionalWidth:0.75], 1,   AK_ACCURACY);
    XCTAssertEqualWithAccuracy([exponentialTable valueAtFractionalWidth:1.0],  0.1, AK_ACCURACY);
    
    // Test some off value ones too
    XCTAssertEqualWithAccuracy([exponentialTable valueAtFractionalWidth:0.1],  0.251132, AK_ACCURACY);
    XCTAssertEqualWithAccuracy([exponentialTable valueAtFractionalWidth:0.4],  0.251263, AK_ACCURACY);
    XCTAssertEqualWithAccuracy([exponentialTable valueAtFractionalWidth:0.6],  0.251132, AK_ACCURACY);
    XCTAssertEqualWithAccuracy([exponentialTable valueAtFractionalWidth:0.9],  0.251263, AK_ACCURACY);
}

- (void)testArrayTable {
    AKTable *arrayTable = vc.tableTestInstrument.array;
    XCTAssertEqual([arrayTable valueAtIndex:0], 123);
    XCTAssertEqual([arrayTable valueAtIndex:1], 456);
}

- (void)testHammingWindow {
    AKTable *hamming = vc.tableTestInstrument.hamming;
    XCTAssertEqualWithAccuracy([hamming valueAtFractionalWidth:0.0],  0.08, AK_ACCURACY);
    XCTAssertEqualWithAccuracy([hamming valueAtFractionalWidth:0.25], 0.54, AK_ACCURACY);
    XCTAssertEqualWithAccuracy([hamming valueAtFractionalWidth:0.5],  1,    AK_ACCURACY);
    XCTAssertEqualWithAccuracy([hamming valueAtFractionalWidth:0.75], 0.54, AK_ACCURACY);
    XCTAssertEqualWithAccuracy([hamming valueAtFractionalWidth:1.0],  0.08, AK_ACCURACY);
}

- (void)testHannWindow {
    AKTable *hann = vc.tableTestInstrument.hann;
    XCTAssertEqualWithAccuracy([hann valueAtFractionalWidth:0.0],  0.0, AK_ACCURACY);
    XCTAssertEqualWithAccuracy([hann valueAtFractionalWidth:0.25], 0.5, AK_ACCURACY);
    XCTAssertEqualWithAccuracy([hann valueAtFractionalWidth:0.5],  1,   AK_ACCURACY);
    XCTAssertEqualWithAccuracy([hann valueAtFractionalWidth:0.75], 0.5, AK_ACCURACY);
    XCTAssertEqualWithAccuracy([hann valueAtFractionalWidth:1.0],  0.0, AK_ACCURACY);
}

- (void)testGaussianWindow {
    AKTable *gaussian = vc.tableTestInstrument.gaussian;
    XCTAssertEqualWithAccuracy([gaussian valueAtFractionalWidth:0.0],  0.0,       AK_ACCURACY);
    XCTAssertEqualWithAccuracy([gaussian valueAtFractionalWidth:0.25], 0.011109,  AK_ACCURACY);
    XCTAssertEqualWithAccuracy([gaussian valueAtFractionalWidth:0.5],  1,         AK_ACCURACY);
    XCTAssertEqualWithAccuracy([gaussian valueAtFractionalWidth:0.75], 0.0111109, AK_ACCURACY);
    XCTAssertEqualWithAccuracy([gaussian valueAtFractionalWidth:1.0],  0.0,       AK_ACCURACY);
}

- (void)testKaiserWindow {
    AKTable *kaiser = vc.tableTestInstrument.kaiser;
    XCTAssertEqualWithAccuracy([kaiser valueAtFractionalWidth:0.0],  0.78948,  AK_ACCURACY);
    XCTAssertEqualWithAccuracy([kaiser valueAtFractionalWidth:0.25], 0.945033, AK_ACCURACY);
    XCTAssertEqualWithAccuracy([kaiser valueAtFractionalWidth:0.5],  1,        AK_ACCURACY);
    XCTAssertEqualWithAccuracy([kaiser valueAtFractionalWidth:0.75], 0.945033, AK_ACCURACY);
    XCTAssertEqualWithAccuracy([kaiser valueAtFractionalWidth:1.0],  0.789848, AK_ACCURACY);
}

- (void)testHarmonicCosine {
    AKTable *cosine = vc.tableTestInstrument.cosine;
    XCTAssertEqualWithAccuracy([cosine valueAtFractionalWidth:0.0],  1,         AK_ACCURACY);
    XCTAssertEqualWithAccuracy([cosine valueAtFractionalWidth:0.25], -0.149133, AK_ACCURACY);
    XCTAssertEqualWithAccuracy([cosine valueAtFractionalWidth:0.5],  -0.176471, AK_ACCURACY);
    XCTAssertEqualWithAccuracy([cosine valueAtFractionalWidth:0.75], -0.149133, AK_ACCURACY);
    XCTAssertEqualWithAccuracy([cosine valueAtFractionalWidth:1.0], 1,          AK_ACCURACY);
}

- (void)testRandom {
    AKTable *random = vc.tableTestInstrument.random;
    // How to test random, this is not good enough...
    XCTAssertNotEqualWithAccuracy([random valueAtIndex:0],[random valueAtIndex:1], AK_ACCURACY);
    XCTAssertNotEqualWithAccuracy([random valueAtIndex:1],[random valueAtIndex:2], AK_ACCURACY);
    XCTAssertNotEqualWithAccuracy([random valueAtIndex:2],[random valueAtIndex:0], AK_ACCURACY);
}

@end
