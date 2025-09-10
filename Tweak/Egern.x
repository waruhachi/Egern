#include <substrate.h>
#include <objc/runtime.h>

// This class will be loaded at runtime
static Class EgernStoreClass = nil;

%hook NSObject

// Hook initialization of all objects to find our target
- (id)init {
	id result = %orig;
	
	// Check if this is the class we're looking for
	if ([NSStringFromClass([self class]) isEqualToString:@"_TtCs12_SwiftObject"] ||
		[NSStringFromClass([self class]) isEqualToString:@"Egern.Store"]) {
		
		// Log to help with debugging
		NSLog(@"[EgernProUnlock] Potential Egern.Store object found: %@", [self class]);
		
		// Store the class for later use
		if (!EgernStoreClass) {
			EgernStoreClass = [self class];
		}
		
		// Try to find and modify the iVar
		Ivar ivar = class_getInstanceVariable([self class], "_isProUnlocked");
		if (ivar) {
			NSLog(@"[EgernProUnlock] Found _isProUnlocked iVar, setting to true");
			BOOL yes = YES;
			// Set the iVar to true
			object_setIvar(self, ivar, @(YES));
		}
	}
	
	return result;
}

%end