import 'package:flutter/material.dart';

import 'model/data.dart';

class TileWidegetStore extends StatefulWidget {
  final User userEmp;
  final Function changeValue;

  TileWidegetStore(this.userEmp, this.changeValue);

  @override
  _TileWidegetStoreState createState() => _TileWidegetStoreState();
}

class _TileWidegetStoreState extends State<TileWidegetStore> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.only(left:25.0),
                  alignment: Alignment.centerLeft,
                  child: Text('${widget.userEmp.getEmpName()}',style: TextStyle(fontSize: 16,color: Colors.black54),)),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/editEmp',
                          arguments: widget.userEmp)
                      .then((value) {
                    setState(() {
                      widget.changeValue();
                    });
                  });
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  widget.userEmp.removeEmp(widget.userEmp.index);
                  setState(() {
                    widget.changeValue();
                  });

                },
              ),
            )
          ]),
    );
  }
}
