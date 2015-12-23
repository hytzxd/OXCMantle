
//
//  OXModel.m
//  Oxen
//
//  Created by Matthew on 6/16/14.
//  Released under the MIT license
//

#import "OXModel.h"
#import <objc/runtime.h>
#import "NSString+ValidationUtils.h"
#import "OXValidationFunctions.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

static const void *OXObjectiveTypsKeys = &OXObjectiveTypsKeys;

typedef NS_ENUM(NSUInteger, OXPropertyType){
    OXPropertyUnknown = 0,
	OXPropertyTypeString,
	OXPropertyTypeBool,
	OXPropertyTypeNumber,
	OXPropertyTypeInteger,
	OXPropertyTypeFloat,
	OXPropertyTypeArray,
	OXPropertyTypeMutableArray,
	OXPropertyTypeDictionary,
	OXPropertyTypeMutableDictionary,
	OXPropertyTypeUnsignedInteger,
	OXPropertyTypeDate,
	OXPropertyTypeDouble,
    OXPropertyTypeLong,
    OXPropertyTypeUnsignedLong,
};

@interface OXModel ()

@property (nonatomic, readwrite, strong) NSString *dictionaryKey;
@end


@implementation OXModel {
    dispatch_once_t keyToken;
}

static NSMutableDictionary *modelProperties;
static dispatch_once_t onceToken;
static NSArray *propertyTypesArray;

+ (void)initialize {
    [super initialize];
    
    dispatch_once(&onceToken, ^{
        modelProperties = [NSMutableDictionary dictionary];
        propertyTypesArray = @[@"Unknown",
							   @"NSString",
							   [NSString stringWithFormat:@"%s",@encode(BOOL)],
							   @"NSNumber",
							   [NSString stringWithFormat:@"%s",@encode(int)],
							   [NSString stringWithFormat:@"%s",@encode(float)],
							   @"NSArray",
							   @"NSMutableArray",
							   @"NSDictionary",
							   @"NSMutableDictionary",
							   [NSString stringWithFormat:@"%s",@encode(unsigned int)],
							   @"NSDate",
							   [NSString stringWithFormat:@"%s",@encode(double)],
                               [NSString stringWithFormat:@"%s",@encode(long)],
                               [NSString stringWithFormat:@"%s",@encode(unsigned long)],
                               ];
    });
	
    [self hydrateModelProperties:[self class] translateDictionary:nil];
}

+ (NSString *)calculateClassName {
    NSString *className = NSStringFromClass([self class]);
    NSRange ido = [className rangeOfString:@"-"];
    NSUInteger cdo = ido.location;
    if (cdo < className.length){
        className = [className substringFromIndex:cdo];
    }
    return className;
}

+ (void)hydrateModelProperties:(Class)class translateDictionary:(NSMutableDictionary *)translateDictionary {
    if (!class || class == [NSObject class]){
        return;
    }
	
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(class, &outCount);
    for (i = 0; i < outCount; i++){
        objc_property_t p = properties[i];
        const char *name = property_getName(p);
        NSString *nsName = [[NSString alloc] initWithCString:name encoding:NSUTF8StringEncoding];
        NSString *lowerCaseName = [nsName lowercaseString];
        [translateDictionary setObject:nsName forKey:lowerCaseName];
        NSString *propertyType = [self getPropertyType:p];
        [self addValidatorForProperty:nsName type:propertyType];
    }
    free(properties);
    
    [self hydrateModelProperties:class_getSuperclass(class) translateDictionary:translateDictionary];
}

+ (NSString *)getPropertyType:(objc_property_t)property {
    if (!property) {
        return nil;
    }
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    NSData *propertyType = nil;
    while ((attribute = strsep(&state, ",")) != NULL){
        if (attribute[0] == 'T' && attribute[1] != '@') {
            propertyType = [NSData dataWithBytes:(attribute + 1) length:strlen(attribute) - 1];
        } else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            propertyType = [NSData dataWithBytes:"id" length:2];
        } else if (attribute[0] == 'T' && attribute[1] == '@') {
            propertyType = [NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4];
        }
    }
	
    return [[NSString alloc] initWithData:propertyType encoding:NSUTF8StringEncoding];
}

+ (void)addValidatorForProperty:(NSString *)propertyName type:(NSString *)propertyType {
    IMP implementation;
    OXPropertyType type;
    
    NSUInteger n = [propertyTypesArray indexOfObject:propertyType];
	
    if (n == NSNotFound){
        type = OXPropertyUnknown;
    } else {
        type = (OXPropertyType)n;
    }
	
    switch (type){
        case OXPropertyTypeString:
            implementation = (IMP)validateStringProperty;
            break;
        case OXPropertyTypeBool:
            implementation = (IMP)validateBoolProperty;
            break;
        case OXPropertyTypeNumber:
            implementation = (IMP)validateNumberProperty;
            break;
        case OXPropertyTypeInteger:
            implementation = (IMP)validateIntegerProperty;
            break;
        case OXPropertyTypeFloat:
            implementation = (IMP)validateFloatProperty;
            break;
        case OXPropertyTypeArray:
        case OXPropertyTypeMutableArray:
            implementation = (IMP)validateArrayProperty;
            break;
        case OXPropertyTypeDictionary:
        case OXPropertyTypeMutableDictionary:
            implementation = (IMP)validateDictionaryProperty;
            break;
        case OXPropertyTypeUnsignedInteger:
            implementation = (IMP)validateUnsignedIntegerProperty;
            break;
        case OXPropertyTypeDate:
            implementation = (IMP)validateDateProperty;
            break;
        case OXPropertyTypeDouble:
            implementation = (IMP)validateDoubleProperty;
            break;
        case OXPropertyTypeLong:
            implementation = (IMP)validateLongProperty;
            break;
        case OXPropertyTypeUnsignedLong:
            implementation = (IMP)validateUnsignedLongProperty;
            break;
        default:
            implementation = nil;
            break;
    }
    if (implementation){
        NSString *methodName = [self generateValidationMethodName:propertyName];
        class_addMethod([self class], NSSelectorFromString(methodName), implementation, "c@:^@^@");
    }
}

