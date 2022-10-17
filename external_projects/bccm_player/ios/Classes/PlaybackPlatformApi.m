// Autogenerated from Pigeon (v3.2.7), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import "PlaybackPlatformApi.h"
#import <Flutter/Flutter.h>

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSDictionary<NSString *, id> *wrapResult(id result, FlutterError *error) {
  NSDictionary *errorDict = (NSDictionary *)[NSNull null];
  if (error) {
    errorDict = @{
        @"code": (error.code ?: [NSNull null]),
        @"message": (error.message ?: [NSNull null]),
        @"details": (error.details ?: [NSNull null]),
        };
  }
  return @{
      @"result": (result ?: [NSNull null]),
      @"error": errorDict,
      };
}
static id GetNullableObject(NSDictionary* dict, id key) {
  id result = dict[key];
  return (result == [NSNull null]) ? nil : result;
}
static id GetNullableObjectAtIndex(NSArray* array, NSInteger key) {
  id result = array[key];
  return (result == [NSNull null]) ? nil : result;
}


@interface NpawConfig ()
+ (NpawConfig *)fromMap:(NSDictionary *)dict;
+ (nullable NpawConfig *)nullableFromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end
@interface AppConfig ()
+ (AppConfig *)fromMap:(NSDictionary *)dict;
+ (nullable AppConfig *)nullableFromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end
@interface User ()
+ (User *)fromMap:(NSDictionary *)dict;
+ (nullable User *)nullableFromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end
@interface MediaItem ()
+ (MediaItem *)fromMap:(NSDictionary *)dict;
+ (nullable MediaItem *)nullableFromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end
@interface MediaMetadata ()
+ (MediaMetadata *)fromMap:(NSDictionary *)dict;
+ (nullable MediaMetadata *)nullableFromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end
@interface ChromecastState ()
+ (ChromecastState *)fromMap:(NSDictionary *)dict;
+ (nullable ChromecastState *)nullableFromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end
@interface PositionUpdateEvent ()
+ (PositionUpdateEvent *)fromMap:(NSDictionary *)dict;
+ (nullable PositionUpdateEvent *)nullableFromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end
@interface IsPlayingChangedEvent ()
+ (IsPlayingChangedEvent *)fromMap:(NSDictionary *)dict;
+ (nullable IsPlayingChangedEvent *)nullableFromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end
@interface PictureInPictureModeChangedEvent ()
+ (PictureInPictureModeChangedEvent *)fromMap:(NSDictionary *)dict;
+ (nullable PictureInPictureModeChangedEvent *)nullableFromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end
@interface MediaItemTransitionEvent ()
+ (MediaItemTransitionEvent *)fromMap:(NSDictionary *)dict;
+ (nullable MediaItemTransitionEvent *)nullableFromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end

@implementation NpawConfig
+ (instancetype)makeWithAppName:(nullable NSString *)appName
    appReleaseVersion:(nullable NSString *)appReleaseVersion
    accountCode:(nullable NSString *)accountCode {
  NpawConfig* pigeonResult = [[NpawConfig alloc] init];
  pigeonResult.appName = appName;
  pigeonResult.appReleaseVersion = appReleaseVersion;
  pigeonResult.accountCode = accountCode;
  return pigeonResult;
}
+ (NpawConfig *)fromMap:(NSDictionary *)dict {
  NpawConfig *pigeonResult = [[NpawConfig alloc] init];
  pigeonResult.appName = GetNullableObject(dict, @"appName");
  pigeonResult.appReleaseVersion = GetNullableObject(dict, @"appReleaseVersion");
  pigeonResult.accountCode = GetNullableObject(dict, @"accountCode");
  return pigeonResult;
}
+ (nullable NpawConfig *)nullableFromMap:(NSDictionary *)dict { return (dict) ? [NpawConfig fromMap:dict] : nil; }
- (NSDictionary *)toMap {
  return @{
    @"appName" : (self.appName ?: [NSNull null]),
    @"appReleaseVersion" : (self.appReleaseVersion ?: [NSNull null]),
    @"accountCode" : (self.accountCode ?: [NSNull null]),
  };
}
@end

