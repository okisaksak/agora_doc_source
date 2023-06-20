本页提供声网灵隼客户端 iOS API 参考。

## 概述

| 类 | 描述 |
| --- | --- |
| [IAgoraIotAppSdk](#sdk) | 提供总的服务接口，各子功能通过 `getInstance` 方法获取 |
| [IAccountMgr](#accountmgr) | 账号注册、登录与登出 |
| [ICallkitMgr](#callkitmgr) | 来电呼叫管理，包括拨号、接听、挂断等 |
| [INotificationMgr](#notificationmgr) | 消息通知管理 |
| [ErrCode](#errcode) | Iot SDK 在使用过程中的报错信息 |

<a name="sdk"></a>

## IAgoraIotAppSdk

SDK 引擎接口。

<a name="initialize"></a>

#### initialize

```swift
func initialize(initParam: InitParam,sdkStatus:@escaping(SdkStatus,String)->Void,callbackFilter:@escaping(Int,String)->(Int,String)) -> Int
```

初始化 SDK。

**参数**

| 参数 | 描述 |
| --- | --- |
| `initParam` | SDK 初始化参数，详见 [InitParam](#initparam)。 |
| `sdkStatus` | SDK 状态，详见 [SdkStatus](#SdkStatus)。 |
| `callbackFilter` | 回调函数返回错误码/错误消息的集中过滤。所有带有 result 回调的接口，都会在调用 result 回调前触发该回调，返回 (ErrCode,ErrMessage)。 |

<a name="release"></a>

#### release

```
 func release()
```

释放 SDK 所有资源。

#### accounrMgr

```swift
var accountMgr: IAccountMgr{get}
```

获取账号管理接口。

**返回**

- 账号管理接口，详见 [IAccountMgr](#accountmgr)。

#### callkitMgr

```swift
var callkitMgr: ICallkitMgr{get}
```

获取呼叫系统接口。

**返回**

- 呼叫系统接口，详见 [ICallkitMgr](#callmgr)。

#### deviceMgr

```swift
var deviceMgr: IDeviceMgr{get}
```

获取设备管理接口。

**返回**

- 设备管理接口，详见 [IDeviceMgr](#devicemgr)。

#### alarmMgr

```swift
var alarmMgr: IAlarmMgr{get}
```

获取告警信息管理接口。

**返回**

- 告警信息接口，详见 [IAlarmMgr](#alarmmgr)。

#### notificationMgr

```swift
var notificationMgr: INotificationMgr{get}
```

获取通知信息管理接口。

**返回**

- 通知信息接口，详见 [INotificationMgr](#notificationmgr)。

<a name="accountmgr"></a>

## IAccountMgr

账号管理接口。

<a name="accountregister"></a>

#### register

```swift
func register(account: String, password: String,code: String, email:String?, phone:String?, result:@escaping (Int,String)->Void)
```

注册一个新账号。

**参数**

| 参数       | 描述                                                         |
| ---------- | ------------------------------------------------------------ |
| `account`  | 账号 ID，需要为邮箱地址或手机号码。                          |
| `password` | 账号密码。                                                   |
| `code`     | 验证码，可以通过 [getCode](#getcode) 或 [getSms](#getsms) 方法获取。 |
| `email`    | 邮箱地址。邮箱地址和手机号码必须提供一个。                   |
| `phone`    | 手机号码。需要加上国区代码，如：中国需要加上“+86”。邮箱地址和手机号码必须提供一个。 |

**返回**

- 错误码，详见 [ErrCode](#errcode)。

<a name="logout"></a>

#### logout

```swift
func logout(result:@escaping (Int,String)->Void)
```

登出当前账号。

**返回**

- 错误码，详见 [ErrCode](#errcode)。

<a name="getuserid"></a>

#### getUserId

```swift
func getUserId()->String
```

获取当前用户 ID。

**返回**

- user ID。

- 错误码，详见 [ErrCode](#errcode)。

<a name="getaccount"></a>

#### getAccountInfo

```swift
func getAccountInfo(result:@escaping(Int,String,AccountInfo?)->Void)
```

获取当前用户账号信息。

**返回**

- 账户信息，详见 [AccountInfo](#accountinfo)。

- 错误码，详见 [ErrCode](#errcode)。

<a name="updateaccount"></a>

#### updateAccountInfo

```swift
func updateAccountInfo(info:AccountInfo,result:@escaping(Int,String)->Void)
```

更新当前用户账号信息。

**参数**

| 参数   | 描述                                         |
| ------ | -------------------------------------------- |
| `info` | 账号信息，详见 [AccountInfo](#accountinfo)。 |

**返回**

- 错误码，详见 [ErrCode](#errcode)。

<a name="updatehead"></a>

#### updateHeadIcon

```swift
func updateHeadIcon(image:UIImage,result:@escaping(Int,String,String?)->Void)
```

上传用户头像。

**参数**

| 参数    | 描述           |
| ------- | -------------- |
| `image` | 头像图片文件。 |

**返回**

- 头像的 URL 地址。

- 错误码，详见 [ErrCode](#errcode)。

<a name="login"></a>

#### login

```swift
func login(param:LoginParam,result:@escaping(Int,String)->Void)
```

通过第三方账号的登陆参数登陆用户账号。

该方法适用于用户已经自行实现第三方账号管理系统的情况。用户可以直接通过该方法登陆灵隼物联网平台。

**参数**

| 参数  | 描述                                  |
| :---- | :------------------------------------ |
| `param` | 第三方登陆参数。详见 [LoginParam](#loginparam)。 |

**返回**

- 错误码，详见 [ErrCode](#errcode)。


<a name="callkitmgr"></a>

## ICallkitMgr

呼叫系统管理接口。

<a name="calldial"></a>

#### callDial

```swift
func callDial(
    device: IotDevice,
    attachMsg: String,
    result:@escaping(Int,String)->Void,
    actionAck:@escaping(ActionAck)->Void,
    memberState:((_ state:MemberState,_ uid:[UInt])->Void)?)
```

呼叫设备。

**参数**

| 参数        | 描述                                             |
| ----------- | ------------------------------------------------ |
| `device`    | 要呼叫的设备，详见 [IotDevice](#iotdevice)。     |
| `attachMsg` | 呼叫时附带的信息。                               |
| `actionAck` | 通话中产生的事件，详见 [ActionAck](#actionack)。 |
| `memberState` | 其他用户的信息。<li>`state`: 其他用户的状态，详见 [MemberState](#memberstate)。</li><li>`uid`: 其他用户的用户 ID。 |

**返回**

- 错误码，详见 [ErrCode](#errcode)。

<a name="callhang"></a>

#### callHangup

```swift
func callHangup(result:@escaping(Int,String)->Void)
```

挂断当前通话。

**返回**

- 错误码，详见 [ErrCode](#errcode)。

<a name="callanswer"></a>

#### callAnswer

```swift
func callAnswer(result:@escaping(Int,String)->Void,
                actionAck:@escaping(ActionAck)->Void,
                memberState:((_ state:MemberState,_ uid:[UInt])->Void)?)
```

接听当前来电。

**参数**

| 参数        | 描述               |
| ----------- | ------------------ |
| `actionAck` | 通话中产生的事件。 |
| `memberState` | 其他用户的信息。<li>`state`: 其他用户的状态，详见 [MemberState](#memberstate)。</li><li>`uid`: 其他用户的用户 ID。 |

**返回**

- 错误码，详见 [ErrCode](#errcode)。

<a name="setlocalvideo"></a>

#### setLocalVideoView

```swift
func setLocalVideoView(localView: UIView?) -> Int
```

设置本地视频显示控件。如果不设置则不显示本地视频。

**参数**

| 参数        | 描述               |
| ----------- | ------------------ |
| `localView` | 本地视频显示控件。 |

**返回**

- 错误码，详见 [ErrCode](#errcode)。

<a name="setpeervideo"></a>

#### setPeerVideoView

```swift
func setPeerVideoView(peerView: UIView?) -> Int
```

设置对端视频显示控件。如果不设置则不显示对端视频。

**参数**

| 参数        | 描述               |
| ----------- | ------------------ |
| `localView` | 本地视频显示控件。 |

**返回**

- 错误码，详见 [ErrCode](#errcode)。

<a name="mutelocalvideo"></a>

#### muteLocalVideo

```swift
func muteLocalVideo(mute: Bool,result:@escaping(Int,String)->Void)
```

停止/恢复发布本地视频流。

**参数**

| 参数   | 描述                                                         |
| ------ | ------------------------------------------------------------ |
| `mute` | 是否停止发布本地视频流：<br/><ul><li>true: 是 </li><li>false: 否</li></ul> |

**返回**

- 错误码，详见 [ErrCode](#errcode)。

<a name="mutelocalaudio"></a>

#### muteLocalAudio

```swift
func muteLocaAudio(mute: Bool,result:@escaping(Int,String)->Void)
```

停止/恢复发布本地音频流。

**参数**

| 参数   | 描述                                                         |
| ------ | ------------------------------------------------------------ |
| `mute` | 是否停止发布本地音频流：<br/><ul><li>true: 是 </li><li>false: 否</li></ul> |

**返回**

- 错误码，详见 [ErrCode](#errcode)。

<a name="mutepeervideo"></a>

#### mutePeerVideo

```swift
func mutePeerVideo(mute: Bool,result:@escaping(Int,String)->Void)
```

停止/恢复订阅远端视频流。

**参数**

| 参数   | 描述                                                         |
| ------ | ------------------------------------------------------------ |
| `mute` | 是否停止发布远端视频流：<br/><ul><li>true: 是 </li><li>false: 否</li></ul> |

**返回**

- 错误码，详见 [ErrCode](#errcode)。

<a name="mutepeeraudio"></a>

#### mutePeerAudio

```swift
func mutePeerAudio(mute: Bool,result:@escaping(Int,String)->Void)
```

停止/恢复订阅远端音频流。

**参数**

| 参数   | 描述                                                         |
| ------ | ------------------------------------------------------------ |
| `mute` | 是否停止发布远端音频流：<br/><ul><li>true: 是 </li><li>false: 否</li></ul> |

**返回**

- 错误码，详见 [ErrCode](#errcode)。

<a name="setvolume"></a>

#### setVolume

```swift
func setVolume(volumeLevel: Int,result:@escaping(Int,String)->Void)
```

设置音频播放的音量。

**参数**

| 参数          | 描述                           |
| ------------- | ------------------------------ |
| `volumeLevel` | 音量级别，取值范围为 [0,100]。 |

**返回**

- 错误码，详见 [ErrCode](#errcode)。

<a name="setvolumeeffect"></a>

#### setVolumeEffect

```swift
func setAudioEffect(effectId: AudioEffectId,result:@escaping(Int,String)->Void)
```

设置音效效果（通常是变声等音效）。

**参数**

| 参数       | 描述                                                  |
| ---------- | ----------------------------------------------------- |
| `effectId` | 音效文件的 ID。详见 [AudioEffectId](#AudioEffectId)。 |

**返回**

- 错误码，详见 [ErrCode](#errcode)。

<a name="talkstart"></a>

#### talkingRecordStart

```swift
 func talkingRecordStart(result:@escaping(Int,String)->Void)
```

开始录制当前通话（包括音视频流），仅在通话状态下才能调用。

**返回**

- 错误码，详见 [ErrCode](#errcode)。

<a name="talkstop"></a>

#### talkingRecordStop

```swift
 func talkingRecordStop(result:@escaping(Int,String)->Void)
```

停止录制当前通话，仅在通话状态下才能调用。

**返回**

- 错误码，详见 [ErrCode](#errcode)。

<a name="cappeervideo"></a>

#### capturePeerVideoFrame

```swift
func capturePeerVideoFrame(result:@escaping(Int,String,UIImage?)->Void)
```

截屏对端视频帧图像，仅在通话状态下才能调用。

**返回**

- 截取到的视频帧图像。

- 错误码，详见 [ErrCode](#errcode)。

<a name="getnetworkstatus"></a>

#### getNetworkStatus

```swift
func getNetworkStatus()->RtcNetworkStatus
```

获取当前通话的统计信息。

**返回**

当前通话的统计信息。详见 [RtcNetworkStatus](#rtcnetworkstatus)。



<a name="notificationmgr"></a>

## INotificationMgr

通知消息管理接口。

<a name="updatetoken"></a>

#### updateToken

```swift
func updateToken(_ deviceToken:Data)
```

离线推送时需要更新 Token。

**参数**

| 参数          | 描述         |
| ------------- | ------------ |
| `deviceToken` | 设备 Token。 |

**返回**

- 错误码，详见 [ErrCode](#errcode)。

<a name="queryallnoti"></a>

#### queryAll

```swift
func queryAll(result:@escaping(Int,String)->Void)
```

查询所有通知消息。

查询成功会触发 [onAllNotificationQueryDone](#allnotificationquery) 回调。

**返回**

- 错误码，详见 [ErrCode](#errcode)。

<a name="querynotibydev"></a>

#### queryByDevice

```swift
func queryByDevice(productKey: String, deviceId: String,result:@escaping(Int,String)->Void)
```

查询指定设备的所有通知消息。

查询成功会触发 [onDeviceNotificationQueryDone](#devicenotificationquery) 回调。

**参数**

| 参数         | 描述       |
| ------------ | ---------- |
| `productKey` | 产品编号。 |
| `deviceId`   | 设备 ID。  |

**返回**

- 错误码，详见 [ErrCode](#errcode)。

<a name="deletenoti"></a>

#### delete

```swift
func delete(notificationIdList: [String],result:@escaping(Int,String)->Void)
```

删除多条通知消息。

删除成功会触发 [onNotificationDeleteDone](#notificationdelete) 回调。

**参数**

| 参数                 | 描述                       |
| -------------------- | -------------------------- |
| `notificationIdList` | 要删除的通知消息 ID 列表。 |

**返回**

- 错误码，详见 [ErrCode](#errcode)。

<a name="marknoti"></a>

#### mark

```swift
func mark(markFlag: Int, notificationIdList: [String],result:@escaping(Int,String)->Void)
```

标记多条通知消息。

标记成功会触发 [onNotificationMarkDone](#notificationmark) 回调。

**参数**

| 参数                 | 描述                       |
| -------------------- | -------------------------- |
| `notificationIdList` | 要删除的通知消息 ID 列表。 |
| `markFlag`           | 标记信息。                 |

**返回**

- 错误码，详见 [ErrCode](#errcode)。

<a name="enablenoti"></a>

#### enableNotify

```swift
func enableNotify(enable:Bool,result:@escaping(Int,String)->Void)
```

开启/关闭接收推送消息。

**参数**

| 参数   | 描述                                                         |
| ------ | ------------------------------------------------------------ |
| `bool` | 是否要接收推送消息。<ul><li>true: 接收。</li><li>false: 不接收。</li></ul> |

**返回**

- 错误码，详见 [ErrCode](#errcode)。

<a name="enablenotiquery"></a>

#### notifyEnabled

```swift
func notifyEnabled()->Bool
```

查询推送消息接收状态。

**返回**

- true: 接收。
- false: 不接收。

<a name="geteid"></a>

#### getEid

```swift
func getEid()->String
```

查询推送 eid。

**返回**

eid。

<a name="errcode"></a>
## ErrCode

### 全局错误

| 错误码 | 错误代码 | 描述 |
| --- | --- | --- |
| `0` | `XERR_NONG` | 无错误。|
| `0` | `XOK` | 无错误。 |
| `-3` | `XERR_TOKEN_INVALID` | Token 过期。 |

### 通用错误

| 错误码   | 错误代码                | 描述                       |
| -------- | ----------------------- | -------------------------- |
| `-10000` | `XERR_BASE`             | 通用错误。                 |
| `-10001` | `XERR_UNKNOWN`          | 未知错误。                 |
| `-10002` | `XERR_INVALID_PARAM`    | 参数错误。                 |
| `-10003` | `XERR_UNSUPPORTED`      | 当前操作不支持。           |
| `-10004` | `XERR_BAD_STATE`        | 当前状态不正确，无法操作。 |
| `-10005` | `XERR_NOT_FOUND`        | 没有找到相关数据。         |
| `-10006` | `XERR_NO_MEMORY`        | 内存不足。                 |
| `-10007` | `XERR_BUFFER_OVERFLOW`  | 缓冲区中数据不足。         |
| `-10008` | `XERR_BUFFER_UNDERFLOW` | 缓冲区中数据过多。         |
| `-10009` | `XERR_TIMEOUT`          | 操作超时。                 |
| `-10012` | `XERR_NETWORK`          | 网络错误。                 |
| `-10015` | `XERR_TOKEN_INVALID`    | Token 无效。               |



### 呼叫系统相关错误

| 错误码   | 错误代码                   | 描述                  |
| -------- | -------------------------- | --------------------- |
| `-40000` | `XERR_CALLKIT_BASE`        | 呼叫系统相关错误。    |
| `-40001` | `XERR_CALLKIT_TIMEOUT`     | 呼叫超时无响应。      |
| `-40002` | `XERR_CALLKIT_DIAL`        | 呼叫拨号失败。        |
| `-40003` | `XERR_CALLKIT_HANGUP`      | 呼叫挂断失败。        |
| `-40004` | `XERR_CALLKIT_ANSWER`      | 呼叫接听失败。        |
| `-40005` | `XERR_CALLKIT_REJECT`      | 呼叫拒绝失败。        |
| `-40006` | `XERR_CALLKIT_PEER_BUSY`   | 对端忙。              |
| `-40007` | `XERR_CALLKIT_PEERTIMEOUT` | 对端超时无响应。      |
| `-40008` | `XERR_CALLKIT_LOCAL_BUSY`  | 本地端忙。            |
| `-40009` | `XERR_CALLKIT_ERR_OPT`     | 不支持的错误操作。    |
| `-40010` | `XERR_CALLKIT_PEER_UNREG`  | 对端未注册。          |
| `-40011` | `XERR_CALLKIT_NO_APPID`    | 未上报 App ID。       |
| `-40012` | `XERR_CALLKIT_SAME_ID`     | 主叫和被叫同一个 ID。 |
| `-4001` | `XERR_CALLKIT_APPID_DIFF`     | 客户端和设备端使用的 App ID 不一致。 |

## 数据类型

<a name="initparam"></a>

### InitParam 类

Iot SDK 初始化参数。

```swift
public class InitParam : NSObject{
    @objc public var rtcAppId: String = ""
    @objc public var logFilePath : String? = nil
    @objc public var publishAudio = true
    @objc public var publishVideo = true
    @objc public var subscribeAudio = true
    @objc public var subscribeVideo = true
    @objc public var ntfAppKey: String = ""
    @objc public var ntfApnsCertName:String = ""
    @objc public var masterServerUrl:String = ""
    @objc public var slaveServerUrl:String = ""
    @objc public var projectId:String = ""
}
```

| 参数  | 描述 |
| --- | --- |
| `rtcAppId` | 声网的 App ID。 |
| `logFilePath` | 日志文件路径。如果不设置该参数，则日志不会输出到本地文件。 |
| `publishAudio` | 通话时是否自动发布本地音频：<ul><li>true: 是</li><li>false: 否</li></ul><br/> |
| `publishVideo` | 通话时是否自动发布本地视频：<ul><li>true: 是</li><li>false: 否</li></ul><br/> |
| `subscribeAudio` | 通话时是否自动订阅对端音频：<ul><li>true: 是</li><li>false: 否</li></ul><br/> |
| `subscribeVideo` | 通话时是否自动订阅对端视频：<ul><li>true: 是</li><li>false: 否</li></ul><br/> |
| `ntfAppKey` | 离线推送使用的 AppKey。 |
| `ntfApnsCertName` | 离线推送使用的 ApnsCertName。 |
| `masterServerUrl` | 主服务器后台地址。 |
| `slaveServerUrl` | 副服务器后台地址。 |
| `projectId` | 项目 ID，作为查询产品列表的过滤条件。 |

<a name="loginparam"></a>

### LoginParam

```swift
public class LoginParam : NSObject{

    public var tokenType:String = ""
    public var accessToken:String = ""
    public var refreshToken:String = ""
    public var expireIn:UInt = 0
    public var scope:String = ""

    public var grawin_token:String = ""
    public var expiration : UInt64 = 0
    public var endPoint:String = ""
    public var region:String = ""
    public var account:String = ""

    public var proof_sessionToken:String = ""
    public var proof_secretKey:String = ""
    public var proof_accessKeyId:String = ""
    public var proof_sessionExpiration:UInt64 = 0

    public var pool_token:String = ""
    public var pool_identityId:String = ""
    public var pool_identityPoolId:String = ""
    public var pool_identifier = ""
}
```

第三方账号的登陆参数。

**参数**

| 参数                    | 描述                          |
| :---------------------- | :---------------------------- |
| `tokenType`               | 预留字段。                    |
| `accessToken`             | 灵隼平台账号的 Token。        |
| `refreshToken`            | 更新 Token。                  |
| `expireIn`                | Token 过期时间。              |
| `scope`                   | 预留字段。                    |
| `grawin_token`            | 第三方平台的 Token。          |
| `expiration`              | `grawin_token` 的过期时间。     |
| `endPoint`                | 灵隼服务器的边缘节点。        |
| `region`                  | 灵隼服务器所在区域。          |
| `account`                 | 用户的第三方账号。            |
| `proof_sessionToken`      | IOT 临时账号的 Token。        |
| `proof_secretKey`         | IOT 临时账号的密钥。          |
| `proof_accessKeyId`       | IOT 临时账号的凭证。          |
| `proof_sessionExpiration` | `proof_sessionToken` 的过期时间 |
| `pool_token`              | 用户身份 Token。              |
| `pool_identityId`         | 用户身份 ID。                 |
| `pool_identityPoolId`     | 用户身份池 ID。               |
| `pool_identifier`         | 用户身份。                    |


<a name="productinfo"></a>

### ProductInfo 类

```swift
public class ProductInfo:NSObject{
    @objc public var alias : String = ""
    @objc public var bindType:UInt = 0
    @objc public var connectType : UInt = 0
    @objc public var createTime : UInt64 = 0
    @objc public var deleted : UInt = 0
    @objc public var id : String = ""
    @objc public var imgBig : String = ""
    @objc public var imgSmall : String = ""
    @objc public var merchantId : UInt64 = 0
    @objc public var merchantName : String = ""
    @objc public var name : String = ""
    @objc public var productKey : String = ""
    @objc public var productTypeId : UInt64  = 0
    @objc public var productTypeName : String = ""
    @objc public var status : UInt = 0
    public var updateBy : UInt64 = 0
    public var updateTime : UInt64 = 0
    public init(alias:String,
                bindType:UInt,
                connectType:UInt,
                createTime:UInt64,
                deleted:UInt,
                id:String,
                imgBig:String,
                imgSmall:String,
                merchantId:UInt64,
                merchantName:String,
                name:String,
                productKey:String,
                productTypeId:UInt64,
                productTypeName:String,
                status:UInt,
                updateBy:UInt64,
                updateTime:UInt64) {
        self.alias = alias
        self.bindType = bindType
        self.connectType = connectType
        self.createTime = createTime
        self.deleted = deleted
        self.id = id
        self.imgBig = imgBig
        self.imgSmall = imgSmall
        self.merchantId = merchantId
        self.merchantName = merchantName
        self.name = name
        self.productKey = productKey
        self.productTypeId = productTypeId
        self.productTypeName = productTypeName
        self.status = status
        self.updateBy = updateBy
        self.updateTime = updateTime
    }
}
```

产品信息。

| 参数              | 描述                                                         |
| ----------------- | ------------------------------------------------------------ |
| `alias`           | 产品别名。                                                   |
| `bindType`        | 绑定类型：<ul><li>1: 可重复绑定。</li><li>2: 不可重复绑定。</li></ul> |
| `connectType`     | 网络连接类型：<ul><li>1: WiFi 连接。</li><li>2: 蜂窝连接。</li></ul> |
| `createTime`      | 创建时间。                                                 |
| `deleted`         | 是否已删除。<ul><li>true: 是</li><li>false: 否</li></ul>     |
| `id`              | 产品 ID。                                                    |
| `imgBig`          | 产品大图。                                                   |
| `imgSmall`        | 产品小图。                                                   |
| `merchantId`      | 商户 ID。                                                    |
| `merchantName`    | 商户名称。                                                   |
| `name`            | 产品名称                                                     |
| `productKey`      | 产品编号，即作为产品唯一标识的数字。                         |
| `productTypeId`   | 产品型号 ID。                                                |
| `productTypeName` | 产品型号名称。                                               |
| `status`          | 产品状态：<ul><li>1: 正常。</li><li>0: 停用。</li></ul>      |
| `updateBy`        | 更新人 ID。                                                  |
| `updateTime`      | 最后更新时间。                                               |

<a name="deviceshare"></a>

### DeviceShare 类

```swift
public class DeviceShare : NSObject{
    @objc public var nickName:String = ""
    @objc public var count:Int = 0
    @objc public var time:UInt64 = 0
    @objc public var deviceNumber:String = ""
    @objc public var deviceId:String = ""
}
```

分享的设备信息。

| 参数           | 描述                         |
| -------------- | ---------------------------- |
| `nickName`     | 设备昵称。                   |
| `count`        | 设备被分享次数。             |
| `time`         | 创建时间。                   |
| `deviceNumber` | 设备编号。                   |
| `deviceId`     | 设备 ID，必须是唯一的。 |

<a name="devicecancelable"></a>

### DeviceCancelable 类

```swift
public class DeviceCancelable : NSObject{
    @objc public var appuserId:String  = ""
    @objc public var avatar:String = ""
    @objc public var connect:Bool = false
    @objc public var createTime:UInt64 = 0
    @objc public var deviceNumber:String = ""
    @objc public var deviceNickname:String = ""
    @objc public var email:String = ""
    @objc public var deviceId:String = ""
    @objc public var nickName:String = ""
    @objc public var phone:String = ""
    @objc public var productId:String = ""
    @objc public var productKey:String = ""
    @objc public var sharer:String = ""
    @objc public var uType:String = ""
    @objc public var updateTime:UInt64 = 0
}
```

分享给他人设备详情。

| 参数             | 描述                                                         |
| ---------------- | ------------------------------------------------------------ |
| `appuserId`      | 用户 ID。                                                    |
| `avatar`         | 用户头像。                                                   |
| `connect`        | 是否在线。<ul><li> true：在线。</li><li>false：离线。</li></ul> |
| `createTime`     | 创建时间。                                                   |
| `deviceNumber`   | 设备编号。                                                   |
| `deviceNickname` | 设备昵称。                                                   |
| `email`          | 用户邮箱.                                                    |
| `deviceId`       | 设备 ID，必须是唯一的。                                 |
| `nickName`       | 用户昵称。                                                   |
| `phone`          | 用户手机。                                                   |
| `productId`      | 产品 ID。                                                    |
| `productKey`     | 产品编号。                                                   |
| `sharer`         | 分享人 ID。                                                  |
| `uType`          | 用户角色：<ul><li> 1：所有者。</li><li>2：管理员。</li><li>3：成员。</li></ul> |
| `updateTime`     | 更新时间。                                                   |

<a name="sharedetail"></a>

### ShareDetail 类

```swift
public class ShareDetial : NSObject{
    @objc public var auditStatus:Bool = false
    @objc public var content:String = ""
    @objc public var createBy:UInt64 = 0
    @objc public var createTime:UInt64 = 0
    @objc public var deleted:Int = 0
    @objc public var id:UInt64 = 0
    @objc public var merchantId:UInt64 = 0
    @objc public var merchantName:String = ""
    @objc public var msgType:Int = 0
    @objc public var para:String = ""
    @objc public var permission:Int = 0
    @objc public var status:Int = 0
    @objc public var title:String = ""
    @objc public var type:Int = 0
    @objc public var updateBy:UInt64 = 0
    @objc public var updateTime:UInt64 = 0
    @objc public var userId:UInt64 = 0
}
```

分享详情。

| 参数           | 描述                                                         |
| -------------- | ------------------------------------------------------------ |
| `auditStatus`  | 消息处理状态：<ul><li>t: 已处理。</li><li>f: 未处理。</li></ul> |
| `content`      | 推送内容。                                                   |
| `createBy`     | 创建人 ID。                                                  |
| `createTime`   | 创建时间。                                                   |
| `deleted`      | 是否已删除。<ul><li>1: 已删除。</li><li>0: 未删除。</li></ul> |
| `id`           | 该条消息 ID。                                                |
| `merchantId`   | 商户 ID。                                                    |
| `merchantName` | 商户名称。                                                   |
| `msgType`      | 消息类型：<ul><li>1: 设备分享消息。</li></ul>                |
| `para`         | 分享口令。                                                   |
| `permission`   | 推送权限：<ul><li>2：管理员。</li><li>3：成员。</li></ul>    |
| `status`       | 状态：<ul><li>1：发送成功。</li><li>2：发送失败。</li><li>3：待发送。</li></ul> |
| `title`        | 推送标题。                                                   |
| `type`         | 推送类型：<ul><li>1：App 消息。</li><li>2：短信消息。</li><li>3：邮箱信息。</li></ul> |
| `updateBy`     | 更新人 ID。                                                  |
| `updateTime`   | 更新时间。                                                   |
| `userId`       | 被分享者 ID。                                                |

<a name="shareitem"></a>

### ShareItem 类

```swift
public class ShareItem : NSObject{
    @objc public var auditStatus:Bool = false
    @objc public var content:String = ""
    @objc public var createBy:UInt64 = 0
    @objc public var createTime:UInt64 = 0
    @objc public var deleted:Int = 0
    @objc public var deviceNumber:UInt64 = 0
    @objc public var id:UInt64 = 0
    @objc public var img:String = ""
    @objc public var merchantId:UInt64 = 0
    @objc public var merchantName:String = ""
    @objc public var msgType:Int = 0
    @objc public var para:String = ""
    @objc public var permission:Int = 0
    @objc public var productName:String = ""
    @objc public var pushTime:UInt64 = 0
    @objc public var shareName:String = ""
    @objc public var status:Int = 0
    @objc public var title:String = ""
    @objc public var type:Int = 0
    @objc public var userId:UInt64 = 0
}
```

分享条目。

| 参数           | 描述                                                         |
| -------------- | ------------------------------------------------------------ |
| `auditStatus`  | 消息处理状态：<ul><li>t: 已处理。</li><li>f: 未处理。</li></ul> |
| `content`      | 推送内容。                                                   |
| `createBy`     | 创建人 ID。                                                  |
| `createTime`   | 创建时间。                                                   |
| `deleted`      | 是否已删除。<ul><li>1: 已删除。</li><li>0: 未删除。</li></ul> |
| `deviceNumber` | 设备编号。                                                   |
| `id`           | 该条消息 ID。                                                |
| `img`          | 产品图片地址。                                               |
| `merchantId`   | 商户 ID。                                                    |
| `merchantName` | 商户名称。                                                   |
| `msgType`      | 消息类型：<ul><li>1: 设备分享消息。</li></ul>                |
| `para`         | 分享口令。                                                   |
| `permission`   | 推送权限：<ul><li>2：管理员。</li><li>3：成员。</li></ul>    |
| `productName`  | 产品名称。                                                   |
| `pushTime`     | 推送时间。                                                   |
| `shareName`    | 分享设备的名称。                                             |
| `status`       | 状态：<ul><li>1：发送成功。</li><li>2：发送失败。</li><li>3：待发送。</li></ul> |
| `title`        | 推送标题。                                                   |
| `type`         | 推送类型：<ul><li>1：App 消息。</li><li>2：短信消息。</li><li>3：邮箱信息。</li></ul> |
| `userId`       | 被分享者 ID。                                                |

<a name="pageturn"></a>

### PageTurn 类

```swift
public class PageTurn:NSObject{
    @objc var currentPage : Int = 0
    @objc var end : Int = 0
    @objc var firstPage : Int = 0
    @objc var nextPage : Int = 0
    @objc var page : Int = 0
    @objc var pageCount : Int = 0
    @objc var pageSize : Int = 0
    @objc var prevPage : Int = 0
    @objc var rowCount : Int = 0
    @objc var start : Int = 0
    @objc var startIndex : Int = 0
}
```

产品查询翻页信息。。

| 参数          | 描述             |
| ------------- | ---------------- |
| `currentPage` | 当前页码。       |
| `end`         | 当前页结束条数。 |
| `firstPage`   | 第一页页码。     |
| `nextPage`    | 下一页页码。     |
| `page`        | 查询的页码。     |
| `pageCount`   | 页数。           |
| `pageSize`    | 分页大小。       |
| `prevPage`    | 前一页页码。     |
| `rowCount`    | 条数             |
| `start`       | 当前页开始条数。 |
| `startIndex`  | 开始翻页的索引。 |

<a name="sdkstatus"></a>

### SdkStatus 枚举

```objc
@objc public enum SdkStatus : Int{
    case NotReady
    case InitCallFail
    case InitMqttFail
    case InitPushFail
    case AllReady
    case Reconnected
    case Disconnected
}
```

SDK 状态。

**参数**

| 参数           | 描述                                                 |
| -------------- | ---------------------------------------------------- |
| `NotReady`     | 登录成功，但还在初始化各个子模块中，处于未就绪状态。 |
| `InitCallFail` | 登录成功后，初始化呼叫模块出错。                     |
| `InitMqttFail` | 登录成功后，初始化 Mqtt 模块出错。                   |
| `InitPushFail` | 登录成功后，初始化推送模块出错。                     |
| `AllReady`     | 登录成功后，初始化过程完毕，处于就绪状态。           |
| `Reconnected`  | 登录成功后，Mqtt 重连成功。                          |
| `Disconnected` | 登录成功后，Mqtt 断开连接。                          |

<a name="rtcnetworkstatus"></a>

### RtcNetworkStatus 类

```swift
public class RtcNetworkStatus : NSObject{
    public var isBusy : Bool             = false
    public var totalDuration : UInt      = 0
    public var txBytes : UInt            = 0
    public var rxBytes : UInt            = 0
    public var txKBitRate : UInt         = 0
    public var txAudioBytes : UInt       = 0
    public var rxAudioBytes : UInt       = 0
    public var txVideoBytes : UInt       = 0
    public var rxVideoBytes : UInt       = 0
    public var rxKBitRate : UInt         = 0
    public var txAudioKBitRate : UInt    = 0
    public var rxAudioKBitRate : UInt    = 0
    public var txVideoKBitRate : UInt    = 0
    public var rxVideoKBitRate : UInt    = 0
    public var lastmileDelay : UInt      = 0
    public var cpuTotalUsage : Double    = 0
    public var cpuAppUsage : Double      = 0
    public var users : UInt              = 0
    public var connectTimeMs : Int       = 0
    public var txPacketLossRate : Int    = 0
    public var rxPacketLossRate : Int    = 0
    public var memoryAppUsageRatio : Double = 0
    public var memoryTotalUsageRatio : Double = 0
    public var memoryAppUsageInKbytes : Int = 0
}
```

通话相关的统计信息。

| 参数                   | 描述                                                         |
| :--------------------- | :----------------------------------------------------------- |
| `isBusy`                 | 是否在呼叫中：<li>`true`: 在呼叫中。</li><li>`false`: 未进行呼叫。</li>            |
| `totalDuration`          | 本地用户通话时长（秒），累计值。                             |
| `txBytes`                | 发送字节数（bytes）。                                        |
| `rxBytes`                | 接收字节数（bytes）。                                        |
| `txKBitRate`             | 发送码率（Kbps）。                                           |
| `txAudioBytes`           | 发送音频字节数（bytes），累计值。                            |
| `rxAudioBytes`           | 接收音频字节数（bytes），累计值。                            |
| `txVideoBytes`           | 发送视频字节数（bytes），累计值。                            |
| `rxVideoBytes`           | 接收视频字节数（bytes），累计值。                            |
| `rxKBitRate`             | 接收码率（Kbps）。                                           |
| `txAudioKBitRate`        | 音频发送码率 (Kbps）。                                       |
| `rxAudioKBitRate`        | 音频接收码率 (Kbps）。                                       |
| `txVideoKBitRate`        | 视频发送码率 (Kbps）。                                       |
| `rxVideoKBitRate`        | 视频接收码率 (Kbps）。                                       |
| `lastmileDelay`          | 客户端到接入服务器的延时 (毫秒)。                            |
| `cpuTotalUsage`          | 当前系统的 CPU 使用率 (%)。                                  |
| `cpuAppUsage`            | 当前 App 的 CPU 使用率 (%)。                                 |
| `users`                  | 当前频道内的用户人数。                                       |
| `connectTimeMs`          | 从开始建立连接到成功连接的时间（毫秒）。如报告 0，则表示无效。 |
| `txPacketLossRate`       | 使用抗丢包技术前，客户端上行发送到服务器丢包率 (%)。         |
| `rxPacketLossRate`       | 使用抗丢包技术前，服务器下行发送到客户端丢包率 (%)。         |
| `memoryAppUsageRatio`    | 当前 App 的内存占比 (%)。该值仅作参考。受系统限制可能无法获取。 |
| `memoryTotalUsageRatio`  | 当前系统的内存占比 (%)。该值仅作参考。受系统限制可能无法获取。 |
| `memoryAppUsageInKbytes` | 当前 App 的内存大小 (KB)。该值仅作参考。受系统限制可能无法获取。 |

<a name="memberstate"></a>

### MemberState 类

```swift
@objc public enum MemberState : Int{
    case Exist
    case Enter
    case Leave
}
```

用户状态。

| 参数    | 描述                     |
| :------ | :----------------------- |
| `Exist` | 当前通话中已有其他用户。 |
| `Enter` | 其他用户加入通话。       |
| `Leave` | 其他用户退出通话。       |


<a name="actionack"></a>

### ActionAck 枚举

通话中产生的事件。

```objc
@objc public enum ActionAck:Int{

    case StateInited
    case LocalHangup
    case LocalAnswer
    case RemoteHangup
    case RemoteAnswer
    case RemoteTimeout
    case RecordEnd
    case LocalTimeout

    case RemoteVideoReady
    case RemoteAudioReady

    case RemoteBusy
    case CallIncoming
    case CallForward
    case CallOutgoing
    case UnknownAction
}
```

**参数**

| 参数               | 描述               |
| ------------------ | ------------------ |
| `StateInited`      | 初始化呼叫状态。   |
| `LocalHangup`      | 本地挂断。         |
| `LocalAnswer`      | 本地接听。         |
| `RemoteHangup`     | 设备挂断。         |
| `RemoteAnswer`     | 设备接听。         |
| `RemoteTimeout`    | 对端超时。         |
| `RecordEnd`        | 云录制停止。       |
| `LocalTimeout`     | 呼叫超时。         |
| `RemoteVideoReady` | 首次收到设备视频。 |
| `RemoteAudioReady` | 首次收到设备音频。 |
| `RemoteBusy`       | 设备忙。           |
| `CallIncoming`     | 设备来电振铃。     |
| `CallForward`      | 本地去电中继。     |
| `CallOutgoing`     | 本地去电振铃。     |
| `UnknownAction`    | 未知错误。         |

<a name="audioeffectid"></a>

### AudioEffectId 枚举

音频特效。

```objc
@objc public enum AudioEffectId:Int{
    case NORMAL
    case OLDMAN
    case BABYBOY
    case BABYGIRL
    case ZHUBAJIE
    case ETHEREAL
    case HULK
}
```

**参数**

| 参数       | 描述                                                     |
| ---------- | -------------------------------------------------------- |
| `NORMAL`   | （默认）原声，即关闭本地语音的变声、美音或语聊美声效果。 |
| `OLDMAN`   | 变声：老男孩。                                           |
| `BABYBOY`  | 变声：小男孩。                                           |
| `BABYGIRL` | 变声：小女孩。                                           |
| `ZHUBAJIE` | 变声：猪八戒                                             |
| `ETHEREAL` | 变声：空灵。                                             |
| `HULK`     | 变声：绿巨人。                                           |

