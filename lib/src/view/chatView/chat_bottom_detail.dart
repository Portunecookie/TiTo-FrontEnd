import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tito_app/core/provider/chat_view_provider.dart';
import 'package:tito_app/core/provider/login_provider.dart';
import 'package:tito_app/core/provider/popup_provider.dart';
import 'package:tito_app/core/provider/timer_provider.dart';

class ChatBottomDetail extends ConsumerStatefulWidget {
  final int id;
  const ChatBottomDetail({super.key, required this.id});

  @override
  ConsumerState<ChatBottomDetail> createState() => _ChatBottomDetailState();
}

class _ChatBottomDetailState extends ConsumerState<ChatBottomDetail> {
  void handleSendMessage(context) async {
    final loginInfo = ref.read(loginInfoProvider);
    final chatViewModel = ref.read(chatInfoProvider.notifier);
    final chatState = ref.read(chatInfoProvider);
    final popupViewModel = ref.read(popupProvider.notifier);
    final popupState = ref.read(popupProvider);
    print(chatState!.debateJoinerId);
    if (loginInfo == null) {
      return;
    }

    if (chatState.debateJoinerId == 0 &&
        chatState.debateJoinerTurnCount == 0 &&
        chatState.debateOwnerId != loginInfo.id) {
      popupState.buttonStyle = 1;
      popupState.title = '토론에 참여 하시겠어요?';
      popupState.imgSrc = 'assets/images/chatIconRight.svg';
      popupState.buttonContentLeft = '토론 참여하기';
      popupState.content = '작성하신 의견을 전송하면\n토론 개설자에게 보여지고\n토론이 본격적으로 시작돼요!';
      await popupViewModel.showDebatePopup(context);
      chatViewModel.sendJoinMessage(context);
    } else if (chatState.debateJoinerId == loginInfo.id ||
        chatState.debateOwnerId == loginInfo.id) {
      chatViewModel.sendMessage();
    } else {
      chatViewModel.sendChatMessage();
    }

    if (popupState.title == '토론이 시작 됐어요! 🎵') {
      if (mounted) {
        ref.read(timerProvider.notifier).resetTimer();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatViewModel = ref.read(chatInfoProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/plus.svg'),
              ),
              Expanded(
                child: TextField(
                  controller: chatViewModel.controller,
                  autocorrect: false,
                  focusNode: chatViewModel.focusNode,
                  decoration: InputDecoration(
                    hintText: '상대 의견 작성 타임이에요!',
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSubmitted: (value) {
                    handleSendMessage(context);
                  },
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  handleSendMessage(context);
                },
                icon: SvgPicture.asset('assets/icons/sendArrow.svg'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
