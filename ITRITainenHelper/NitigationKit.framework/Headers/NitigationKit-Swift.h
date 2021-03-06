// Generated by Apple Swift version 3.1 (swiftlang-802.0.53 clang-802.0.42)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if defined(__has_attribute) && __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if defined(__has_attribute) && __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if defined(__has_feature) && __has_feature(modules)
@import ObjectiveC;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"

SWIFT_CLASS("_TtC13NitigationKit6Beacon")
@interface Beacon : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull BEACON_COLUMN_PROJECT_ID;)
+ (NSString * _Nonnull)BEACON_COLUMN_PROJECT_ID SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull BEACON_COLUMN_FIELD_ID;)
+ (NSString * _Nonnull)BEACON_COLUMN_FIELD_ID SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull BEACON_COLUMN_BEACON_ID;)
+ (NSString * _Nonnull)BEACON_COLUMN_BEACON_ID SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull BEACON_COLUMN_MAC_ADDRESS;)
+ (NSString * _Nonnull)BEACON_COLUMN_MAC_ADDRESS SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull BEACON_COLUMN_ROLE;)
+ (NSString * _Nonnull)BEACON_COLUMN_ROLE SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull BEACON_COLUMN_BEACON_NAME;)
+ (NSString * _Nonnull)BEACON_COLUMN_BEACON_NAME SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull BEACON_COLUMN_X;)
+ (NSString * _Nonnull)BEACON_COLUMN_X SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull BEACON_COLUMN_Y;)
+ (NSString * _Nonnull)BEACON_COLUMN_Y SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull BEACON_COLUMN_POWER;)
+ (NSString * _Nonnull)BEACON_COLUMN_POWER SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull BEACON_COLUMN_DESCRIPTION;)
+ (NSString * _Nonnull)BEACON_COLUMN_DESCRIPTION SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull BEACON_COLUMN_IS_TRANSITION_POINT;)
+ (NSString * _Nonnull)BEACON_COLUMN_IS_TRANSITION_POINT SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull BEACON_COLUMN_ACTIVE;)
+ (NSString * _Nonnull)BEACON_COLUMN_ACTIVE SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull BEACON_COLUMN_IS_LOCK;)
+ (NSString * _Nonnull)BEACON_COLUMN_IS_LOCK SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull BEACON_COLUMN_CREATE_TIME;)
+ (NSString * _Nonnull)BEACON_COLUMN_CREATE_TIME SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull BEACON_COLUMN_LAST_UPDATE_TIME;)
+ (NSString * _Nonnull)BEACON_COLUMN_LAST_UPDATE_TIME SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull BEACON_COLUMN_IS_DELETE;)
+ (NSString * _Nonnull)BEACON_COLUMN_IS_DELETE SWIFT_WARN_UNUSED_RESULT;
@property (nonatomic, copy) NSString * _Nonnull projectId;
@property (nonatomic, copy) NSString * _Nonnull fieldId;
@property (nonatomic, copy) NSString * _Nonnull beaconId;
@property (nonatomic, copy) NSString * _Nonnull macAddress;
@property (nonatomic) NSInteger role;
@property (nonatomic, copy) NSString * _Nonnull beaconName;
@property (nonatomic) NSInteger x;
@property (nonatomic) NSInteger y;
@property (nonatomic) NSInteger power;
@property (nonatomic, copy) NSString * _Nonnull desc;
@property (nonatomic) NSInteger isTransitionPoint;
@property (nonatomic) NSInteger active;
@property (nonatomic) NSInteger isLock;
@property (nonatomic) NSInteger createTime;
@property (nonatomic) NSInteger lastUpdateTime;
- (nonnull instancetype)init;
- (nonnull instancetype)initWithProjectId:(NSString * _Nonnull)projectId fieldId:(NSString * _Nonnull)fieldId beaconId:(NSString * _Nonnull)beaconId macAddress:(NSString * _Nonnull)macAddress role:(NSInteger)role beaconName:(NSString * _Nonnull)beaconName x:(NSInteger)x y:(NSInteger)y power:(NSInteger)power desc:(NSString * _Nonnull)desc isTransitionPoint:(NSInteger)isTransitionPoint active:(NSInteger)active isLock:(NSInteger)isLock createTime:(NSInteger)createTime lastUpdateTime:(NSInteger)lastUpdateTime OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC13NitigationKit13ExternalPoint")
@interface ExternalPoint : NSObject
@property (nonatomic, copy) NSString * _Nonnull fieldId;
@property (nonatomic, copy) NSString * _Nonnull mapName;
@property (nonatomic) NSInteger x;
@property (nonatomic) NSInteger y;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC13NitigationKit8FieldMap")
@interface FieldMap : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull FIELD_MAP_COLUMN_PROJECT_ID;)
+ (NSString * _Nonnull)FIELD_MAP_COLUMN_PROJECT_ID SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull FIELD_MAP_COLUMN_FIELD_ID;)
+ (NSString * _Nonnull)FIELD_MAP_COLUMN_FIELD_ID SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull FIELD_MAP_COLUMN_FIELD_NAME;)
+ (NSString * _Nonnull)FIELD_MAP_COLUMN_FIELD_NAME SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull FIELD_MAP_COLUMN_DESCRIPTION;)
+ (NSString * _Nonnull)FIELD_MAP_COLUMN_DESCRIPTION SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull FIELD_MAP_COLUMN_MAP_NAME;)
+ (NSString * _Nonnull)FIELD_MAP_COLUMN_MAP_NAME SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull FIELD_MAP_COLUMN_PHOTO;)
+ (NSString * _Nonnull)FIELD_MAP_COLUMN_PHOTO SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull FIELD_MAP_COLUMN_VERSION;)
+ (NSString * _Nonnull)FIELD_MAP_COLUMN_VERSION SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull FIELD_MAP_COLUMN_CREATE_TIME;)
+ (NSString * _Nonnull)FIELD_MAP_COLUMN_CREATE_TIME SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull FIELD_MAP_COLUMN_LAST_UPDATE_TIME;)
+ (NSString * _Nonnull)FIELD_MAP_COLUMN_LAST_UPDATE_TIME SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull FIELD_MAP_COLUMN_IS_DELETE;)
+ (NSString * _Nonnull)FIELD_MAP_COLUMN_IS_DELETE SWIFT_WARN_UNUSED_RESULT;
@property (nonatomic, copy) NSString * _Nonnull projectId;
@property (nonatomic, copy) NSString * _Nonnull fieldId;
@property (nonatomic, copy) NSString * _Nonnull fieldName;
@property (nonatomic, copy) NSString * _Nonnull desc;
@property (nonatomic, copy) NSString * _Nonnull mapName;
@property (nonatomic, copy) NSString * _Nonnull photo;
@property (nonatomic, copy) NSString * _Nonnull version;
@property (nonatomic) NSInteger createTime;
@property (nonatomic) NSInteger lastUpdateTime;
- (nonnull instancetype)init;
- (nonnull instancetype)initWithProjectId:(NSString * _Nonnull)projectId fieldId:(NSString * _Nonnull)fieldId fieldName:(NSString * _Nonnull)fieldName desc:(NSString * _Nonnull)desc mapName:(NSString * _Nonnull)mapName photo:(NSString * _Nonnull)photo version:(NSString * _Nonnull)version createTime:(NSInteger)createTime lastUpdateTime:(NSInteger)lastUpdateTime OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC13NitigationKit9FieldRssi")
@interface FieldRssi : NSObject
@property (nonatomic, copy) NSString * _Nonnull fieldId;
@property (nonatomic, copy) NSDictionary<NSString *, NSNumber *> * _Nonnull beaconRssiData;
@property (nonatomic) NSInteger rssiTotal;
- (void)addRssiWithBeaconId:(NSString * _Nonnull)beaconId rssi:(NSInteger)rssi;
- (NSArray<NSString *> * _Nonnull)getSortedBeaconIdArray SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class PathConnector;