@implementation AppConfig
+ (instancetype)makeWithAppLanguage:(nullable NSString *)appLanguage
    audioLanguage:(nullable NSString *)audioLanguage
    subtitleLanguage:(nullable NSString *)subtitleLanguage {
  AppConfig* pigeonResult = [[AppConfig alloc] init];
  pigeonResult.appLanguage = appLanguage;
  pigeonResult.audioLanguage = audioLanguage;
  pigeonResult.subtitleLanguage = subtitleLanguage;
  return pigeonResult;
}
+ (AppConfig *)fromMap:(NSDictionary *)dict {
  AppConfig *pigeonResult = [[AppConfig alloc] init];
  pigeonResult.appLanguage = GetNullableObject(dict, @"appLanguage");
  pigeonResult.audioLanguage = GetNullableObject(dict, @"audioLanguage");
  pigeonResult.subtitleLanguage = GetNullableObject(dict, @"subtitleLanguage");
  return pigeonResult;
}
+ (nullable AppConfig *)nullableFromMap:(NSDictionary *)dict { return (dict) ? [AppConfig fromMap:dict] : nil; }
- (NSDictionary *)toMap {
  return @{
    @"appLanguage" : (self.appLanguage ?: [NSNull null]),
    @"audioLanguage" : (self.audioLanguage ?: [NSNull null]),
    @"subtitleLanguage" : (self.subtitleLanguage ?: [NSNull null]),
  };
}
@end

@implementation User
+ (instancetype)makeWithId:(nullable NSString *)id {
  User* pigeonResult = [[User alloc] init];
  pigeonResult.id = id;
  return pigeonResult;
}
+ (User *)fromMap:(NSDictionary *)dict {
  User *pigeonResult = [[User alloc] init];
  pigeonResult.id = GetNullableObject(dict, @"id");
  return pigeonResult;
}
+ (nullable User *)nullableFromMap:(NSDictionary *)dict { return (dict) ? [User fromMap:dict] : nil; }
- (NSDictionary *)toMap {
  return @{
    @"id" : (self.id ?: [NSNull null]),
  };
}
@end

@implementation MediaItem
+ (instancetype)makeWithUrl:(nullable NSString *)url
    mimeType:(nullable NSString *)mimeType
    metadata:(nullable MediaMetadata *)metadata
    isLive:(nullable NSNumber *)isLive
    playbackStartPositionMs:(nullable NSNumber *)playbackStartPositionMs
    lastKnownAudioLanguage:(nullable NSString *)lastKnownAudioLanguage
    lastKnownSubtitleLanguage:(nullable NSString *)lastKnownSubtitleLanguage {
  MediaItem* pigeonResult = [[MediaItem alloc] init];
  pigeonResult.url = url;
  pigeonResult.mimeType = mimeType;
  pigeonResult.metadata = metadata;
  pigeonResult.isLive = isLive;
  pigeonResult.playbackStartPositionMs = playbackStartPositionMs;
  pigeonResult.lastKnownAudioLanguage = lastKnownAudioLanguage;
  pigeonResult.lastKnownSubtitleLanguage = lastKnownSubtitleLanguage;
  return pigeonResult;
}
+ (MediaItem *)fromMap:(NSDictionary *)dict {
  MediaItem *pigeonResult = [[MediaItem alloc] init];
  pigeonResult.url = GetNullableObject(dict, @"url");
  pigeonResult.mimeType = GetNullableObject(dict, @"mimeType");
  pigeonResult.metadata = [MediaMetadata nullableFromMap:GetNullableObject(dict, @"metadata")];
  pigeonResult.isLive = GetNullableObject(dict, @"isLive");
  pigeonResult.playbackStartPositionMs = GetNullableObject(dict, @"playbackStartPositionMs");
  pigeonResult.lastKnownAudioLanguage = GetNullableObject(dict, @"lastKnownAudioLanguage");
  pigeonResult.lastKnownSubtitleLanguage = GetNullableObject(dict, @"lastKnownSubtitleLanguage");
  return pigeonResult;
}
+ (nullable MediaItem *)nullableFromMap:(NSDictionary *)dict { return (dict) ? [MediaItem fromMap:dict] : nil; }
- (NSDictionary *)toMap {
  return @{
    @"url" : (self.url ?: [NSNull null]),
    @"mimeType" : (self.mimeType ?: [NSNull null]),
    @"metadata" : (self.metadata ? [self.metadata toMap] : [NSNull null]),
    @"isLive" : (self.isLive ?: [NSNull null]),
    @"playbackStartPositionMs" : (self.playbackStartPositionMs ?: [NSNull null]),
    @"lastKnownAudioLanguage" : (self.lastKnownAudioLanguage ?: [NSNull null]),
    @"lastKnownSubtitleLanguage" : (self.lastKnownSubtitleLanguage ?: [NSNull null]),
  };
}
@end

