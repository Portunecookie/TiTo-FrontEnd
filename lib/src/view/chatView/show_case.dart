import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:tito_app/core/constants/style.dart';
import 'package:tito_app/src/view/chatView/chat_view_details.dart';
import 'package:tito_app/src/view/chatView/votingbar.dart';

int currentShowcaseIndex = 0;

class ShowCase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      onFinish: () {
        context.pop();
      },
      onComplete: (index, key) {
        currentShowcaseIndex++;
        print(currentShowcaseIndex);
      },
      builder: (context) => ShowCaseScreen(),
    );
  }
}

class ShowCaseScreen extends StatefulWidget {
  @override
  _ShowCaseScreenState createState() => _ShowCaseScreenState();
}

class _ShowCaseScreenState extends State<ShowCaseScreen> {
  final GlobalKey _keyTimer = GlobalKey();
  final GlobalKey _keySuggestion = GlobalKey();
  final GlobalKey _keyMessage = GlobalKey();
  final GlobalKey _keyShowCase = GlobalKey();

  @override
  void initState() {
    currentShowcaseIndex = 0;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Future.delayed(Duration(seconds: 0), () {
          ShowCaseWidget.of(context).startShowCase(
              [_keyTimer, _keyMessage, _keySuggestion, _keyShowCase]);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('외계인 있다? 없다?', style: TextStyle(color: Colors.black)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 1.0,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: ColorSystem.grey3,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 5),
              color: ColorSystem.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/detailChatIcon.svg',
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '포키님의 반론타임이에요!',
                            style: FontSystem.KR16R,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Showcase(
                            key: _keyTimer,
                            description: '⏳발언 제안 시간이 카운팅 돼요!',
                            tooltipBackgroundColor: ColorSystem.purple,
                            targetPadding: EdgeInsets.all(10),
                            targetBorderRadius: BorderRadius.circular(12),
                            tooltipPadding: EdgeInsets.all(10),
                            tooltipBorderRadius: BorderRadius.circular(12),
                            textColor: Colors.white,
                            child: Text(
                              '⏳ 7:20 토론 시작 전',
                              style: FontSystem.KR16B
                                  .copyWith(color: ColorSystem.purple),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Showcase(
                    key: _keyShowCase,
                    description: '3턴이 지난 후부터 실시간 투표율이 보여요!',
                    tooltipBackgroundColor: ColorSystem.purple,
                    targetPadding: EdgeInsets.all(10),
                    targetBorderRadius: BorderRadius.circular(12),
                    tooltipBorderRadius: BorderRadius.circular(12),
                    textColor: Colors.white,
                    child: VotingBar(),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: ColorSystem.grey3,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    constraints:
                                        const BoxConstraints(maxWidth: 250),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 16.0),
                                    decoration: BoxDecoration(
                                      color: ColorSystem.white,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Text(
                                        '이 넓은 우주에 우리가 유일한 생명체일 리가 없다고 생각해요. 은하만 해도 수백억 개가 있는데 그중에 지구 같은 조건을 가진 행성이 없을까요?',
                                        style: FontSystem.KR14R),
                                  ),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text(
                                      '10:00pm',
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.black54),
                                    ),
                                  ),
                                ],
                              ),
                              const CircleAvatar(child: Icon(Icons.person)),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const CircleAvatar(child: Icon(Icons.person)),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 250),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16.0),
                                  decoration: BoxDecoration(
                                    color: ColorSystem.white,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Text(
                                    '외계인이 있다면 왜 우리랑 접촉을 안 하겠어요? 파미의 역설이라는게 있잖아요 그동안 아무런 접촉이 없었다는 건 애초에 없다는 증거 아닌가요?',
                                    style: FontSystem.KR14R,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Text(
                                    '10:00pm',
                                    style: FontSystem.KR12R
                                        .copyWith(color: ColorSystem.grey),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: ColorSystem.grey3,
              ),
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4, right: 16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorSystem.black,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {},
                  child: Showcase(
                    key: _keySuggestion,
                    description: '토론을 마무리하고 싶을 때 타이밍벨을 눌러주세요! 거절시 2턴 후 종료됩니다!',
                    tooltipBackgroundColor: ColorSystem.purple,
                    targetBorderRadius: BorderRadius.circular(12),
                    tooltipPadding: EdgeInsets.all(10),
                    tooltipBorderRadius: BorderRadius.circular(12),
                    textColor: Colors.white,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/timingBell.svg',
                          width: 20, // 아이콘 크기 조정
                          height: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '타이밍 벨',
                          style: FontSystem.KR16B
                              .copyWith(color: ColorSystem.yellow),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Showcase(
              key: _keyMessage,
              description: 'AI의 도움을 받아 나의 의견을 완성시켜보세요!',
              tooltipBackgroundColor: ColorSystem.purple,
              targetBorderRadius: BorderRadius.circular(12),
              tooltipPadding: EdgeInsets.all(10),
              tooltipBorderRadius: BorderRadius.circular(12),
              textColor: Colors.white,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      color: ColorSystem.white,
                    ),
                    child: currentShowcaseIndex < 8
                        ? Container(
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset('assets/icons/blackLLM.svg'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    constraints:
                                        const BoxConstraints(maxWidth: 250),
                                    decoration: BoxDecoration(
                                      color: ColorSystem.white,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'LLM의 작성 코칭!',
                                          style: FontSystem.KR14M.copyWith(
                                              color: ColorSystem.purple),
                                        ),
                                        Text(
                                          '지금 작성하신 주장은 주제에서 벗어난 것 같아요. 파미의 역설에 대한 반박글을 한문장으로 작성하는 것을 추천해요!',
                                          style: FontSystem.KR14R.copyWith(
                                              color: ColorSystem.purple),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              child: Text('ds'),
                            ),
                          ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: ColorSystem.white,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset('assets/icons/plus.svg'),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: ColorSystem.grey3,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              '상대 의견 작성 타임이에요!',
                              style: FontSystem.KR14R
                                  .copyWith(color: ColorSystem.grey),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset('assets/icons/sendArrow.svg'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
