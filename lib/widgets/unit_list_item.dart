import 'dart:async';
import 'package:flutter/material.dart';

class UnitListItem extends StatefulWidget {
  UnitListItem({this.icon, this.title});

  final IconData icon;
  final String title;

  final TextStyle subTitle = TextStyle(fontSize: 25, color: Colors.white);

  @override
  _UnitListItemState createState() => _UnitListItemState();
}

class _UnitListItemState extends State<UnitListItem> {
  int likes = 0;
  int dislikes = 0;
  bool _show = false;
  Timer timer;

  @override
  void initState() {
    timer = Timer(Duration(milliseconds: 1000), () {
      setState(() {
        _show = true;
      });
    });
    super.initState();
  }

  handleDoubleTap() {
    handleLike(true);
  }

  handleLike(isLike) {
    if (isLike) {
      setState(() {
        this.likes += 1;
      });
    } else {
      setState(() {
        this.dislikes += 1;
      });
    }
  }

  final iconPadding = EdgeInsets.all(20);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedOpacity(
        opacity: _show ? 1 : 0,
        duration: Duration(milliseconds: 900),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.dstATop),
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1566665797739-1674de7a421a?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1267&q=80'),
                fit: BoxFit.cover),
            color: Colors.black54,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            // boxShadow: ,
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: GestureDetector(
                    onDoubleTap: () => handleDoubleTap(),
                    child: Icon(widget.icon, color: Colors.black, size: 40)),
              ),
              Container(
                child: Text(
                  widget.title,
                  style: widget.subTitle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// child: AnimatedOpacity(
//         opacity: _show ? 1 : 0,
//         duration: Duration(microseconds: 900),

// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   crossAxisAlignment: CrossAxisAlignment.center,
//   children: [
//     Text(likes.toString()),
//     IconButton(
//       icon: Icon(Icons.thumb_up),
//       onPressed: () => handleLike(true),
//       padding: iconPadding,
//     ),
//     IconButton(
//       icon: Icon(Icons.thumb_down),
//       onPressed: () => handleLike(false),
//       padding: iconPadding,
//     ),
//     Text(dislikes.toString())
//   ],
// )
//   ],
// )),
// );