@implementation MediaMetadata
+ (instancetype)makeWithArtworkUri:(nullable NSString *)artworkUri
    title:(nullable NSString *)title
    artist:(nullable NSString *)artist
    episodeId:(nullable NSString *)episodeId
    extras:(nullable NSDictionary<NSString *, NSString *> *)extras {
  MediaMetadata* pigeonResult = [[MediaMetadata alloc] init];
  pigeonResult.artworkUri = artworkUri;
  pigeonResult.title = title;
  pigeonResult.artist = artist;
  pigeonResult.episodeId = episodeId;
  pigeonResult.extras = extras;
  return pigeonResult;
}
+ (MediaMetadata *)fromMap:(NSDictionary *)dict {
  MediaMetadata *pigeonResult = [[MediaMetadata alloc] init];
  pigeonResult.artworkUri = GetNullableObject(dict, @"artworkUri");
  pigeonResult.title = GetNullableObject(dict, @"title");
  pigeonResult.artist = GetNullableObject(dict, @"artist");
  pigeonResult.episodeId = GetNullableObject(dict, @"episodeId");
  pigeonResult.extras = GetNullableObject(dict, @"extras");
  return pigeonResult;
}
+ (nullable MediaMetadata *)nullableFromMap:(NSDictionary *)dict { return (dict) ? [MediaMetadata fromMap:dict] : nil; }
- (NSDictionary *)toMap {
  return @{
    @"artworkUri" : (self.artworkUri ?: [NSNull null]),
    @"title" : (self.title ?: [NSNull null]),
    @"artist" : (self.artist ?: [NSNull null]),
    @"episodeId" : (self.episodeId ?: [NSNull null]),
    @"extras" : (self.extras ?: [NSNull null]),
  };
}
@end

@implementation ChromecastState
+ (instancetype)makeWithConnectionState:(CastConnectionState)connectionState {
  ChromecastState* pigeonResult = [[ChromecastState alloc] init];
  pigeonResult.connectionState = connectionState;
  return pigeonResult;
}
+ (ChromecastState *)fromMap:(NSDictionary *)dict {
  ChromecastState *pigeonResult = [[ChromecastState alloc] init];
  pigeonResult.connectionState = [GetNullableObject(dict, @"connectionState") integerValue];
  return pigeonResult;
}
+ (nullable ChromecastState *)nullableFromMap:(NSDictionary *)dict { return (dict) ? [ChromecastState fromMap:dict] : nil; }
- (NSDictionary *)toMap {
  return @{
    @"connectionState" : @(self.connectionState),
  };
}
@end

@implementation PositionUpdateEvent
+ (instancetype)makeWithPlayerId:(NSString *)playerId
    playbackPositionMs:(nullable NSNumber *)playbackPositionMs {
  PositionUpdateEvent* pigeonResult = [[PositionUpdateEvent alloc] init];
  pigeonResult.playerId = playerId;
  pigeonResult.playbackPositionMs = playbackPositionMs;
  return pigeonResult;
}
+ (PositionUpdateEvent *)fromMap:(NSDictionary *)dict {
  PositionUpdateEvent *pigeonResult = [[PositionUpdateEvent alloc] init];
  pigeonResult.playerId = GetNullableObject(dict, @"playerId");
  NSAssert(pigeonResult.playerId != nil, @"");
  pigeonResult.playbackPositionMs = GetNullableObject(dict, @"playbackPositionMs");
  return pigeonResult;
}
+ (nullable PositionUpdateEvent *)nullableFromMap:(NSDictionary *)dict { return (dict) ? [PositionUpdateEvent fromMap:dict] : nil; }
- (NSDictionary *)toMap {
  return @{
    @"playerId" : (self.playerId ?: [NSNull null]),
    @"playbackPositionMs" : (self.playbackPositionMs ?: [NSNull null]),
  };
}
@end