SWIFT_CLASS("_TtC13NitigationKit4Path")
@interface Path : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PATH_COLUMN_PROJECT_ID;)
+ (NSString * _Nonnull)PATH_COLUMN_PROJECT_ID SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PATH_COLUMN_FIELD_ID;)
+ (NSString * _Nonnull)PATH_COLUMN_FIELD_ID SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PATH_COLUMN_PATH_ID;)
+ (NSString * _Nonnull)PATH_COLUMN_PATH_ID SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PATH_COLUMN_PATH_CONNECTOR_ID_FROM;)
+ (NSString * _Nonnull)PATH_COLUMN_PATH_CONNECTOR_ID_FROM SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PATH_COLUMN_PATH_CONNECTOR_ID_TO;)
+ (NSString * _Nonnull)PATH_COLUMN_PATH_CONNECTOR_ID_TO SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PATH_COLUMN_DISTANCE;)
+ (NSString * _Nonnull)PATH_COLUMN_DISTANCE SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PATH_COLUMN_CREATE_TIME;)
+ (NSString * _Nonnull)PATH_COLUMN_CREATE_TIME SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PATH_COLUMN_LAST_UPDATE_TIME;)
+ (NSString * _Nonnull)PATH_COLUMN_LAST_UPDATE_TIME SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PATH_COLUMN_IS_DELETE;)
+ (NSString * _Nonnull)PATH_COLUMN_IS_DELETE SWIFT_WARN_UNUSED_RESULT;
@property (nonatomic, copy) NSString * _Nonnull projectId;
@property (nonatomic, copy) NSString * _Nonnull fieldId;
@property (nonatomic, copy) NSString * _Nonnull pathId;
@property (nonatomic, strong) PathConnector * _Nullable pathConnectorFrom;
@property (nonatomic, strong) PathConnector * _Nullable pathConnectorTo;
@property (nonatomic) NSInteger distance;
@property (nonatomic) NSInteger createTime;
@property (nonatomic) NSInteger lastUpdateTime;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithPath:(Path * _Nonnull)path OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC13NitigationKit13PathConnector")
@interface PathConnector : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PATH_CONNECTOR_COLUMN_PROJECT_ID;)
+ (NSString * _Nonnull)PATH_CONNECTOR_COLUMN_PROJECT_ID SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PATH_CONNECTOR_COLUMN_FIELD_ID;)
+ (NSString * _Nonnull)PATH_CONNECTOR_COLUMN_FIELD_ID SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PATH_CONNECTOR_COLUMN_PATH_CONNECTOR_ID;)
+ (NSString * _Nonnull)PATH_CONNECTOR_COLUMN_PATH_CONNECTOR_ID SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PATH_CONNECTOR_COLUMN_X;)
+ (NSString * _Nonnull)PATH_CONNECTOR_COLUMN_X SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PATH_CONNECTOR_COLUMN_Y;)
+ (NSString * _Nonnull)PATH_CONNECTOR_COLUMN_Y SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PATH_CONNECTOR_COLUMN_INSTRUCTION;)
+ (NSString * _Nonnull)PATH_CONNECTOR_COLUMN_INSTRUCTION SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PATH_CONNECTOR_COLUMN_IS_TRANSITION_POINT;)
+ (NSString * _Nonnull)PATH_CONNECTOR_COLUMN_IS_TRANSITION_POINT SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PATH_CONNECTOR_COLUMN_CREATE_TIME;)
+ (NSString * _Nonnull)PATH_CONNECTOR_COLUMN_CREATE_TIME SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PATH_CONNECTOR_COLUMN_LAST_UPDATE_TIME;)
+ (NSString * _Nonnull)PATH_CONNECTOR_COLUMN_LAST_UPDATE_TIME SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PATH_CONNECTOR_COLUMN_IS_DELETE;)
+ (NSString * _Nonnull)PATH_CONNECTOR_COLUMN_IS_DELETE SWIFT_WARN_UNUSED_RESULT;
@property (nonatomic, copy) NSString * _Nonnull projectId;
@property (nonatomic, copy) NSString * _Nonnull fieldId;
@property (nonatomic, copy) NSString * _Nonnull originalPathConnectorId;
@property (nonatomic, copy) NSString * _Nonnull pathConnectorId;
@property (nonatomic) NSInteger x;
@property (nonatomic) NSInteger y;
@property (nonatomic, copy) NSString * _Nonnull instruction;
@property (nonatomic) NSInteger isTransitionPoint;
@property (nonatomic) NSInteger createTime;
@property (nonatomic) NSInteger lastUpdateTime;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithPathConnector:(PathConnector * _Nonnull)pathConnector OBJC_DESIGNATED_INITIALIZER;
@end

