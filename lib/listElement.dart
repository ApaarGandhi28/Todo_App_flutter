import 'package:TODO/editTask.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './models/info.dart';
import './todopage.dart';
import './main.dart';
import 'dart:math';

class ListElement extends StatefulWidget {
  final Info user;
  final Function ff;
  final Function dd;
  ListElement(this.user, this.ff, this.dd);

  @override
  _ListElementState createState() => _ListElementState();
}

class _ListElementState extends State<ListElement> {
  List<Color> colorsLight = [
    Colors.red[100],
    Colors.deepOrange[200],
    Colors.purple[200],
    Colors.green[200],
    Colors.yellow[300],
  ];

  List<Color> colorsDark = [
    Colors.blueGrey[700],
    Colors.brown[700],
    Colors.purple[700],
    Colors.teal[700],
    Colors.indigo[700],
  ];

  MaterialColor getColor<MaterialColor>(List<MaterialColor> list) {
    final random = new Random();
    var i = random.nextInt(list.length);
    return list[i];
  }

  Widget _simplePopup(Function f1) => PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: FlatButton.icon(
              icon: Icon(Icons.edit),
              label: Text('Edit'),
              onPressed: f1,
            ),
          ),
          PopupMenuDivider(
            height: 0.25,
          ),
          PopupMenuItem(
            value: 2,
            child: FlatButton.icon(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              label: Text('Delete'),
              onPressed: () => {
                widget.dd(widget.user.id)
               },
            ),
          ),
        ],
      );

  void editButton(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: EditTask(
              widget.user,
              widget.ff,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.user.id),
      background: Container(
        color: Colors.green[600],
        child: Row(children: [
          Icon(
            Icons.check,
            color: Colors.white,
            size: 40,
          ),
          Container(
              child: Text(
            'MARK AS COMPLETED',
            style: TextStyle(
              fontFamily: 'Voltaire',
              color: Colors.white,
              fontSize: 24,
            ),
          )),
        ]),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(
          right: 20,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you Sure?'),
            content: Text(
              'Do you want to Mark the Task As COMPLETED ?', style: TextStyle(fontFamily: 'Voltaire',),
            ),
            actions: [
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        widget.dd(widget.user.id);
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: getColor(colorsLight),
          border: Border.all(
            color: getColor(colorsDark),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Card(
          margin: EdgeInsets.symmetric(
            vertical: 5,
          ),
          color: Colors.white,
          elevation: 5,
          child: ListTile(
            title: Text(
              '${DateFormat.yMMMMd().format(widget.user.date)}   ${widget.user.time.format(context)}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            subtitle: Text(
              widget.user.title,
              style: Theme.of(context).textTheme.headline6,
            ),
            trailing: _simplePopup(() => editButton(context)),
          ),
        ),
      ),
    );
  }
}