+(NSString *)generateValidationMethodName:(NSString *)key{
    return [NSString stringWithFormat:@"validate%@:error:", [NSString capitalizeFirstCharacter:key]];
}

- (NSString *)dictionaryKey {
    dispatch_once(&keyToken, ^{
        _dictionaryKey = [[self class] calculateClassName];
    });
    return _dictionaryKey;
}

+ (NSMutableDictionary*)objectivePropertyTypes:(Class)class{
	NSMutableDictionary *objectiveTypes = objc_getAssociatedObject(class, OXObjectiveTypsKeys);
    if (!objectiveTypes) {
        Class supperClass = class_getSuperclass(class);
        if (supperClass) {
            objectiveTypes = [self objectivePropertyTypes:supperClass];
            if (objectiveTypes) objectiveTypes = [objectiveTypes mutableCopy];
        }
        objectiveTypes = objectiveTypes ?: [NSMutableDictionary dictionary];
        objc_setAssociatedObject(class, OXObjectiveTypsKeys, objectiveTypes, OBJC_ASSOCIATION_RETAIN);
        unsigned int outCount, i;
        objc_property_t *properties = class_copyPropertyList(class, &outCount);
        for (i = 0; i < outCount; i++){
            objc_property_t p = properties[i];
            NSString* propertyType = [self getPropertyType:p];
            NSUInteger n = [propertyTypesArray indexOfObject:propertyType];
            if (n == NSNotFound){
                objectiveTypes[@(property_getName(p))] = propertyType;
            }
        }
    }
    return objectiveTypes;
}


/**
 *  获取数组抽象协议名
 *
 *  @param protocolName 类型名
 *
 *  @return 抽象协议名，实为数组实际存储类型
 */
+(NSString*) getArrayProtocolName:(NSString*) protocolName
{
    NSString *name = nil;
    NSRange range;
    if([protocolName hasPrefix:@"NSArray<"])
    {
        NSRange r = [protocolName rangeOfString:@">" options:NSBackwardsSearch];
        if(r.location != NSNotFound)
        {
            range = NSMakeRange(8, r.location - 8);
            if(range.location != NSNotFound)
                name = [protocolName substringWithRange:range];
        }
    }
    else if([protocolName hasPrefix:@"NSMutableArray<"])
    {
        NSRange r = [protocolName rangeOfString:@">" options:NSBackwardsSearch];
        if(r.location != NSNotFound)
        {
            range = NSMakeRange(15, r.location - 15);
            if(range.location != NSNotFound)
                name = [protocolName substringWithRange:range];
        }
    }
    
    return name;
}

- (NSString *)compactDescription{
    NSDictionary *jsonDict = [MTLJSONAdapter JSONDictionaryFromModel:self error:nil];
    NSError *err;
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:&err]
                                 encoding:NSUTF8StringEncoding];
}

- (NSString*)description
{
    NSDictionary *jsonDict = [MTLJSONAdapter JSONDictionaryFromModel:self error:nil];
    return [NSString stringWithFormat:@"%@", jsonDict];
}

/* 获取对象的所有属性和属性内容 */
- (NSDictionary *)getAllPropertiesAndVaules
{
    u_int count;
    objc_property_t *properties;
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    //从当前类到所有父类的属性对象全部遍历
    for (Class temp = [self class]; [temp isSubclassOfClass:[OXModel class]]; temp = [temp superclass]) {
        //        DLOG(@"%@", temp);
        
        properties = class_copyPropertyList(temp, &count);
        for (int i = 0; i < count; i++)
        {
            objc_property_t property = properties[i];
            const char *char_f = property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
            id propertyValue = [self valueForKey:(NSString *)propertyName];
            if (propertyValue) {
                [props setObject:propertyValue forKey:propertyName];
            }
            //            DLOG(@"%@", propertyName);
        }
        free(properties);
    }
    
    return props;
}

#pragma mark - MTLJSONSerializing
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(self, &outCount);
    NSMutableDictionary* keys = [NSMutableDictionary dictionaryWithCapacity:outCount];
    for (i = 0; i < outCount; i++){
        objc_property_t p = properties[i];
        const char *name = property_getName(p);
        NSString *nsName = [[NSString alloc] initWithCString:name encoding:NSUTF8StringEncoding];
        keys[nsName] = nsName;
    }
    return keys;
}

+ (NSValueTransformer*)JSONTransformerForKey:(NSString*)key{
    NSString* type = [self objectivePropertyTypes:self][key];
//    type = [type isEqualToString:@"id"] ? nil : type;
    
    return !type ? nil : [MTLJSONAdapter dictionaryTransformerWithModelClass:(NSClassFromString(type))];
    
    
    /*objc_property_t p = class_getProperty([self class], key.UTF8String);
    NSString *TypeName = [self getPropertyType:p];
    Class subClass = NSClassFromString(TypeName);
    if(subClass)
    {
        if([subClass isSubclassOfClass:[MTLModel class] ] && [subClass conformsToProtocol:@protocol(MTLJSONSerializing)])
        {
            return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:subClass];
        }
    }
    else
    {
        NSString *protocolName = [self getArrayProtocolName:TypeName];
        subClass  = NSClassFromString(protocolName);
        if(subClass)
        {
            return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:subClass];
        }
    }
    return nil;*/
}
@end