@class Target;
@class Pin;

SWIFT_CLASS("_TtC13NitigationKit11PathManager")
@interface PathManager : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull SPLIT_DESTINATION_ON_PATH_LEFT;)
+ (NSString * _Nonnull)SPLIT_DESTINATION_ON_PATH_LEFT SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull SPLIT_DESTINATION_ON_PATH_RIGHT;)
+ (NSString * _Nonnull)SPLIT_DESTINATION_ON_PATH_RIGHT SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull DESTINATION_ON_PATH_CONNECTOR;)
+ (NSString * _Nonnull)DESTINATION_ON_PATH_CONNECTOR SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull SPLIT_SOURCE_ON_PATH_LEFT;)
+ (NSString * _Nonnull)SPLIT_SOURCE_ON_PATH_LEFT SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull SPLIT_SOURCE_ON_PATH_RIGHT;)
+ (NSString * _Nonnull)SPLIT_SOURCE_ON_PATH_RIGHT SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull SOURCE_ON_PATH_CONNECTOR;)
+ (NSString * _Nonnull)SOURCE_ON_PATH_CONNECTOR SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (void)setPathDataWithPathConnectorData:(NSDictionary<NSString *, PathConnector *> * _Nonnull)pathConnectorData pathData:(NSDictionary<NSString *, Path *> * _Nonnull)pathData;
- (void)setPathDataWithPathData:(NSDictionary<NSString *, Path *> * _Nonnull)pathData;
- (void)injectTargetWithTarget:(Target * _Nonnull)target;
- (void)injectTransitionPointWithTransitionPoint:(PathConnector * _Nonnull)transitionPoint;
- (NSString * _Nonnull)findNearByPathObjectWithX:(NSInteger)x y:(NSInteger)y SWIFT_WARN_UNUSED_RESULT;
- (void)injectPinWithPin:(Pin * _Nonnull)pin;
- (NSArray<PathConnector *> * _Nullable)computeRoute SWIFT_WARN_UNUSED_RESULT;
@end


