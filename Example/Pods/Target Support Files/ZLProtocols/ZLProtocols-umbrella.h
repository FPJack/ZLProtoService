#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ZLTestModule1Proto.h"
#import "ZLTestModule2Proto.h"
#import "ZLTestModule3Proto.h"

FOUNDATION_EXPORT double ZLProtocolsVersionNumber;
FOUNDATION_EXPORT const unsigned char ZLProtocolsVersionString[];

