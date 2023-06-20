## 已知问题

SDK 在 1.5.0 版本中重构了呼叫业务，对 SDK 版本之间的互通有以下影响：
- 1.5.0 版本仅与 1.5.0 及以上版本互通。
- 1.3.0 版本仅与 1.3.0 及以下版本互通。

## 1.5.0 版

该版本于 2023 年 6 月 26 日发布。

#### 升级必看

为提高弱网环境下呼叫出图成功率、缩短呼叫出图响应时间，该版本重构了呼叫业务，重构后的 SDK 无法与之前版本的 SDK 互通。如需将 SDK 升级至 1.5.0 版，请确保所有的设备端和客户端都进行升级。

#### 新增特性

**H.265 视频格式（C）**

该版本支持在设备端推送 H.265 格式的视频到云存储，你可以在调用 `agora_iot_cloud_record_start` 方法时设置 `video_type` 为 `AGO_VIDEO_DATA_TYPE_H265`。

**音频流发布状态（C）**

该版本在设备端的 `agora_iot_rtc_callback` 中新增 `cb_audio_muted_changed` 回调，报告通话中的客户端是否在发布音频流。你可以通过该回调处理你的业务逻辑，例如，如果设备端和多个客户端在一个频道中，设备端和客户端 A 在通话，那么客户端 A 停止发布音频流时，你可以添加业务逻辑让设备端和正在发布音频流的客户端 B 通话。

**注册来电通知（iOS）**

该版本在 register 方法中新增 memberState 参数

#### 改进

**云存储（C）**

为提升云存储的易用性，该版本在设备端改进了以下内容：
- 在 `agora_iot_cloud_record_start` 方法中删除 `record_id` 和 `end_time` 参数，并在 SDK 内部添加了对应状态参数的处理逻辑，你不再需要自行处理。
- 在 `ago_video_frame_t` 中增加 `fps` 参数。你可以通过该参数实现视频预录制，从而缩短生成录制视频的时间。

**24 小时连续通话（C）**

该版本将单个视频通话的最大时长由 1 小时升级至 24 小时，超过上限后 SDK 会自动结束通话。

**本地回放（C）**

该版本扩展了本地回放的以下能力：
- 为支持同一设备的多个客户端同时观看不同的视频回放文件，该版本在设备端 `agora_iot_file_player_callback` 类的 `cb_start_push_frame` 和 `cb_stop_push_frame` 回调中新增 `channel_name` 参数。
- 为支持发送多种格式的音视频帧到本地回放频道，该版本删除了 `agora_iot_file_video_t`、`agora_iot_file_audio_t` 和 `agora_iot_file_video_e` 数据类型，并将 `agora_iot_file_player_push_video_frame` 和 `agora_iot_file_player_push_audio_frame` 方法的 `frame` 参数分别改为 `ago_video_frame_t` 和 `ago_audio_frame_t` 类型。

**最小带宽探测（C）**

该版本在 `agora_iot_config_t` 中新增 `min_possible_bitrate` 参数，你可以设置带宽探测的最小码率。// TODO 这里的设置和 cb_target_bitrate_changed 有什么关系？

**DP 属性点（C）**

该版本支持使用数组指针赋值 string 类型的 DP 属性点，你可以通过 `agora_dp_value_t` 的 `dp_str` 参数实现。同时，SDK 将不再自动释放 `dp_str` 参数的内存，你需要手动管理内存以避免内存泄露。

## 1.3.0 版

该版本于 2023 年 2 月  16 日发布，新增了对云存储视频文件的加密。你可以下载[灵隼 Demo](https://docs.agora.io/cn/iot-apaas/downloads?platform=All%20Platforms) 进行体验。

## 1.2.0 版

该版本于 2022 年 11 月  23 日发布，主要新增如下功能：

- 推送和查询告警消息、图片、视频。详见[告警服务](./agora_link_alram/)。
- 通过云存储服务录制告警视频。详见[云存储服务](./agora_link_cloud_storage/)。

## 1.1.0 版

该版本于 2022 年 9 月  19 日发布，主要新增如下功能：

- [通过 OTA 升级设备端固件](./agora_link_ota/)。
- [使用 RESTful API 对接第三方用户账号](./agora_link_restful_api?platform=All%20Platforms#对接自研或第三方账户系统)。

## 1.0.0 版

该版本于 2022 年 6 月  27 日发布。

该版本是声网灵隼物联网云平台（简称声网灵隼）的第一个版本，主要为音视频设备一站式上云和自主智能化开发提供连接管理、设备管理、上下行链路以及基于声网的实时音视频的呼叫管理能力。