SWIFT_CLASS("_TtC13NitigationKit3Pin")
@interface Pin : ExternalPoint
@property (nonatomic, copy) NSString * _Nonnull onPathObjectId;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC13NitigationKit7Project")
@interface Project : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PROJECT_COLUMN_PROJECT_ID;)
+ (NSString * _Nonnull)PROJECT_COLUMN_PROJECT_ID SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PROJECT_COLUMN_PROJECT_NAME;)
+ (NSString * _Nonnull)PROJECT_COLUMN_PROJECT_NAME SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PROJECT_COLUMN_VERSION;)
+ (NSString * _Nonnull)PROJECT_COLUMN_VERSION SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PROJECT_COLUMN_DESCRIPTION;)
+ (NSString * _Nonnull)PROJECT_COLUMN_DESCRIPTION SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PROJECT_COLUMN_BEACON_POWER_REPORT_PERIOD;)
+ (NSString * _Nonnull)PROJECT_COLUMN_BEACON_POWER_REPORT_PERIOD SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PROJECT_COLUMN_BEACON_POWER_REPORT_THRESHOLD;)
+ (NSString * _Nonnull)PROJECT_COLUMN_BEACON_POWER_REPORT_THRESHOLD SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PROJECT_COLUMN_BEACON_SCAN_PERIOD;)
+ (NSString * _Nonnull)PROJECT_COLUMN_BEACON_SCAN_PERIOD SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PROJECT_COLUMN_BEACON_SCAN_PAUSE;)
+ (NSString * _Nonnull)PROJECT_COLUMN_BEACON_SCAN_PAUSE SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PROJECT_COLUMN_RSSI_SIGNAL_MAX;)
+ (NSString * _Nonnull)PROJECT_COLUMN_RSSI_SIGNAL_MAX SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PROJECT_COLUMN_RSSI_SIGNAL_MIN;)
+ (NSString * _Nonnull)PROJECT_COLUMN_RSSI_SIGNAL_MIN SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PROJECT_COLUMN_DEFAULT_FIELD;)
+ (NSString * _Nonnull)PROJECT_COLUMN_DEFAULT_FIELD SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PROJECT_COLUMN_CREATE_TIME;)
+ (NSString * _Nonnull)PROJECT_COLUMN_CREATE_TIME SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PROJECT_COLUMN_LAST_UPDATE_TIME;)
+ (NSString * _Nonnull)PROJECT_COLUMN_LAST_UPDATE_TIME SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PROJECT_COLUMN_IS_DELETE;)
+ (NSString * _Nonnull)PROJECT_COLUMN_IS_DELETE SWIFT_WARN_UNUSED_RESULT;
@property (nonatomic, copy) NSString * _Nonnull projectId;
@property (nonatomic, copy) NSString * _Nonnull projectName;
@property (nonatomic, copy) NSString * _Nonnull version;
@property (nonatomic, copy) NSString * _Nonnull desc;
@property (nonatomic) NSInteger beaconPowerReportPeriod;
@property (nonatomic) NSInteger beaconPowerReportThreshold;
@property (nonatomic) NSInteger beaconScanPeriod;
@property (nonatomic) NSInteger beaconScanPause;
@property (nonatomic) NSInteger rssiSignalMax;
@property (nonatomic) NSInteger rssiSignalMin;
@property (nonatomic, copy) NSString * _Nonnull defaultField;
@property (nonatomic) NSInteger createTime;
@property (nonatomic) NSInteger lastUpdateTime;
- (nonnull instancetype)init;
- (nonnull instancetype)initWithProjectId:(NSString * _Nonnull)projectId projectName:(NSString * _Nonnull)projectName version:(NSString * _Nonnull)version desc:(NSString * _Nonnull)desc beaconPowerReportPeriod:(NSInteger)beaconPowerReportPeriod beaconPowerReportThreshold:(NSInteger)beaconPowerReportThreshold beaconScanPeriod:(NSInteger)beaconScanPeriod beaconScanPause:(NSInteger)beaconScanPause rssiSignalMax:(NSInteger)rssiSignalMax rssiSignalMin:(NSInteger)rssiSignalMin defaultField:(NSString * _Nonnull)defaultField createTime:(NSInteger)createTime lastUpdateTime:(NSInteger)lastUpdateTime OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC13NitigationKit11ProjectFile")
@interface ProjectFile : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PROJECT_FILE_COLUMN_PROJECT_ID;)
+ (NSString * _Nonnull)PROJECT_FILE_COLUMN_PROJECT_ID SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PROJECT_FILE_COLUMN_FILE_ID;)
+ (NSString * _Nonnull)PROJECT_FILE_COLUMN_FILE_ID SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PROJECT_FILE_COLUMN_FILE_NAME;)
+ (NSString * _Nonnull)PROJECT_FILE_COLUMN_FILE_NAME SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PROJECT_FILE_COLUMN_DESCRIPTION;)
+ (NSString * _Nonnull)PROJECT_FILE_COLUMN_DESCRIPTION SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PROJECT_FILE_COLUMN_CREATE_TIME;)
+ (NSString * _Nonnull)PROJECT_FILE_COLUMN_CREATE_TIME SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, copy) NSString * _Nonnull PROJECT_FILE_COLUMN_LAST_UPDATE_TIME;)
+ (NSString * _Nonnull)PROJECT_FILE_COLUMN_LAST_UPDATE_TIME SWIFT_WARN_UNUSED_RESULT;
@property (nonatomic, copy) NSString * _Nonnull projectId;
@property (nonatomic, copy) NSString * _Nonnull fileId;
@property (nonatomic, copy) NSString * _Nonnull fileName;
@property (nonatomic, copy) NSString * _Nonnull desc;
@property (nonatomic) NSInteger createTime;
@property (nonatomic) NSInteger lastUpdateTime;
- (nonnull instancetype)init;
- (nonnull instancetype)initWithProjectId:(NSString * _Nonnull)projectId fileId:(NSString * _Nonnull)fileId fileName:(NSString * _Nonnull)fileName desc:(NSString * _Nonnull)desc createTime:(NSInteger)createTime lastUpdateTime:(NSInteger)lastUpdateTime OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC13NitigationKit6Target")
@interface Target : ExternalPoint
@property (nonatomic, copy) NSString * _Nonnull nearByPathId;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

#pragma clang diagnostic pop
