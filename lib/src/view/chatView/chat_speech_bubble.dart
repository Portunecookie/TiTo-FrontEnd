import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tito_app/core/constants/style.dart';
import 'package:tito_app/core/provider/chat_state_provider.dart';
import 'package:tito_app/core/provider/login_provider.dart';
import 'package:speech_balloon/speech_balloon.dart';
import 'package:tito_app/core/provider/popup_provider.dart';
import 'package:tito_app/src/data/models/debate_info.dart';
import 'package:tito_app/src/data/models/popup_state.dart';

import 'package:tito_app/src/viewModel/popup_viewModel.dart';

class ChatSpeechBubble extends ConsumerStatefulWidget {
  const ChatSpeechBubble({
    super.key,
  });

  @override
  _ChatSpeechBubbleState createState() => _ChatSpeechBubbleState();
}

class _ChatSpeechBubbleState extends ConsumerState<ChatSpeechBubble> {
  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProviders);
    final loginInfo = ref.watch(loginInfoProvider);
    final popupViewModel = ref.read(popupProvider.notifier);
    final popupState = ref.read(popupProvider);

    if (chatState.debateData == null || loginInfo == null) {
      return const SizedBox.shrink();
    }

    final myNick = chatState.debateData?['myNick'];
    final opponentNick = chatState.debateData?['opponentNick'];
    final myTurn = chatState.debateData?['myTurn'];
    final opponentTurn = chatState.debateData?['opponentTurn'];
    final isMyNick = myNick == loginInfo.nickname;

    if (myNick == null ||
        opponentNick == null ||
        myTurn == null ||
        opponentTurn == null) {
      return const SizedBox.shrink();
    }

    String sendNick = isMyNick ? myNick : opponentNick;

    if (isMyNick) {
      switch (myTurn) {
        case 0:
          return StaticTextBubble(
            chatState: chatState,
            title: '첫 입론을 입력하세요',
            width: (MediaQuery.of(context).size.width - 100) * 0.7,
            height: (MediaQuery.of(context).size.height - 450) * 0.2,
          );

        default:
          if (opponentTurn == 0) {
            SizedBox(
              width: 0,
            );
          }
          if (opponentTurn >= 3) {
            return TimingButton(
              sendNick: sendNick,
              popupViewModel: popupViewModel,
              popupState: popupState,
            );
          }
          break; // Added break to handle cases where opponentTurn < 1
      }
    } else {
      switch (opponentTurn) {
        case 0:
          return StaticTextBubble(
            chatState: chatState,
            title: '토론 참여자를 기다리고 있어요!\n의견을 작성해보세요',
            width: (MediaQuery.of(context).size.width - 100) * 0.8,
            height: (MediaQuery.of(context).size.height - 450) * 0.3,
          );

        default:
          if (opponentTurn >= 3) {
            return TimingButton(
              sendNick: sendNick,
              popupViewModel: popupViewModel,
              popupState: popupState,
            );
          }
          break; // Added break to handle cases where opponentTurn < 3
      }
    }

    // Return a default widget if no conditions are met
    return const SizedBox.shrink();
  }
}

class StaticTextBubble extends StatefulWidget {
  final String title;
  final double width;
  final double height;
  final ChatState chatState;

  const StaticTextBubble({
    super.key,
    required this.title,
    required this.width,
    required this.height,
    required this.chatState,
  });

  @override
  _StaticTextBubbleState createState() => _StaticTextBubbleState();
}

class _StaticTextBubbleState extends State<StaticTextBubble> {
  @override
  Widget build(BuildContext context) {
    if (!mounted || widget.chatState.isVisible == false) {
      return const SizedBox.shrink(); // 빈 공간 반환
    }

    return SpeechBalloon(
      width: widget.width,
      height: widget.height,
      borderRadius: 12,
      nipLocation: NipLocation.bottom,
      color: ColorSystem.purple,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: FontSystem.KR16B.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class TimingButton extends StatelessWidget {
  final PopupViewmodel popupViewModel;
  final PopupState popupState;
  final String sendNick;

  const TimingButton({
    super.key,
    required this.popupViewModel,
    required this.popupState,
    required this.sendNick,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorSystem.black,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () {
            popupState.opponentNick = sendNick;
            popupViewModel.showTimingPopup(context);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/timingBell.png',
                width: 20, // 아이콘 크기 조정
                height: 20,
              ),
              const SizedBox(width: 4),
              Text(
                '타이밍 벨',
                style: FontSystem.KR16B.copyWith(color: ColorSystem.yellow),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
