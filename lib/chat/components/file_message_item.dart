
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

import '../../styles/color.dart';
import '../channel_view_model.dart';
import 'message_item.dart';

class FileMessageItem extends MessageItem {
  FileMessageItem({
    required FileMessage curr,
    BaseMessage? prev,
    BaseMessage? next,
    required ChannelViewModel model,
    required bool isMyMessage,
    Function(Offset)? onPress,
    Function(Offset)? onLongPress,
  }) : super(
    curr: curr,
    prev: prev,
    next: next,
    model: model,
    isMyMessage: isMyMessage,
    onPress: onPress,
    onLongPress: onLongPress,
  );

  @override
  Widget get content => ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: ((curr as FileMessage).localFile != null && kIsWeb == false)
        ? Container(
      child: FittedBox(
        child: Image.file((curr as FileMessage).localFile!),
        fit: BoxFit.cover,
      ),
      height: 160,
      width: 240,
    )
        : CachedNetworkImage(
      height: 160,
      width: 240,
      fit: BoxFit.cover,
      imageUrl: (curr as FileMessage).secureUrl ??
          (curr as FileMessage).url,
      placeholder: (context, url) => Container(
        color: SBColors.primary_300,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        width: 30,
        height: 30,
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    ),
  );
}