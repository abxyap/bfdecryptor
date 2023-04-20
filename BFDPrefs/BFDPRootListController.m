#include "BFDPRootListController.h"
#include "../rootless.h"
#define PREFERENCE_IDENTIFIER ROOT_PATH_NS(@"/var/mobile/Library/Preferences/alias20.bfdecryptor.plist")

NSMutableDictionary *prefs;

@implementation BFDPRootListController

-(NSArray*)getSpecifiersForAppSection:(NSInteger)type {
    NSArray<LSApplicationProxy*>* allInstalledApplications = [[LSApplicationWorkspace defaultWorkspace] atl_allInstalledApplications];
    NSArray<ATLApplicationSection*>* appSections = @[[[[ATLApplicationSection alloc] init] initNonCustomSectionWithType:type]];
    
    [appSections enumerateObjectsUsingBlock:^(ATLApplicationSection* section, NSUInteger idx, BOOL *stop)
     {
        [section populateFromAllApplications:allInstalledApplications];
    }];
    
    static NSArray* specifiersForSection;
    [appSections enumerateObjectsUsingBlock:^(ATLApplicationSection* section, NSUInteger idx, BOOL *stop)
     {
        specifiersForSection = [[ATLApplicationListControllerBase alloc] createSpecifiersForApplicationSection:section];
        //            NSLog(@"[BFDecryptor] groupSpecifier: %@, specifiersForSection: %@", groupSpecifier, specifiersForSection);
    }];
    
    return specifiersForSection;
}

- (NSArray *)specifiers {
	if (!_specifiers) {
        [self getPreference];
        NSMutableArray *specifiers = [[NSMutableArray alloc] init];
        [specifiers addObject:({
            PSSpecifier *specifier = [PSSpecifier preferenceSpecifierNamed:@"BFDecryptor Settings" target:self set:nil get:nil detail:nil cell:PSGroupCell edit:nil];
            specifier;
        })];
        
        NSArray *appSpecifiers = [self getSpecifiersForAppSection:SECTION_TYPE_USER];
        for(PSSpecifier *spec in appSpecifiers) {
            PSSpecifier *specifier = [PSSpecifier preferenceSpecifierNamed:[spec name] target:self set:@selector(setSwitch:forSpecifier:) get:@selector(getSwitch:) detail:nil cell:PSSwitchCell edit:nil];
            [specifier.properties setValue:[spec propertyForKey:@"applicationIdentifier"] forKey:@"displayIdentifier"];
            UIImage *icon = [spec propertyForKey:@"iconImage"];
            if (icon) [specifier setProperty:icon forKey:@"iconImage"];
            [specifiers addObject:specifier];
        }
        
        
        _specifiers = [specifiers copy];
	}

	return _specifiers;
}



-(void)setSwitch:(NSNumber *)value forSpecifier:(PSSpecifier *)specifier {
    prefs[[specifier propertyForKey:@"displayIdentifier"]] = [NSNumber numberWithBool:[value boolValue]];
    [[prefs copy] writeToFile:PREFERENCE_IDENTIFIER atomically:FALSE];
}
-(NSNumber *)getSwitch:(PSSpecifier *)specifier {
    return [prefs[[specifier propertyForKey:@"displayIdentifier"]] isEqual:@1] ? @1 : @0;
}

-(void)getPreference {
    if(![[NSFileManager defaultManager] fileExistsAtPath:PREFERENCE_IDENTIFIER]) prefs = [[NSMutableDictionary alloc] init];
    else prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PREFERENCE_IDENTIFIER];
}

@end