@implementation IsPlayingChangedEvent
+ (instancetype)makeWithPlayerId:(NSString *)playerId
    isPlaying:(NSNumber *)isPlaying {
  IsPlayingChangedEvent* pigeonResult = [[IsPlayingChangedEvent alloc] init];
  pigeonResult.playerId = playerId;
  pigeonResult.isPlaying = isPlaying;
  return pigeonResult;
}
+ (IsPlayingChangedEvent *)fromMap:(NSDictionary *)dict {
  IsPlayingChangedEvent *pigeonResult = [[IsPlayingChangedEvent alloc] init];
  pigeonResult.playerId = GetNullableObject(dict, @"playerId");
  NSAssert(pigeonResult.playerId != nil, @"");
  pigeonResult.isPlaying = GetNullableObject(dict, @"isPlaying");
  NSAssert(pigeonResult.isPlaying != nil, @"");
  return pigeonResult;
}
+ (nullable IsPlayingChangedEvent *)nullableFromMap:(NSDictionary *)dict { return (dict) ? [IsPlayingChangedEvent fromMap:dict] : nil; }
- (NSDictionary *)toMap {
  return @{
    @"playerId" : (self.playerId ?: [NSNull null]),
    @"isPlaying" : (self.isPlaying ?: [NSNull null]),
  };
}
@end

@implementation PictureInPictureModeChangedEvent
+ (instancetype)makeWithPlayerId:(NSString *)playerId
    isInPipMode:(NSNumber *)isInPipMode {
  PictureInPictureModeChangedEvent* pigeonResult = [[PictureInPictureModeChangedEvent alloc] init];
  pigeonResult.playerId = playerId;
  pigeonResult.isInPipMode = isInPipMode;
  return pigeonResult;
}
+ (PictureInPictureModeChangedEvent *)fromMap:(NSDictionary *)dict {
  PictureInPictureModeChangedEvent *pigeonResult = [[PictureInPictureModeChangedEvent alloc] init];
  pigeonResult.playerId = GetNullableObject(dict, @"playerId");
  NSAssert(pigeonResult.playerId != nil, @"");
  pigeonResult.isInPipMode = GetNullableObject(dict, @"isInPipMode");
  NSAssert(pigeonResult.isInPipMode != nil, @"");
  return pigeonResult;
}
+ (nullable PictureInPictureModeChangedEvent *)nullableFromMap:(NSDictionary *)dict { return (dict) ? [PictureInPictureModeChangedEvent fromMap:dict] : nil; }
- (NSDictionary *)toMap {
  return @{
    @"playerId" : (self.playerId ?: [NSNull null]),
    @"isInPipMode" : (self.isInPipMode ?: [NSNull null]),
  };
}
@end

@implementation MediaItemTransitionEvent
+ (instancetype)makeWithPlayerId:(NSString *)playerId
    mediaItem:(nullable MediaItem *)mediaItem {
  MediaItemTransitionEvent* pigeonResult = [[MediaItemTransitionEvent alloc] init];
  pigeonResult.playerId = playerId;
  pigeonResult.mediaItem = mediaItem;
  return pigeonResult;
}
+ (MediaItemTransitionEvent *)fromMap:(NSDictionary *)dict {
  MediaItemTransitionEvent *pigeonResult = [[MediaItemTransitionEvent alloc] init];
  pigeonResult.playerId = GetNullableObject(dict, @"playerId");
  NSAssert(pigeonResult.playerId != nil, @"");
  pigeonResult.mediaItem = [MediaItem nullableFromMap:GetNullableObject(dict, @"mediaItem")];
  return pigeonResult;
}
+ (nullable MediaItemTransitionEvent *)nullableFromMap:(NSDictionary *)dict { return (dict) ? [MediaItemTransitionEvent fromMap:dict] : nil; }
- (NSDictionary *)toMap {
  return @{
    @"playerId" : (self.playerId ?: [NSNull null]),
    @"mediaItem" : (self.mediaItem ? [self.mediaItem toMap] : [NSNull null]),
  };
}
@end

