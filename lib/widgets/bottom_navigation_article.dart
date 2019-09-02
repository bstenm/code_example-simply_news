import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class BottonNavigationArticle extends StatefulWidget {
  BottonNavigationArticle({
    Key key,
    @required this.badgeNb,
    @required this.showBadge,
    @required this.onTapListenIcon,
  }) : super(key: key);

  final int badgeNb;
  final bool showBadge;
  final Function onTapListenIcon;

  @override
  _BottonNavigationArticleState createState() =>
      _BottonNavigationArticleState();
}

class _BottonNavigationArticleState extends State<BottonNavigationArticle> {
  int selectedIndex = 0;

  void onTap(index) {
    if (index == 1) {
      widget.onTapListenIcon();
    }
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          title: Text('Article'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.volume_up),
          title: Text('Listen'),
        ),
        BottomNavigationBarItem(
          icon: Badge(
            showBadge: widget.showBadge,
            animationType: BadgeAnimationType.scale,
            badgeContent: Text(
              widget.badgeNb.toString(),
              style: TextStyle(color: Colors.white),
            ),
            badgeColor: Colors.purple,
            child: Icon(Icons.school),
          ),
          title: Text('Vocabulary'),
        ),
      ],
      currentIndex: selectedIndex,
      fixedColor: Colors.black,
      onTap: onTap,
    );
  }
}
