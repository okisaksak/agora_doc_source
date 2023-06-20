# agora_iot_api.h

## 引用文件

```c
#include "agora_iot_base.h"
#include "agora_iot_call.h"
#include "agora_iot_dp.h"
```

## 函数

### agora_iot_init

```c
agora_iot_handle_t agora_iot_init(const agora_iot_config_t *cfg);
```

初始化 SDK。

#### 参数

| 参数 | 描述 |
| --- | --- |
| [in] `cfg` | SDK 配置。详见 [agora_iot_config_t](#agora_iot_config_t)。 |

#### 返回值

SDK 句柄。详见 [agora_iot_handle_t](agora_iot_base#agora_iot_handle_t)。

### agora_iot_deinit

```c
void agora_iot_deinit(agora_iot_handle_t handle);
```

释放 SDK 的资源。

#### 参数

| 参数 | 描述 |
| --- | --- |
| [in] `handle` | [agora_iot_init](#agora_iot_init) 返回的 SDK 句柄。详见 [agora_iot_handle_t](#agora_iot_handle_t)。 |

### agora_iot_logfile_config

```c
int agora_iot_logfile_config(agora_iot_handle_t handle, int size_per_file, int max_file_count);
```

设置 RTC 的日志文件。

默认情况下，SDK 会生成 10 个日志文件，每个日志文件的默认大小为 1,0240 KB。如果写满了 10 个日志文件，则 SDK 会删掉第一个记录的日志文件并生成一个新的日志文件，用于记录新的日志。

如果 RTC 日志文件的默认设置不能满足你的需求，你可以调用该方法设置日志文件。

<div class="alert note">调用该方法前不要在 <a href="#agora_iot_config_t">agora_iot_config_t</a > 中设置 <code>disable_rtc_log = true</code>，否则该方法不生效。</div>

#### 参数

| 参数                  | 描述                                                         |
| :-------------------- | :----------------------------------------------------------- |
| [in] `handle`         | SDK 句柄。详见 `agora_iot_handle_t`。                        |
| [in] `size_per_file`  | 单个日志文件的大小（Byte）。默认值为 1048576，取值范围为 [0,10485760]。 |
| [in] `max_file_count` | 日志文件的最大数量。默认值为 10，取值范围为 [0,100]。        |

#### 返回

- 0：方法调用成功。
- < 0：方法调用失败。

### agora_iot_push_video_frame

```c
int agora_iot_push_video_frame(agora_iot_handle_t handle, ago_video_frame_t *frame);
```

发送视频帧。

#### 参数

| 参数 | 描述 |
| --- | --- |
| [in] `handle` | [agora_iot_init](#agora_iot_init) 返回的 SDK 句柄。详见 [agora_iot_handle_t](#agora_iot_handle_t)。 |
| [in] `frame` | 视频帧配置。详见 [ago_video_frame_t](#ago_video_frame_t)。 |

#### 返回

- 0：方法调用成功。
- < 0：方法调用失败。

### agora_iot_push_audio_frame

```c
int agora_iot_push_audio_frame(agora_iot_handle_t handle, ago_audio_frame_t *frame);
```

发送音频帧。

#### 参数

| 参数 | 描述 |
| --- | --- |
| [in] `handle` | [agora_iot_init](#agora_iot_init) 返回的 SDK 句柄。详见 [agora_iot_handle_t](agora_iot_base#agora_iot_handle_t)。 |
| [in] `frame` | 音频帧配置。详见 [ago_audio_frame_t](#ago_audio_frame_t)。 |

#### 返回

- 0：方法调用成功。
- < 0：方法调用失败。


### agora_iot_fw_info_update

```c
int agora_iot_fw_info_update(agora_iot_handle_t handle, const agora_iot_device_fw_info_t *fw_info);
```

更新固件信息。

#### 参数

| 参数 | 描述 |
| --- | --- |
| [in] `handle` | [agora_iot_init](#agora_iot_init) 返回的 SDK 句柄。详见 [agora_iot_handle_t](agora_iot_base#agora_iot_handle_t)。 |
| [in] `fw_info` |  固件信息。详见 [agora_iot_device_fw_info_t](#agora_iot_device_fw_info_t)。   |

#### 返回

- 0：方法调用成功。
- < 0：方法调用失败。


### agora_iot_send_rtm

```c
int agora_iot_send_rtm(agora_iot_handle_t handle, const char *peer_uid, uint32_t msg_id, const void *msg, size_t msg_len);
```

发送 RTM 云信令消息。最高发送频率为每秒钟 60 次。

| 参数 | 描述 |
| --- | --- |
| [in] `handle` | [agora_iot_init](#agora_iot_init) 返回的 SDK 句柄。详见 [agora_iot_handle_t](agora_iot_base#agora_iot_handle_t)。 |
| [in] `peer_uid` |  对端的 RTM 云信令用户 ID。   |
| [in] `msg` |  消息内容。   |
| [in] `peer_uid` |  消息长度。   |

#### 返回

- 0：方法调用成功。
- < 0：方法调用失败。

### agora_iot_push_alarm_image

```c
int agora_iot_push_alarm_image(agora_iot_handle_t handle, const agora_iot_file_info_t *file, char **image_id);
```

向云存储推送告警图片。

设备端触发告警事件时，该方法可以把设备抓拍的图片推送到云存储。你需要自行实现抓拍逻辑并将图片传入 `file` 参数。

<div class="alert note">仅支持推送 JPEG、JPG 和 PNG 格式的图片。</div>

#### 参数

| 参数             | 描述                                                         |
| :--------------- | :----------------------------------------------------------- |
| [in] `handle`    | [agora_iot_init](https://docs.agora.io/cn/iot-apaas/agora_iot_api#agora_iot_init) 返回的 SDK 句柄。详见 [agora_iot_handle_t](https://docs.agora.io/cn/iot-apaas/agora_iot_api#agora_iot_handle_t)。 |
| [in] `file`      | 需要推送的告警图片信息。详见 [agora_iot_file_info_t](#agora_iot_file_info_t)。       |
| [out] `image_id` | 推送到云存储后返回的图片 ID。                                |

#### 返回

- 0：方法调用成功。
- < 0：方法调用失败。

### agora_iot_push_alarm_message

```c
int agora_iot_push_alarm_message(agora_iot_handle_t handle, unsigned long long begin_time, const char *nick_name,
                                agora_iot_alarm_type_e type, const char *description, const char *image_id);
```

向应用端推送告警消息。

设备端触发告警事件时，该方法可以把告警消息及云存储中的告警图片推送到应用端。

<div class="alert info">你需要在该方法前调用 <code>agora_iot_push_alarm_image</code> 获取告警图片在云存储中的图片 ID。</div>

#### 参数

| 参数               | 描述                                                         |
| :----------------- | :----------------------------------------------------------- |
| [in] `handle`      | [agora_iot_init](https://docs.agora.io/cn/iot-apaas/agora_iot_api#agora_iot_init) 返回的 SDK 句柄。详见 [agora_iot_handle_t](https://docs.agora.io/cn/iot-apaas/agora_iot_api#agora_iot_handle_t)。 |
| [in] `begin_time`  | 告警事件触发的时间戳（ms）。<div class="alert note">告警事件与云存储中的视频仅通过该时间戳建立映射关系。如需使用告警事件云存储功能，该参数取值需大于或等于 `agora_iot_cloud_record_start` 方法中 `begin_time` 参数的值、小于 `agora_iot_cloud_record_stop` 方法中 `end_time` 参数的值。</div> |
| [in] `nick_name`   | 设备名称。                                                   |
| [in] `type`        | 告警类型。详见 [agora_iot_alarm_type_e](#agora_iot_alarm_type_e)。 |
| [in] `description` | 告警事件的描述。                                             |
| [in] `image_id`    | `agora_iot_push_alarm_image` 中输出的图片 ID。如果无需上传告警图片，设置该参数为空字符串。 |

#### 返回

- 0：方法调用成功。
- < 0：方法调用失败。

### agora_iot_cloud_record_start

```c
int agora_iot_cloud_record_start(agora_iot_handle_t handle, unsigned long long begin_time,
                                ago_av_data_type_e audio_type, ago_av_data_type_e video_type);
```

推送音视频帧到云存储。

#### 参数

| 参数              | 描述                                                         |
| :---------------- | :----------------------------------------------------------- |
| [in] `handle`     | SDK 句柄。详见 [agora_iot_handle_t](https://docs.agora.io/cn/iot-apaas/agora_iot_api#agora_iot_handle_t)。                        |
| [in] `begin_time` | 开始推送的时间戳（ms）。                                     |
| [in] `audio_type` | 音频编码格式。详见 [ago_av_data_type_e](#ago_av_data_type_e)。                    |
| [in] `video_type` | 视频编码格式。详见 [ago_av_data_type_e](#ago_av_data_type_e)。                    |

#### 返回

- 0：方法调用成功。
- < 0：方法调用失败。

<a id="agora_iot_cloud_record_stop"></a>
### agora_iot_cloud_record_stop

```c
int agora_iot_cloud_record_stop(agora_iot_handle_t handle, unsigned long long record_id, unsigned long long end_time);
```

停止推送音视频帧到云存储。

#### 参数

| 参数            | 描述                                  |
| :-------------- | :------------------------------------ |
| [in] `handle`   | SDK 句柄。详见 [agora_iot_handle_t](https://docs.agora.io/cn/iot-apaas/agora_iot_api#agora_iot_handle_t)。 |
| [in] `end_time` | 停止推送的实际时间戳（ms）。          |

#### 返回

- 0：方法调用成功。
- < 0：方法调用失败。

## 常量

无


## 类型定义

<a id="ago_av_data_type_e"></a>

### ago_av_data_type_e

音视频编码格式。

```c
typedef enum {
  AGO_VIDEO_DATA_TYPE_YUV420 = 0,
  AGO_VIDEO_DATA_TYPE_H264 = 1,
  AGO_VIDEO_DATA_TYPE_JPEG = 2,
  AGO_AUDIO_DATA_TYPE_PCM = 10,
  AGO_AUDIO_DATA_TYPE_OPUS = 11,
  AGO_AUDIO_DATA_TYPE_G711A = 12,
  AGO_AUDIO_DATA_TYPE_G711U = 13,
  AGO_AUDIO_DATA_TYPE_G722 = 14,
  AGO_AUDIO_DATA_TYPE_AACLC = 15,
  AGO_AUDIO_DATA_TYPE_HEAAC = 16,
} ago_av_data_type_e;
```

| 枚举值 | 描述 |
| --- | --- |
| `AGO_VIDEO_DATA_TYPE_YUV420` | 0：YUV420 |
| `AGO_VIDEO_DATA_TYPE_H264` | 1：H.264 |
| `AGO_VIDEO_DATA_TYPE_JPEG` | 2：JPEG |
| `AGO_AUDIO_DATA_TYPE_PCM` | 10：PCM |
| `AGO_AUDIO_DATA_TYPE_OPUS` | 11：Opus |
| `AGO_AUDIO_DATA_TYPE_G711A` | 12：G711A |
| `AGO_AUDIO_DATA_TYPE_G711U` | 13：G711U |
| `AGO_AUDIO_DATA_TYPE_G722` | 14：G722 |
| `AGO_AUDIO_DATA_TYPE_AACLC` | 15：AACLC |
| `AGO_AUDIO_DATA_TYPE_HEAAC` | 16：HEAAC |

<a id="ago_video_frame_t"></a>

### ago_video_frame_t

视频帧设置。

```c
typedef struct {
  ago_av_data_type_e data_type;
  bool is_key_frame;
  uint8_t *video_buffer;
  uint32_t video_buffer_size;
} ago_video_frame_t;
```

| 参数 | 描述 |
| --- | --- |
| `data_type` | 视频帧编码类型。 |
| `is_key_frame` | 该帧是否是关键帧。 <ul><li>true: 该帧是关键帧。</li><li>false: 该帧不是关键帧。</li></ul> |
| `video_buffer` | 视频帧缓冲区。 |
| `video_buffer_size` | 视频帧缓冲区大小。 |

<a id="ago_audio_frame_t"></a>

### ago_audio_frame_t

音频帧设置。

```c
typedef struct {
  ago_av_data_type_e data_type;
  uint8_t *audio_buffer;
  uint32_t audio_buffer_size;
} ago_audio_frame_t;
```

| 参数 | 描述 |
| --- | --- |
| `data_type` | 音频编码类型。 |
| `audio_buffer` | 音频帧缓冲区。 |
| `audio_buffer_size` | 音频帧缓冲区大小。 |

<a id="agora_iot_rtc_callback_t"></a>

### agora_iot_rtc_callback_t

```c
typedef struct agora_iot_rtc_callback {
  void (*cb_start_push_frame)(void);
  void (*cb_stop_push_frame)(void);
  void (*cb_receive_audio_frame)(ago_audio_frame_t *frame);
  void (*cb_receive_video_frame)(ago_video_frame_t *frame);
  void (*cb_key_frame_requested)(void);
  void (*cb_target_bitrate_changed)(uint32_t target_bps);
} agora_iot_rtc_callback_t;
```

SDK 音视频事件回调。

#### cb_start_push_frame

在应用端 SDK 加入频道时触发。该回调提醒你向应用端发送音视频帧。

#### cb_stop_push_frame

在应用端 SDK 离开频道时触发。该回调提醒你停止向应用端发送音视频帧。

#### cb_receive_audio_frame

在 SDK 接收到音频帧时触发。

| 参数 | 描述 |
| --- | --- |
| [in] `frame` | 音频帧设置。详见 [ago_audio_frame_t](#ago_audio_frame_t)。 |

#### cb_receive_video_frame

在 SDK 接收到视频帧时触发。

| 参数 | 描述 |
| --- | --- |
| [in] `frame` | 视频帧设置。详见 [ago_video_frame_t](#ago_video_frame_t)。 |

在 SDK 接收到视频帧时触发。

#### cb_key_frame_requested

在 SDK 需要你发送关键帧给对端时触发。该回调提醒你在本地生成一个新的关键帧并发送给对端。

#### cb_target_bitrate_changed

在 SDK 侦测到网络带宽变化时触发。你需要将发送码率调整为 SDK 推荐的值。

| 参数 | 描述 |
| --- | --- |
| [in] `target_bps` | SDK 推荐你使用的码率 (bps)。 |

<a id="ago_audio_codec_type_e"></a>

### ago_audio_codec_type_e

音频编码格式。

```c
typedef enum {
  AGO_AUDIO_CODEC_DISABLED = 0,
  AGO_AUDIO_CODEC_TYPE_OPUS = 1,
  AGO_AUDIO_CODEC_TYPE_G722 = 2,
 AGO_AUDIO_CODEC_TYPE_G711A = 3,
 AGO_AUDIO_CODEC_TYPE_G711U = 4,
} ago_audio_codec_type_e;
```

| 枚举值 | 描述 |
| --- | --- |
| `AGO_AUDIO_CODEC_DISABLED` | 0：PCM。|
| `AGO_AUDIO_DATA_TYPE_OPUS` | 1：Opus。支持 16 KHz 或 48 KHz 采样率。每个样本 16 bit，单声道。每次发送数据长度 20 ms。 |
| `AGO_AUDIO_DATA_TYPE_G722` | 2：G722。支持 16 KHz 采样率。每个样本 16 bit，单声道。每次发送数据长度 20 ms。 |
| `AGO_AUDIO_DATA_TYPE_G711A` | 3：G711A。支持 8 KHz 采样率。每个样本 16 bit，单声道。每次发送数据长度 20 ms。 |
| `AGO_AUDIO_DATA_TYPE_G711U` | 4：G711U。支持 8 KHz 采样率。每个样本 16 bit，单声道。每次发送数据长度 20 ms。 |

<a id="agora_iot_audio_config_t"></a>

### agora_iot_audio_config_t

音频设置选项。

```c
typedef struct _agora_iot_audio_config {
  ago_audio_codec_type_e audio_codec_type;
  int pcm_sample_rate;
  int pcm_channel_num;
} agora_iot_audio_config_t;
```

| 参数 | 描述 |
| --- | --- |
| `audio_codec_type` | 音频编码类型。详见 [ago_audio_codec_type_e](#ago_audio_codec_type_e)。 |
| `pcm_sample_rate` | PCM 音频数据的采样率（Hz）。 |
| `pcm_channel_num` | PCM 音频数据的通道数。 |

<a id="agora_iot_device_fw_info"></a>
### agora_iot_device_fw_info

固件信息。

```c
typedef struct agora_iot_device_fw_info {
  char fw_wifi_ver[16];
  char fw_mcu_ver[16];
} agora_iot_device_fw_info_t;
```

| 参数 | 描述 |
| --- | --- |
| `fw_wifi_ver` | WiFi 固件版本。 |
| `fw_mcu_ver` | MCU 固件版本。|

<a id="agora_fw_type_e"></a>
### agora_fw_type_e

```c
typedef enum {
  AGO_FW_WIFI = 0,
  AGO_FW_MCU  = 1
} agora_fw_type_e;
```

固件类型。

| 参数 | 描述 |
| --- | --- |
| `AGO_FW_WIFI` | WiFi。 |
| `AGO_FW_MCU` | MCU。|

<a id="agora_iot_device_fota_info_t"></a>
### agora_iot_device_fota_info_t

```c
typedef struct agora_iot_device_fota_info {
  agora_fw_type_e type;
  uint32_t file_size;
  char *file_ver;
  char *file_url;
} agora_iot_device_fota_info_t;
```

| 参数 | 描述 |
| --- | --- |
| `type` | 固件类型。详见 [agora_fw_type_e](#agora_fw_type_e)。 |
| `file_size` | 固件大小。|
| `file_ver` | 固件版本。|
| `file_url` | 固件 URL。|


<a id="agora_iot_ota_callback_t"></a>
### agora_iot_ota_callback_t

```c
typedef struct agora_iot_ota_callback {
  void (*fw_updated)(const agora_iot_device_fota_info_t *info);
} agora_iot_ota_callback_t;
```

OTA 升级回调。

<a id="fw_updated"></a>
#### fw_updated

客户端 SDK 已通知设备端更新固件。

| 参数 | 描述 |
| --- | --- |
| `info` | 固件信息。详见 [agora_iot_device_fota_info_t](#agora_iot_device_fota_info_t)。 |


<a id="agora_rtm_err_e"></a>

### agora_rtm_err_e

```c
typedef enum {
  ERR_AGORA_RTM_OK = ERR_SUCCESS,
  ERR_AGORA_RTM_FAILED = ERR_FAILED,
} agora_rtm_err_e;
```

RTM 云信令错误码。

| 枚举 | 描述 |
| ---  | --- |
| `ERR_AGORA_RTM_OK` | 没有错误。 |
| `ERR_AGORA_RTM_FAILED` | 通用错误。 |

<a id="agora_iot_rtm_callback_t"></a>

### agora_iot_rtm_callback_t

```c
typedef struct agora_iot_rtm_callback {

  void (*on_receive_rtm)(const char *peer_uid, const void *msg, size_t msg_len);

  void (*on_send_rtm_result)(uint32_t msg_id, agora_rtm_err_e error_code);
} agora_iot_rtm_callback_t;
```

RTM 云信令回调。

#### on_receive_rtm

接收到对端发送的 RTM 云信令消息时触发。

| 参数 | 描述 |
| ---  | --- |
| `peer_uid` | 对端的 RTM 云信令用户 ID。 |
| `msg` | 消息内容。 |
| `msg_len` | 消息长度。 |

#### on_send_rtm_result

RTM 云信令发送结果。

| 参数 | 描述 |
| ---  | --- |
| `msg_id` | 消息 ID。 |
| `error_code` | 错误码。详见[agora_rtm_err_e](#agora_rtm_err_e)。 |


<a id="agora_iot_status_e"></a>

### agora_iot_status_e

```c
typedef enum {
  AGORA_IOT_CONNECTED = 0,
  AGORA_IOT_RECONNECTING,
  AGORA_IOT_DISCONNECTED,
} agora_iot_status_e;
```

SDK 连接状态。

| 枚举 | 描述 |
| ---  | --- |
| `AGORA_IOT_CONNECTED` | 已连接。 |
| `AGORA_IOT_RECONNECTING` | 正在重连。 |
| `AGORA_IOT_DISCONNECTED` | 连接已断开。|


<a id="agora_iot_connect_callback_t"></a>

### agora_iot_connect_callback_t

```c
typedef struct agora_iot_connect_callback {
  void (*on_connect_status)(agora_iot_status_e status);
} agora_iot_connect_callback_t;
```

SDK 连接状态回调。

| 参数 | 描述 |
| ---  | --- |
| `status` | 连接状态。详见 [agora_iot_status_e](#agora_iot_status_e)。 |

<a id="agora_iot_alarm_type_e"></a>
### agora_iot_alarm_type_e

```c
typedef enum {
  AG_ALARM_TYPE_VAD           = 0,
  AG_ALARM_TYPE_MOD           = 1,
  AG_ALARM_TYPE_OTHERS        = 99
}
```

告警类型。

`TYPE` 值 2 至 98 为预留值，仅供声网使用。

如需根据实际业务需求设计其他告警类型，你可以自定义 100 及以上的 `TYPE` 值。

| 参数                 | 描述               |
| :--------------------- | :----------------- |
| `AG_ALARM_TYPE_VAD`    | 0：语音监测。      |
| `AG_ALARM_TYPE_MOD`    | 1：动作监测。      |
| `AG_ALARM_TYPE_OTHERS` | 99：其他告警类型。 |

<a id="agora_iot_file_info_t"></a>
### agora_iot_file_info_t

```c
typedef struct agora_iot_file_info {
  char *name_suffix;
  char *buf;
  int size;
} agora_iot_file_info_t;
```

告警图片信息。

| 参数               | 描述                                       |
| :----------------- | :----------------------------------------- |
| [in] `name_suffix` | 图片的文件名后缀。仅支持以下值：<li>JPEG</li><li>JPG</li><li>PNG</li> |
| [in] `buf`         | 图片需要的 buffer 大小（ms）。             |
| [in] `size`        | 图片文件的大小（KB）。取值范围为 [0,512]。 |

<a id="agora_iot_log_level_e"></a>
### agora_iot_log_level_e

```c
typedef enum {
  AGORA_LOG_DEFAULT = 0,
  AGORA_LOG_EMERG,
  AGORA_LOG_ALERT,
  AGORA_LOG_CRIT,
  AGORA_LOG_ERROR,
  AGORA_LOG_WARNING,
  AGORA_LOG_NOTICE,
  AGORA_LOG_INFO,
  AGORA_LOG_DEBUG,
} agora_iot_log_level_e;
```

日志输出等级。

| 参数            | 描述                                 |
| :---------------- | :----------------------------------- |
| `AGORA_LOG_DEFAULT` | 0: 默认等级，即 `AGORA_LOG_NOTICE`。 |
| `AGORA_LOG_EMERG`   | 该等级的日志表示系统不可用。         |
| `AGORA_LOG_ALERT`   | 该等级的日志表示有问题需立即处理。   |
| `AGORA_LOG_CRIT`    | 危险等级。                           |
| `AGORA_LOG_ERROR`   | 错误等级。                           |
| `AGORA_LOG_WARNING` | 警告等级。                           |
| `AGORA_LOG_NOTICE`  | 注意等级。                           |
| `AGORA_LOG_INFO`    | 通知等级。                           |
| `AGORA_LOG_DEBUG`   | 调试等级。                           |

<a id="agora_iot_config_t"></a>
### agora_iot_config_t

SDK 基本设置。

```c
typedef struct agora_iot_config {
  const char *app_id;
  const char *product_id;
  const char *client_id;
  const char *domain;
  const char *root_ca;
  const char *client_crt;
  const char *client_key;

  bool enable_rtc;
  const char *certificate;
  bool enable_recv_audio;
  bool enable_recv_video;
  agora_iot_rtc_callback_t rtc_cb;

  bool disable_rtc_log;
	agora_iot_log_level_e log_level;
  uint32_t max_possible_bitrate;
  bool enable_audio_config;
  agora_iot_audio_config_t audio_config;

  const char *slave_server_url;
	agora_call_mode_e call_mode;
  agora_iot_call_callback_t call_cb;
} agora_iot_config_t;
```


| 参数 | 描述 |
| --- | --- |
| `app_id` |声网为 app 开发者签发的 App ID，详见[获取 App ID](https://docs.agora.io/cn/Agora%20Platform/token#get-an-app-id)。使用同一个 App ID 的 SDK 才能互通。 |
| `product_id` | 你的产品 ID，即 Product Key。详见[开通并配置声网灵隼服务](/cn/iot-apaas/enable_agora_link)。 |
| `client_id` | Client ID，用于呼叫。调用 [agora_iot_register_and_bind](agora_iot_device_manager#agora_iot_register_and_bind) 注册设备成功后返回。 |
| `domain` |  设备端域名。可以从 [agora_iot_register_and_bind](agora_iot_device_manager#agora_iot_register_and_bind) 方法返回的 `agora_iot_device_info_t::domain` 参数获取。 |
| `root_ca` | AWS 服务根证书。你可以将值设为示例项目中的 `CONFIG_AWS_ROOT_CA` 的值，也可以自行[申请一个 AWS 根证书](https://docs.aws.amazon.com/zh_cn/acm-pca/latest/userguide/PCACertInstall.html)。 |
| `client_crt` | 设备端证书。可以从 [agora_iot_register_and_bind](agora_iot_device_manager#agora_iot_register_and_bind) 方法返回的 `agora_iot_device_info_t::certificate` 参数获取。 |
| `client_key` | 设备端私钥。可以从 [agora_iot_register_and_bind](agora_iot_device_manager#agora_iot_register_and_bind) 方法返回的 `agora_iot_device_info_t::private_key` 参数获取。 |
| `enable_rtc` | 是否开启音视频传输。<ul><li>true：开启音视频传输。</li><li>false：关闭音视频传输。</li></ul> |
| `certificate` | [agora_license_activate](agora_iot_device_manager#agora_license_activate) 方法返回的证书。 |
| `enable_recv_audio` | 本地是否接收音频。<ul><li>true：接收音频。</li><li>false：不接收音频。</li></ul>  |
| `enable_recv_video` | 本地是否接收视频。<ul><li>true：接收视频。</li><li>false：不接收视频。</li></ul> |
| `rtc_cb` | 音视频传输事件回调。详见 [agora_iot_rtc_callback_t](#agora_iot_rtc_callback_t) 结构体。 |
| `disable_rtc_log` | 是否关闭日志。 <ul><li>true：关闭日志。</li><li>false：开启日志。</li></ul>|
| `log_level` | 设置日志等级。详见 [agora_iot_log_level_e](#agora_iot_log_level_e)。<div class="alert note">该参数仅在 <code>disable_rtc_log</code> 为 <code>false</code> 时生效。</div> |
| `max_possible_bitrate` | 可能出现的最大码率（bps）。 |
| `enable_audio_config` | 是否开启音频配置。 <ul><li>true：开启音频配置。你可以通过 `audio_config` 参数配置音频。</li><li>false：关闭音频配置。`audio_config` 参数的设置无效。</li></ul>|
| `audio_config` | 音频配置。详见 [agora_iot_audio_config_t](#agora_iot_audio_config_t) 结构体。 |
| `slave_server_url` | SDK 使用的 AWS OpenAPI 服务的主机域名。你可以在声网灵隼控制台的**应用配置>>开发者选项>>呼叫服务>>Slave Server URL** 处获取。详见[开通并配置声网灵隼服务](/cn/iot-apaas/enable_agora_link)。 |
| `call_cb` | 呼叫事件回调。详见 [agora_iot_call_callback_t](#agora_iot_call_callback_t) 结构体。 |
| `ota_cb` | OTA 升级事件回调。详见 [agora_iot_ota_callback_t](#agora_iot_ota_callback_t) 结构体。 |
| `rtm_cb` | RTM 云信令事件回调。详见 [agora_iot_rtm_callback_t](#agora_iot_rtm_callback_t) 结构体。 |
| `connect_cb` | 呼叫事件回调。详见 [agora_iot_connect_callback_t](#agora_iot_connect_callback_t) 结构体。 |
| `call_mode` | 通话模式，详见 [agora_call_mode_e](./agora_iot_call.h#agora_call_mode_e) 枚举。 |

# agora_iot_base.h

## 引用文件

无

## 函数

无

## 常量

无

## 类型定义

<a id="agora_iot_handle_t"></a>
### agora_iot_handle_t

```c
typedef void* agora_iot_handle_t;
```

SDK 的句柄。

<a id="agora_iot_error_e"></a>
### agora_iot_error_e

```c
typedef enum {
  ERR_SUCCESS = 0,
  ERR_FAILED = -1,
  ERR_INVALID_ARGUMENT = -2,
} agora_iot_error_e;
```

错误码。

| 错误码 | 描述 |
| --- | --- |
| `ERR_SUCCESS` | 0：调用成功。 |
| `ERR_FAILED` | -1：通用错误。 |
| `ERR_INVALID_ARGUMENT` | -2：参数无效。 |

# agora_iot_call.h

## 引用文件

```c
#include "agora_iot_base.h"
```

## 函数

<a id="agora_iot_call"></a>
### agora_iot_call

```c
agora_iot_call_result_e agora_iot_call(agora_iot_handle_t handle, const char *peer, const char *extra_msg);
```

呼叫远端用户。

#### 参数

| 参数 | 描述 |
| --- | --- |
| [in] `handle` | [agora_iot_init](agora_iot_api#agora_iot_init) 返回的 SDK 句柄。详见 [agora_iot_handle_t](agora_iot_api#agora_iot_handle_t)。 |
| [in] `peer` | 应答呼叫的远端用户 ID。 |
| [in] `extra_msg` | 呼叫的附加信息。最大长度为 1024 字节（含 `'\0'`）。 |

#### 返回

[agora_iot_call_result_e](#agora_iot_call_result_e) 中的枚举值。

<a id="agora_iot_answer"></a>
### agora_iot_answer

```c
agora_iot_call_result_e agora_iot_answer(agora_iot_handle_t handle);
```

应答远端用户发来的呼叫。

#### 参数

| 参数 | 描述 |
| --- | --- |
| [in] `handle` | [agora_iot_init](agora_iot_api#agora_iot_init) 返回的 SDK 句柄。详见 [agora_iot_handle_t](agora_iot_api#agora_iot_handle_t)。 |

#### 返回

[agora_iot_call_result_e](#agora_iot_call_result_e) 中的枚举值。

<a id="agora_iot_hang_up"></a>
### agora_iot_hang_up

```c
agora_iot_call_result_e agora_iot_hang_up(agora_iot_handle_t handle);
```

拒绝远端用户发来的呼叫或挂断当前通话。

#### 参数

| 参数 | 描述 |
| --- | --- |
| [in] `handle` | [agora_iot_init](agora_iot_api#agora_iot_init) 返回的 SDK 句柄。详见 [agora_iot_handle_t](agora_iot_api#agora_iot_handle_t)。 |

#### 返回

[agora_iot_call_result_e](#agora_iot_call_result_e) 中的枚举值。

<!-- TODO: agora_iot_alarm 有错误码吗？为什么返回 int?其他方法都返回枚举。 -->

## 常量

无

## 类型定义

<a id="agora_iot_call_result_e"></a>
### agora_iot_call_result_e

```c
typedef enum {
  ERR_AG_CALL_SUCCESS            = ERR_SUCCESS,
  ERR_AG_CALL_FAILED             = ERR_FAILED,
  ERR_AG_CALL_INVALID_ARGUMENT   = ERR_INVALID_ARGUMENT,

  ERR_AG_CALL_PEER_BUSY          = -100001,
  ERR_AG_CALL_CAN_NOT_ANSWER     = -100002,
  ERR_AG_CALL_CAN_NOT_HANGUP     = -100003,
  ERR_AG_CALL_PEER_TIMEOUT       = -100004,
  ERR_AG_CALL_IS_CALLING         = -100005,
  ERR_AG_CALL_ILLEGAL_ANSWER     = -100006,
  ERR_AG_CALL_CAN_NOT_CALL_YOURSELF = -100007,

	ERR_AG_CLOUD_REC_STARTED        = -200001,
  ERR_AG_CLOUD_REC_STOPPED        = -200002,
  ERR_AG_CLOUD_REC_NOT_PERMISSION = -200003,
  ERR_AG_CLOUD_REC_PERMISSION_EXPIRED = -200004,
  ERR_AG_CLOUD_REC_WITHOUT_APPID  = -200005,
  ERR_AG_CLOUD_REC_SERVER_NOT_ENABLE  = -200006,

  ERR_AG_ALARM_NOT_PERMISSION     = -999997,
  ERR_AG_ALARM_INVALID_ARGUMENTS  = -999998,
  ERR_AG_CALL_UNEXPECTEDLY_ERROR = -999999,
} agora_iot_call_result_e;
```

呼叫返回结果。

| 枚举值 | 描述 |
| --- | --- |
| `ERR_AG_CALL_SUCCESS` | 0：调用成功。 |
| `ERR_AG_CALL_FAILED` | -1：通用错误。 |
| `ERR_AG_CALL_INVALID_ARGUMENT` | -2：参数无效。 |
| `ERR_AG_CALL_PEER_BUSY` | -100001：本地用户无法重复呼叫。因为被呼叫的远端用户已经处于通话中。 |
| `ERR_AG_CALL_CAN_NOT_ANSWER` | -100002：本地用户无法应答呼叫。因为没有外来或发出的呼叫。|
| `ERR_AG_CALL_CAN_NOT_HANGUP` | -100003：本地用户无法挂断呼叫。因为本地用户不在呼叫中，也没有发送呼叫。 |
| `ERR_AG_CALL_PEER_TIMEOUT` | -100004：本地用户呼叫远端用户时等待超过 30 秒。 |
| `ERR_AG_CALL_IS_CALLING` | -100005： 已经有远端用户呼叫本地用户或本地用户已呼叫远端用户。|
| `ERR_AG_CALL_ILLEGAL_ANSWER` | -100006：错误的应答操作。例如本地用户应答从本地发出的呼叫。 |
| `ERR_AG_CALL_CAN_NOT_CALL_YOURSELF` | -100007：呼叫错误。因为本地用户无法呼叫自己。 |
| `ERR_AG_CLOUD_REC_STARTED` | -200001：云录制已经开始，无法再次开启。 |
| `ERR_AG_CLOUD_REC_STOPPED` | -200002：云录制已经停止，无法再次停止。 |
| `ERR_AG_CLOUD_REC_NOT_PERMISSION` | -200003：没有权限进行云录制。 |
| `ERR_AG_CLOUD_REC_PERMISSION_EXPIRED` | -200004：云录制权限已过期。 |
| `ERR_AG_CLOUD_REC_WITHOUT_APPID` | -100007：内部错误。 |
| `ERR_AG_CLOUD_REC_SERVER_NOT_ENABLE` | -100007：未开通声网灵隼服务。 |
| `ERR_AG_ALARM_NOT_PERMISSION` | -100007：呼叫错误。因为本地用户无法呼叫自己。 |
| `ERR_AG_ALARM_INVALID_ARGUMENTS` | -100007：呼叫错误。因为本地用户无法呼叫自己。 |
| `ERR_AG_CALL_UNEXPECTEDLY_ERROR` | -999999：未知错误。 |

<a id="agora_call_mode_e"></a>
### agora_call_mode_e

```c
typedef enum {
  CALL_MODE_SINGLE    = 1,
  CALL_MODE_MUTLI     = 2,
} agora_call_mode_e;
```

通话模式。

| 枚举值             | 描述                                       |
| :----------------- | :----------------------------------------- |
| `CALL_MODE_SINGLE` | 1: 单人模式。只允许一位用户与设备音视频通话。 |
| `CALL_MODE_MUTLI`  | 2: 多人模式。允许多位用户与设备音视频通话。   |

<a id="agora_iot_alarm_type_e"></a>
### agora_iot_alarm_type_e

```c
typedef enum {
  AG_ALARM_TYPE_VAD           = 0,
  AG_ALARM_TYPE_MOD           = 1,
  AG_ALARM_TYPE_OTHERS        = 99
} agora_iot_alarm_type_e;
```

告警类型。

| 枚举值 | 描述 |
| --- | --- |
| `AG_ALARM_TYPE_VAD` | 0：语音监测。 |
| `AG_ALARM_TYPE_MOD` | 1：动作监测。 |
| `AG_ALARM_TYPE_OTHERS` | 99：其他告警类型。 |

<a id="agora_iot_call_callback"></a>
### agora_iot_call_callback

```c
typedef struct agora_iot_call_callback {
  void (*cb_call_request)(const char *peer_id, const char *attach_msg);
  void (*cb_call_answered)(const char *peer_id);
  void (*cb_call_hung_up)(const char *peer_id);
  void (*cb_call_local_timeout)(const char *peer_id);
  void (*cb_call_peer_timeout)(const char *peer_id);
} agora_iot_call_callback_t;
```

SDK 呼叫事件回调。

#### cb_call_request

在本地用户接收到远端用户呼叫时触发。

| 参数 | 描述 |
| --- | --- |
| [in] `peer_id` | 发送呼叫的远端用户账号。 |
| [in] `attach_msg` | 呼叫的附加信息。 |

#### cb_call_answered

本地用户发出的呼叫被远端用户应答时触发。

| 参数 | 描述 |
| --- | --- |
| [in] `peer_id` | 应答呼叫的远端用户账号。 |

#### cb_call_hung_up

本地用户发送的呼叫被远端用户拒绝。

| 参数 | 描述 |
| --- | --- |
| [in] `peer_id` | 拒绝呼叫的远端用户账号。 |

#### cb_call_local_timeout

远端用户呼叫本地用户时，由于 30 秒内本地用户没有应答或拒绝操作导致超时。

你可以[联系技术支持](https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms)更改超时时间。

| 参数 | 描述 |
| --- | --- |
| [in] `peer_id` | 超时的远端用户账号。 |

#### cb_call_peer_timeout

本地用户呼叫远端用户时，由于 30 秒内远端用户没有进行应答或拒绝操作导致呼叫超时。

你可以[联系技术支持](https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms)更改超时时间。

| 参数 | 描述 |
| --- | --- |
| [in] `peer_id` | 超时的远端用户账号。 |

# agora_iot_device_manager.h

## 引用文件

无

## 函数

<a id="agora_iot_register_and_bind"></a>
### agora_iot_register_and_bind

```c
int agora_iot_register_and_bind(const char *host_url, const char *product_key, const char *device_id,
                                const char *user_id, const char *device_nickname, agora_iot_device_info_t *info);
```

注册设备并将设备与用户绑定。

#### 参数

| 参数 | 描述 |
| --- | --- |
| [in] `host_url` | SDK 使用的 AWS OpenAPI 服务的主机域名。你可以在声网灵隼控制台的**应用配置>>开发者选项>>呼叫服务>>Master Server URL** 处获取。详见 [开通并配置声网灵隼服务](enable_agora_link)。  |
| [in] `product_key` | 你的 Product Key。可以从声网灵隼控制台的**应用配置**页面的**开发者选项**选项卡中获取。详见 [开通声网灵隼服务](enable_agora_link)。 |
| [in] `device_id` | 你的设备 ID。你需要自行设置。每个设备的设备 ID 必须是唯一的。长度为 1 ~ 128 个字符。字符集支持：<ul><li>26 个大写英文字母和小写英文字母。</li><li>阿拉伯数字： 0-9。</li><li>特殊符号：`":"`、`"_"`、`"-"`。</li></ul>设备 ID 与 License 绑定。参考 [开通声网灵隼服务](enable_agora_link)获取免费或商业 License。 |
| [in] `user_id` | 你的用户 ID。 |
| [in] `device_nickname` | 设备昵称。客户端 SDK 的设备绑定列表会显示该昵称。你可以任意指定，通常建议与产品名称一致（请使用 UTF-8 编码设置中文名称）。如果使用了绑定功能，该名称将显示在应用端。你也可以在应用端为设备重新命名。 |
| [out] `info` | 注册绑定完成后返回的设备信息。详见 [agora_iot_device_info_t](#agora_iot_device_info_t)。 |

#### 返回

- 0：方法调用成功。
- < 0：方法调用失败。

<a id="agora_iot_query_user"></a>
### agora_iot_query_user

```c
int agora_iot_query_user(const char *host_url,  const char *product_key, const char *device_id, char *user_id);
```

#### 参数

| 参数 | 描述 |
| --- | --- |
| [in] `host_url` | SDK 使用的 AWS OpenAPI 服务的主机域名。你可以在声网灵隼控制台的**应用配置>>开发者选项>>呼叫服务>>Master Server URL** 处获取。详见 [开通并配置声网灵隼服务](enable_agora_link)。  |
| [in] `product_key` | 你的 Product Key。可以从声网灵隼控制台的**应用配置**页面的**开发者选项**选项卡中获取。详见 [开通声网灵隼服务](enable_agora_link)。 |
| [in] `device_id` | 你的设备 ID。你需要自行设置。每个设备的设备 ID 必须是唯一的。长度为 1 ~ 128 个字符。字符集支持：<ul><li>26 个大写英文字母和小写英文字母。</li><li>阿拉伯数字： 0-9。</li><li>特殊符号：`":"`、`"_"`、`"-"`。</li></ul>设备 ID 与 License 绑定。参考 [开通声网灵隼服务](enable_agora_link)获取免费或商业 License。 |
| [out] `user_id` | 与设备绑定的的用户 ID。 |

查询设备绑定的用户。

#### 返回

- 0：方法调用成功。
- < 0：方法调用失败。

<a id="agora_license_activate"></a>
### agora_iot_license_activate

```c
int agora_iot_license_activate(const char *appid, const char *key, const char *secret,
                              const char *product_key, const char *device_id, const char *pid, char **cert);
```

激活 License 并生成证书。每次激活将消耗一个 License 额度。

#### 参数

| 参数 | 描述 |
| --- | --- |
| [in] `appid` | 你的声网 App ID。可以从声网灵隼控制台的**应用配置**页面的**开发者选项**选项卡中获取。详见[开通声网灵隼服务](enable_agora_link)。 |
| [in] `key` | 你的 Restful API Customer ID。可以从声网灵隼控制台的**应用配置**页面的**开发者选项**选项卡中获取。详见[开通声网灵隼服务](enable_agora_link)。 |
| [in] `secret` | 你的 Restful API Customer Secret。可以从声网灵隼控制台的**应用配置**页面的**开发者选项**选项卡中获取。详见[开通声网灵隼服务](enable_agora_link)。 |
| [in] `product_key` | 你的 Product Key。可以从声网灵隼控制台的**应用配置**页面的**开发者选项**选项卡中获取。详见 [开通声网灵隼服务](enable_agora_link)。 |
| [in] `device_id` | 你的设备 ID。你需要自行设置。每个设备的设备 ID 必须是唯一的。长度为 1 ~ 128 个字符。字符集支持：<ul><li>26 个大写英文字母和小写英文字母。</li><li>阿拉伯数字： 0-9。</li><li>特殊符号：`":"`、`"_"`、`"-"`。</li></ul>设备 ID 与 License 绑定。参考 [开通声网灵隼服务](enable_agora_link)获取免费或商业 License。 |
| [in] `pid` | 你的 PID。可以从声网灵隼控制台的用量查看页面中获取。 |
| [out] `cert` | 激活成功后生成的证书。License 激活成功后，接口将返回获取到的 License 检验证书，用于 SDK 初始化的授权凭证，你需要保存证书到配置文件或 Flash 中，下次运行时从文件或 Flash 中获取证书。  |

#### 返回

- 0：方法调用成功。
- < 0：方法调用失败。

## 常量

### AGORA_IOT_CERTIFICATE_MAX_LEN

```c
#define AGORA_IOT_CERTIFICATE_MAX_LEN 2048
```

证书最大长度。

### AGORA_IOT_PRIVATE_KEY_MAX_LEN

```c
#define AGORA_IOT_PRIVATE_KEY_MAX_LEN 2048
```

私钥最大长度。

### AGORA_IOT_DOMAIN_MAX_LEN

```c
#define AGORA_IOT_DOMAIN_MAX_LEN 256
```

域名最大长度。

## 类型定义

<a id="agora_iot_device_info_t"></a>
### agora_iot_device_info_t

```c
typedef struct agora_iot_device_info {
  char certificate[AGORA_IOT_CERTIFICATE_MAX_LEN];
  char private_key[AGORA_IOT_PRIVATE_KEY_MAX_LEN];
  char domain[AGORA_IOT_DOMAIN_MAX_LEN];
  char client_id[AGORA_IOT_CLIENT_ID_MAX_LEN];
} agora_iot_device_info_t;
```

设备信息。

| 参数 | 描述 |
| --- | --- |
| `certificate[AGORA_IOT_CERTIFICATE_MAX_LEN]` | 设备证书。 |
| `private_key[AGORA_IOT_PRIVATE_KEY_MAX_LEN]` | 设备私钥。 |
| `domain[AGORA_IOT_DOMAIN_MAX_LEN]` | 域名。 |
| `client_id[AGORA_IOT_CLIENT_ID_MAX_LEN]` | Client ID。用于呼叫。 |

# agora_iot_dp.h

## 引用文件

```c
#include "agora_iot_base.h"
```

## 函数

<a id="agora_iot_dp_register_dp_query_handler"></a>
### agora_iot_dp_register_dp_query_handler

```c
agora_iot_dp_result_e agora_iot_dp_register_dp_query_handler(agora_iot_handle_t handle, int dp_id,
                                                             agora_dp_type_e dp_type, on_dp_query_callback callback,
                                                             void *args);
```

注册属性查询回调。

你需要确保已经在控制台通过**功能定义**页面新增了相应功能。详见[开通声网灵隼](enable_agora_link)。

#### 参数

| 参数 | 描述 |
| --- | --- |
| [in] `handle` | [agora_iot_init](agora_iot_api#agora_iot_init) 返回的 SDK 句柄。详见 [agora_iot_handle_t](agora_iot_base#agora_iot_handle_t)。 |
| [in] `dp_id` | 属性 ID。即控制台**功能定义**页面的功能标识符。详见[开通声网灵隼](enable_agora_link)。 |
| [in] `dp_type` | 属性的数据类型。详见 [agora_dp_type_e](#agora_dp_type_e)。  |
| [in] `callback` | 属性查询回调。详见 [on_dp_query_callback](#on_dp_query_callback)。 |
| [in] `args` | 回调参数。 |

#### 返回

[agora_iot_dp_result_e](#agora_iot_dp_result_e) 结构体中的枚举。

<a id="agora_iot_dp_register_dp_cmd_handler"></a>
### agora_iot_dp_register_dp_cmd_handler

```c
agora_iot_dp_result_e agora_iot_dp_register_dp_cmd_handler(agora_iot_handle_t handle, int dp_id,
                                                           agora_dp_type_e dp_type, on_dp_cmd_callback callback,
                                                           void *args);
```

注册属性命令回调。

你需要确保已经在控制台通过**功能定义**页面新增了相应功能。详见[开通声网灵隼](enable_agora_link)。

#### 参数

| 参数 | 描述 |
| --- | --- |
| [in] `handle` | [agora_iot_init](agora_iot_api#agora_iot_init) 返回的 SDK 句柄。详见 [agora_iot_handle_t](agora_iot_base#agora_iot_handle_t)。 |
| [in] `dp_id` | 属性 ID。即控制台**属性定义**页面的属性标识符。参考[开通声网灵隼](enable_agora_link)在控制台创建属性。 |
| [in] `dp_type` | 属性的数据类型。详见 [agora_dp_type_e](#agora_dp_type_e)。  |
| [in] `callback` | 属性命令回调。详见 [on_dp_cmd_callback](#on_dp_query_callback)。 |
| [in] `args` | 回调参数。 |

#### 返回

[agora_iot_dp_result_e](#agora_iot_dp_result_e) 结构体中的枚举。

<a id="agora_iot_dp_publish"></a>
### agora_iot_dp_publish

```c
agora_iot_dp_result_e agora_iot_dp_publish(agora_iot_handle_t handle, agora_dp_info_t *info);
```

发布一个属性。

你需要确保已经在控制台通过**功能定义**页面新增了相应属性。详见[开通声网灵隼](enable_agora_link)。

#### 参数

| 参数 | 描述 |
| --- | --- |
| [in] `handle` | [agora_iot_init](agora_iot_api#agora_iot_init) 返回的 SDK 句柄。详见 [agora_iot_handle_t](agora_iot_base#agora_iot_handle_t)。 |
| [in] `info` | 属性信息。详见 [agora_dp_info_t](#agora_dp_info_t)。 |

#### 返回

[agora_iot_dp_result_e](#agora_iot_dp_result_e) 结构体中的枚举。

<a id="agora_iot_dp_publish_all"></a>
### agora_iot_dp_publish_all

```c
agora_iot_dp_result_e agora_iot_dp_publish_all(agora_iot_handle_t handle);
```

发布全部属性。你需要确保已经在控制台通过**功能定义**页面新增了相应属性。详见[开通声网灵隼](enable_agora_link)。

在发布全部属性之前，确保你已经调用 [agora_iot_dp_register_dp_query_handler](#agora_iot_dp_register_dp_query_handler) 注册了属性回调。

#### 参数

| 参数 | 描述 |
| --- | --- |
| [in] `handle` | [agora_iot_init](#agora_iot_init) 返回的 SDK 句柄。详见 [agora_iot_handle_t](#agora_iot_handle_t)。 |

#### 返回

[agora_iot_dp_result_e](#agora_iot_dp_result_e) 结构体中的枚举。

## 常量

### AGORA_DP_USER_LEN

```c
#define AGORA_DP_USER_LEN     64
```

属性用户名长度。

### AGORA_DP_ID_MIN

```c
#define AGORA_DP_ID_MIN       100
```

属性 ID 长度的最小值。

## 类型定义

<a id="agora_iot_dp_result_e"></a>
### agora_iot_dp_result_e

```c
typedef enum {
  ERR_AG_DP_SUCCESS           = ERR_SUCCESS,
  ERR_AG_DP_FAILED            = ERR_FAILED,
  ERR_AG_DP_INVALID_ARGUMENT  = ERR_INVALID_ARGUMENT,
} agora_iot_dp_result_e;
```

属性函数调用结果。

| 参数 | 描述 |
| --- | --- |
| `ERR_AG_DP_SUCCESS` | 0：方法调用成功。 |
| `ERR_AG_DP_FAILED` | -1：方法调用失败。 |
| `ERR_AG_DP_INVALID_ARGUMENT` | -2：参数无效。 |

<a id="agora_dp_type_e"></a>
### agora_dp_type_e

```c
typedef enum agora_dp_type {
  AGORA_DP_TYPE_INT           = 0,
  AGORA_DP_TYPE_BOOL          = 1,
  AGORA_DP_TYPE_ENUM          = 2,
  AGORA_DP_TYPE_STR           = 3,
} agora_dp_type_e;
```

属性类型。

| 参数 | 描述 |
| --- | --- |
| `AGORA_DP_TYPE_INT` | 0：整数类型。 |
| `AGORA_DP_TYPE_BOOL` | 1：布尔类型。 |
| `AGORA_DP_TYPE_ENUM` | 2：枚举类型。 |
| `AGORA_DP_TYPE_STR` | 3：字符串类型。 |

<a id="agora_dp_value_t"></a>
### agora_dp_value_t

```c
typedef union {
  int dp_int;
  bool dp_bool;
  unsigned int dp_enum;
  char *dp_str;
} agora_dp_value_t;
```

属性的值。

| 参数 | 描述 |
| --- | --- |
| `dp_int` | 整数类型的值。 |
| `dp_bool` | 布尔类型的值。 |
| `dp_enum` | 枚举类型的值。 |
| `dp_str` | 字符串类型的值。 |

<a id="agora_dp_info_t"></a>
### agora_dp_info_t

```c
typedef struct agora_dp_info {
  unsigned int dp_id;
  agora_dp_type_e dp_type;
  agora_dp_value_t dp_value;
} agora_dp_info_t;
```

属性信息。

| 参数 | 描述 |
| --- | --- |
| `dp_id` | 属性 ID。即控制台**功能定义**页面的属性标识符。详见[开通声网灵隼](enable_agora_link)。 |
| `dp_type` | 属性的数据类型。详见 [agora_dp_type_e](#agora_dp_type_e)。 |
| `dp_value` | 属性的值。详见 [agora_dp_value_t](#agora_dp_value_t)。 |


<a id="on_dp_query_callback"></a>
### on_dp_query_callback

```c
typedef void (*on_dp_query_callback)(agora_dp_info_t *info, void *args);
```

客户端 SDK 通过设备属性方法查询本地属性时触发。

#### 参数

| 参数 | 描述 |
| --- | --- |
| [in] `info` | 属性信息。详见 [agora_dp_info_t](#agora_dp_info_t)。你需要在此参数中传入本地属性的信息。 |
| [in] `args` | 回调参数。通过 [agora_iot_dp_register_dp_query_handler](#agora_iot_dp_register_dp_query_handler) 传入。 |

<a id="on_dp_cmd_callback"></a>
### on_dp_cmd_callback

```c
typedef void (*on_dp_cmd_callback)(const agora_dp_info_t *info, void *args);
```

接收到客户端 SDK 通过设备属性方法发送的命令时触发。


#### 参数

| 参数 | 描述 |
| --- | --- |
| [in] `info` | 属性信息。详见 [agora_dp_info_t](#agora_dp_info_t)。你可以在此参数中传入本地属性或远端属性的信息。 |
| [in] `args` | 回调参数。通过 [agora_iot_dp_register_dp_cmd_handler](#agora_iot_dp_register_dp_cmd_handler) 传入。 |

# agora_iot_file_player.h

## 引用文件

无

## 函数

### agora_iot_file_player_init

```c
int agora_iot_file_player_init(char *slave_server_url, const char *appid);
```

初始化文件播放器。

使用文件播放器前，你需要调用该方法初始化文件播放器。

#### 参数

| 参数                    | 描述                                                         |
| :---------------------- | :----------------------------------------------------------- |
| [in] `slave_server_url` | SDK 使用的 AWS OpenAPI 服务的主机域名。你可以在声网灵隼控制台的**应用配置>>开发者选项>>呼叫服务>>Slave Server URL** 处获取。详见[开通并配置声网灵隼服务](https://docs.agora.io/cn/iot-apaas/enable_agora_link)。 |
| [in] `appid`            | 你的声网 App ID。可以从声网灵隼控制台的**应用配置**页面的**开发者选项**选项卡中获取。详见[开通声网灵隼服务](https://docs.agora.io/cn/iot-apaas/enable_agora_link)。 |

#### 返回

- 0：方法调用成功。
- < 0：方法调用失败。

### agora_iot_file_player_deinit

```c
void agora_iot_file_player_deinit(void);
```

释放文件播放器的资源。

<a name="agora_iot_file_player_start"></a>
### agora_iot_file_player_start

```c
file_player_handle_t agora_iot_file_player_start(agora_iot_file_player_callback_t callback,
                                                 const char *channel_name);
```

创建本地回放频道。

如果多个用户需要同时查看不同的视频文件，你可以多次调用该方法创建多个本地回放频道。

如需销毁本地回放频道，调用 [agora_iot_file_player_stop](#agora_iot_file_player_stop) 方法。

#### 参数

| 参数                | 描述                                                        |
| :------------------ | :---------------------------------------------------------- |
| [in] `callback`     | 注册本地回放事件。详见 [agora_iot_file_player_callback_t](#agora_iot_file_player_callback_t)。 |
| [in] `channel_name` | 本地回放频道名称。                                          |

#### 返回

`file_player_handle_t`：文件播放器句柄。

<a name="agora_iot_file_player_stop"></a>
### agora_iot_file_player_stop

```c
int agora_iot_file_player_stop(file_player_handle_t handle);
```

销毁本地回放频道。

成功销毁本地回放频道时，SDK 会触发 [cb_stop_push_frame](#cb_stop_push_frame) 回调。

#### 参数

| 参数          | 描述                                                         |
| :------------ | :----------------------------------------------------------- |
| [in] `handle` | 文件播放器句柄。你可以通过 [agora_iot_file_player_start](#agora_iot_file_player_start) 获取。|

#### 返回

- 0：方法调用成功。
- < 0：方法调用失败。

### agora_iot_file_player_push_video_frame

```c
int agora_iot_file_player_push_video_frame(file_player_handle_t handle, agora_iot_file_video_t *frame);
```

发送视频帧到本地回放频道。

当 SDK 触发 [cb_start_push_frame](#cb_start_push_frame) 回调时，你可以调用该方法把视频帧发送到本地回放频道。

<div class="alert note">相邻两个视频帧的发送间隔需等于帧率，否则视频帧的播放速度会受发送频率影响。</div>

#### 参数

| 参数          | 描述                                                         |
| :------------ | :----------------------------------------------------------- |
| [in] `handle` | 文件播放器句柄。你可以通过 [agora_iot_file_player_start](#agora_iot_file_player_start) 获取。 |
| [in] `frame`  | 待发送的视频帧信息，详见 [agora_iot_file_video_t](#agora_iot_file_video_t)。          |

#### 返回

- 0：方法调用成功。
- < 0：方法调用失败。

### agora_iot_file_player_push_audio_frame

```c
int agora_iot_file_player_push_audio_frame(file_player_handle_t handle, agora_iot_file_audio_t *frame);
```

发送音频帧到本地回放频道。

当 SDK 触发 [cb_start_push_frame](#cb_start_push_frame) 回调时，你可以调用该方法把音频帧发送到本地回放频道。

<div class="alert note">仅支持发送单声道、采样率 16000 Hz、大小为 16 bit 的 PCM 数据，数据发送间隔为 20 ms。</div>

#### 参数

| 参数          | 描述                                                         |
| :------------ | :----------------------------------------------------------- |
| [in] `handle` | 文件播放器句柄。你可以通过 [agora_iot_file_player_start](#agora_iot_file_player_start) 获取。 |
| [in] `frame`  | 待发送的音频帧信息，详见 [agora_iot_file_audio_t](#agora_iot_file_audio_t)。          |

#### 返回

- 0：方法调用成功。
- < 0：方法调用失败。

## 类型定义

<a name="agora_iot_file_player_callback_t"></a>
### agora_iot_file_player_callback_t

```c
typedef struct agora_iot_file_player_callback
{
  void (*cb_start_push_frame)(void);
  void (*cb_stop_push_frame)(void);
} agora_iot_file_player_callback_t;
```

本地回放相关回调。

<a name="cb_start_push_frame"></a>
#### cb_start_push_frame

调用 [agora_iot_file_player_start](#agora_iot_file_player_start) 成功创建本地回放频道时，SDK 会触发该回调。此时，你可以调用 [agora_iot_file_player_push_audio_frame](#agora_iot_file_player_push_audio_frame) 或 [agora_iot_file_player_push_video_frame](#agora_iot_file_player_push_video_frame) 方法发送音频或视频数据到本地回放频道。

<a name="cb_stop_push_frame"></a>
#### cb_stop_push_frame

调用 [agora_iot_file_player_stop](#agora_iot_file_player_stop) 成功销毁本地回放频道时，SDK 会触发该回调。此时，你需要停止调用 [agora_iot_file_player_push_audio_frame](#agora_iot_file_player_push_audio_frame) 或 [agora_iot_file_player_push_video_frame](#agora_iot_file_player_push_video_frame) 方法。

<a name="agora_iot_file_video_e"></a>
### agora_iot_file_video_e

```c
typedef enum {
  FILE_VIDEO_H264 = 0,
  FILE_VIDEO_JPEG,
} agora_iot_file_video_e;
```

视频帧的编码格式。

| 参数              | 描述                                                  |
| :---------------- | :---------------------------------------------------- |
| `FILE_VIDEO_H264`      | 0：H.264                                        |
| `FILE_VIDEO_JPEG`  | JPEG                                          |

<a name="agora_iot_file_video_t"></a>
### agora_iot_file_video_t

```c
typedef struct {
  uint8_t  *frame;
  size_t   frame_len;
  uint32_t codec;
  bool     keyframe;
  uint32_t frame_rate;
} agora_iot_file_video_t;
```

待发送的视频帧信息。

| 参数              | 描述                                                  |
| :---------------- | :---------------------------------------------------- |
| [in] `frame`      | 视频帧数据。                                          |
| [in] `frame_len`  | 视频帧长度。                                          |
| [in] `codec`      | 视频帧的编码格式，详见 [agora_iot_file_video_e](#agora_iot_file_video_e)。     |
| [in] `keyframe`   | 是否为关键帧：<li>`true`：是关键帧。</li><li>`false`：不是关键帧。</li> |
| [in] `frame_rate` | 帧率（fps）。                                         |

<a name="agora_iot_file_audio_t"></a>
### agora_iot_file_audio_t

```c
typedef struct {
  uint8_t  *frame;
  size_t   frame_len;
} agora_iot_file_audio_t;
```

待发送的音频帧信息。

<div class="alert note">仅支持推送单声道、采样率 16000 Hz、大小为 16 bit 的 PCM 数据，数据发送间隔为 20 ms。</div>

| 参数             | 描述                                  |
| :--------------- | :------------------------------------ |
| [in] `frame`     | 音频帧数据。                          |
| [in] `frame_len` | 音频帧长度（Byte）。仅支持 640 Byte。 |