@interface PlaybackPlatformPigeonCodecReader : FlutterStandardReader
@end
@implementation PlaybackPlatformPigeonCodecReader
- (nullable id)readValueOfType:(UInt8)type 
{
  switch (type) {
    case 128:     
      return [AppConfig fromMap:[self readValue]];
    
    case 129:     
      return [ChromecastState fromMap:[self readValue]];
    
    case 130:     
      return [MediaItem fromMap:[self readValue]];
    
    case 131:     
      return [MediaMetadata fromMap:[self readValue]];
    
    case 132:     
      return [NpawConfig fromMap:[self readValue]];
    
    case 133:     
      return [User fromMap:[self readValue]];
    
    default:    
      return [super readValueOfType:type];
    
  }
}
@end

@interface PlaybackPlatformPigeonCodecWriter : FlutterStandardWriter
@end
@implementation PlaybackPlatformPigeonCodecWriter
- (void)writeValue:(id)value 
{
  if ([value isKindOfClass:[AppConfig class]]) {
    [self writeByte:128];
    [self writeValue:[value toMap]];
  } else 
  if ([value isKindOfClass:[ChromecastState class]]) {
    [self writeByte:129];
    [self writeValue:[value toMap]];
  } else 
  if ([value isKindOfClass:[MediaItem class]]) {
    [self writeByte:130];
    [self writeValue:[value toMap]];
  } else 
  if ([value isKindOfClass:[MediaMetadata class]]) {
    [self writeByte:131];
    [self writeValue:[value toMap]];
  } else 
  if ([value isKindOfClass:[NpawConfig class]]) {
    [self writeByte:132];
    [self writeValue:[value toMap]];
  } else 
  if ([value isKindOfClass:[User class]]) {
    [self writeByte:133];
    [self writeValue:[value toMap]];
  } else 
{
    [super writeValue:value];
  }
}
@end

@interface PlaybackPlatformPigeonCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation PlaybackPlatformPigeonCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[PlaybackPlatformPigeonCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[PlaybackPlatformPigeonCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *PlaybackPlatformPigeonGetCodec() {
  static dispatch_once_t sPred = 0;
  static FlutterStandardMessageCodec *sSharedObject = nil;
  dispatch_once(&sPred, ^{
    PlaybackPlatformPigeonCodecReaderWriter *readerWriter = [[PlaybackPlatformPigeonCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}


void PlaybackPlatformPigeonSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<PlaybackPlatformPigeon> *api) {
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PlaybackPlatformPigeon.newPlayer"
        binaryMessenger:binaryMessenger
        codec:PlaybackPlatformPigeonGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(newPlayer:completion:)], @"PlaybackPlatformPigeon api (%@) doesn't respond to @selector(newPlayer:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_url = GetNullableObjectAtIndex(args, 0);
        [api newPlayer:arg_url completion:^(NSString *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PlaybackPlatformPigeon.queueMediaItem"
        binaryMessenger:binaryMessenger
        codec:PlaybackPlatformPigeonGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(queueMediaItem:mediaItem:completion:)], @"PlaybackPlatformPigeon api (%@) doesn't respond to @selector(queueMediaItem:mediaItem:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_playerId = GetNullableObjectAtIndex(args, 0);
        MediaItem *arg_mediaItem = GetNullableObjectAtIndex(args, 1);
        [api queueMediaItem:arg_playerId mediaItem:arg_mediaItem completion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PlaybackPlatformPigeon.replaceCurrentMediaItem"
        binaryMessenger:binaryMessenger
        codec:PlaybackPlatformPigeonGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(replaceCurrentMediaItem:mediaItem:playbackPositionFromPrimary:autoplay:completion:)], @"PlaybackPlatformPigeon api (%@) doesn't respond to @selector(replaceCurrentMediaItem:mediaItem:playbackPositionFromPrimary:autoplay:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_playerId = GetNullableObjectAtIndex(args, 0);
        MediaItem *arg_mediaItem = GetNullableObjectAtIndex(args, 1);
        NSNumber *arg_playbackPositionFromPrimary = GetNullableObjectAtIndex(args, 2);
        NSNumber *arg_autoplay = GetNullableObjectAtIndex(args, 3);
        [api replaceCurrentMediaItem:arg_playerId mediaItem:arg_mediaItem playbackPositionFromPrimary:arg_playbackPositionFromPrimary autoplay:arg_autoplay completion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PlaybackPlatformPigeon.setPrimary"
        binaryMessenger:binaryMessenger
        codec:PlaybackPlatformPigeonGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(setPrimary:completion:)], @"PlaybackPlatformPigeon api (%@) doesn't respond to @selector(setPrimary:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_id = GetNullableObjectAtIndex(args, 0);
        [api setPrimary:arg_id completion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PlaybackPlatformPigeon.play"
        binaryMessenger:binaryMessenger
        codec:PlaybackPlatformPigeonGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(play:error:)], @"PlaybackPlatformPigeon api (%@) doesn't respond to @selector(play:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_playerId = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api play:arg_playerId error:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PlaybackPlatformPigeon.pause"
        binaryMessenger:binaryMessenger
        codec:PlaybackPlatformPigeonGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(pause:error:)], @"PlaybackPlatformPigeon api (%@) doesn't respond to @selector(pause:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_playerId = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api pause:arg_playerId error:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PlaybackPlatformPigeon.stop"
        binaryMessenger:binaryMessenger
        codec:PlaybackPlatformPigeonGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(stop:reset:error:)], @"PlaybackPlatformPigeon api (%@) doesn't respond to @selector(stop:reset:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_playerId = GetNullableObjectAtIndex(args, 0);
        NSNumber *arg_reset = GetNullableObjectAtIndex(args, 1);
        FlutterError *error;
        [api stop:arg_playerId reset:arg_reset error:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PlaybackPlatformPigeon.setUser"
        binaryMessenger:binaryMessenger
        codec:PlaybackPlatformPigeonGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(setUser:error:)], @"PlaybackPlatformPigeon api (%@) doesn't respond to @selector(setUser:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        User *arg_user = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api setUser:arg_user error:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PlaybackPlatformPigeon.setNpawConfig"
        binaryMessenger:binaryMessenger
        codec:PlaybackPlatformPigeonGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(setNpawConfig:error:)], @"PlaybackPlatformPigeon api (%@) doesn't respond to @selector(setNpawConfig:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NpawConfig *arg_config = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api setNpawConfig:arg_config error:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PlaybackPlatformPigeon.setAppConfig"
        binaryMessenger:binaryMessenger
        codec:PlaybackPlatformPigeonGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(setAppConfig:error:)], @"PlaybackPlatformPigeon api (%@) doesn't respond to @selector(setAppConfig:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        AppConfig *arg_config = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api setAppConfig:arg_config error:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PlaybackPlatformPigeon.getChromecastState"
        binaryMessenger:binaryMessenger
        codec:PlaybackPlatformPigeonGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getChromecastState:)], @"PlaybackPlatformPigeon api (%@) doesn't respond to @selector(getChromecastState:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api getChromecastState:^(ChromecastState *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PlaybackPlatformPigeon.openExpandedCastController"
        binaryMessenger:binaryMessenger
        codec:PlaybackPlatformPigeonGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(openExpandedCastController:)], @"PlaybackPlatformPigeon api (%@) doesn't respond to @selector(openExpandedCastController:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        [api openExpandedCastController:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.PlaybackPlatformPigeon.openCastDialog"
        binaryMessenger:binaryMessenger
        codec:PlaybackPlatformPigeonGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(openCastDialog:)], @"PlaybackPlatformPigeon api (%@) doesn't respond to @selector(openCastDialog:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        [api openCastDialog:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
}
@interface PlaybackListenerPigeonCodecReader : FlutterStandardReader
@end
@implementation PlaybackListenerPigeonCodecReader
- (nullable id)readValueOfType:(UInt8)type 
{
  switch (type) {
    case 128:     
      return [IsPlayingChangedEvent fromMap:[self readValue]];
    
    case 129:     
      return [MediaItem fromMap:[self readValue]];
    
    case 130:     
      return [MediaItemTransitionEvent fromMap:[self readValue]];
    
    case 131:     
      return [MediaMetadata fromMap:[self readValue]];
    
    case 132:     
      return [PictureInPictureModeChangedEvent fromMap:[self readValue]];
    
    case 133:     
      return [PositionUpdateEvent fromMap:[self readValue]];
    
    default:    
      return [super readValueOfType:type];
    
  }
}
@end

