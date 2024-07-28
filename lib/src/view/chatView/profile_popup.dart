import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tito_app/core/constants/style.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePopup extends StatefulWidget {
  @override
  _ProfilePopupState createState() => _ProfilePopupState();
}

class _ProfilePopupState extends State<ProfilePopup> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<String> _items = [];   //아이템 리스트

  @override
  void initState() {
    super.initState();
    _addItems();
  }

  void _addItems() {
    for (int i = 0; i < 4; i++) {
      _items.add('Item $i');
      _listKey.currentState?.insertItem(_items.length - 1);   //애니메이션과 함께 아이템 삽입 
    }
  }

  Widget _buildItem(String item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: ListTile(
        title: Text('아싸 애인 vs 인싸 애인'),
        subtitle: Text('의견: 아싸 애인이 더 좋다'),
        trailing: Text('결과: 승', style: TextStyle(color: ColorSystem.purple)),
      ),
    );
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
            ),
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('프로필', style: FontSystem.KR14B),
                    Icon(Icons.close),
                  ],
                ),
                SizedBox(height: 42.h),
                const Row(
                  children: [
                    
                    sizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('포키', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('승률 80%', style: TextStyle(fontSize: 16, color: Colors.purple)),
                        SizedBox(height: 4),
                        Text('12전 | 10승 | 2패', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text('참여한 토론', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Expanded(
                  child: AnimatedList(
                    key: _listKey,
                    initialItemCount: _items.length,
                    itemBuilder: (context, index, animation) {
                      return _buildItem(_items[index], animation);
                    },
                  ),
                ),
              ],
            ),
          ),
        
      ),
    );
  }
}