@interface PlaybackListenerPigeonCodecWriter : FlutterStandardWriter
@end
@implementation PlaybackListenerPigeonCodecWriter
- (void)writeValue:(id)value 
{
  if ([value isKindOfClass:[IsPlayingChangedEvent class]]) {
    [self writeByte:128];
    [self writeValue:[value toMap]];
  } else 
  if ([value isKindOfClass:[MediaItem class]]) {
    [self writeByte:129];
    [self writeValue:[value toMap]];
  } else 
  if ([value isKindOfClass:[MediaItemTransitionEvent class]]) {
    [self writeByte:130];
    [self writeValue:[value toMap]];
  } else 
  if ([value isKindOfClass:[MediaMetadata class]]) {
    [self writeByte:131];
    [self writeValue:[value toMap]];
  } else 
  if ([value isKindOfClass:[PictureInPictureModeChangedEvent class]]) {
    [self writeByte:132];
    [self writeValue:[value toMap]];
  } else 
  if ([value isKindOfClass:[PositionUpdateEvent class]]) {
    [self writeByte:133];
    [self writeValue:[value toMap]];
  } else 
{
    [super writeValue:value];
  }
}
@end

@interface PlaybackListenerPigeonCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation PlaybackListenerPigeonCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[PlaybackListenerPigeonCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[PlaybackListenerPigeonCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *PlaybackListenerPigeonGetCodec() {
  static dispatch_once_t sPred = 0;
  static FlutterStandardMessageCodec *sSharedObject = nil;
  dispatch_once(&sPred, ^{
    PlaybackListenerPigeonCodecReaderWriter *readerWriter = [[PlaybackListenerPigeonCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}


@interface PlaybackListenerPigeon ()
@property (nonatomic, strong) NSObject<FlutterBinaryMessenger> *binaryMessenger;
@end

@implementation PlaybackListenerPigeon

- (instancetype)initWithBinaryMessenger:(NSObject<FlutterBinaryMessenger> *)binaryMessenger {
  self = [super init];
  if (self) {
    _binaryMessenger = binaryMessenger;
  }
  return self;
}
- (void)onPositionUpdate:(PositionUpdateEvent *)arg_event completion:(void(^)(NSError *_Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.PlaybackListenerPigeon.onPositionUpdate"
      binaryMessenger:self.binaryMessenger
      codec:PlaybackListenerPigeonGetCodec()];
  [channel sendMessage:@[arg_event ?: [NSNull null]] reply:^(id reply) {
    completion(nil);
  }];
}
- (void)onIsPlayingChanged:(IsPlayingChangedEvent *)arg_event completion:(void(^)(NSError *_Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.PlaybackListenerPigeon.onIsPlayingChanged"
      binaryMessenger:self.binaryMessenger
      codec:PlaybackListenerPigeonGetCodec()];
  [channel sendMessage:@[arg_event ?: [NSNull null]] reply:^(id reply) {
    completion(nil);
  }];
}
- (void)onMediaItemTransition:(MediaItemTransitionEvent *)arg_event completion:(void(^)(NSError *_Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.PlaybackListenerPigeon.onMediaItemTransition"
      binaryMessenger:self.binaryMessenger
      codec:PlaybackListenerPigeonGetCodec()];
  [channel sendMessage:@[arg_event ?: [NSNull null]] reply:^(id reply) {
    completion(nil);
  }];
}
- (void)onPictureInPictureModeChanged:(PictureInPictureModeChangedEvent *)arg_event completion:(void(^)(NSError *_Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.PlaybackListenerPigeon.onPictureInPictureModeChanged"
      binaryMessenger:self.binaryMessenger
      codec:PlaybackListenerPigeonGetCodec()];
  [channel sendMessage:@[arg_event ?: [NSNull null]] reply:^(id reply) {
    completion(nil);
  }];
}
@end
