import 'package:flutter/material.dart';
import 'package:super_apps/style//theme.dart' as Theme;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:super_tooltip/super_tooltip.dart';

class ReportPage extends StatefulWidget {
  //static const String routeName = '/material/tooltips';

  _ReportPageState createState() => new _ReportPageState();
}

class _ReportPageState extends State<ReportPage>{
  SuperTooltip tooltip;

  GlobalKey _containerKey = GlobalKey();

  List _keterangan = ["Mobile", "Finger", "Web", "Izin"];
  
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedKeterangan;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _selectedKeterangan = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String keterangan in _keterangan) {
      items.add(new DropdownMenuItem(
          value: keterangan,
          child: new Text(keterangan)
      ));
    }
    return items;
  }

  void onTap() {
    if (tooltip != null && tooltip.isOpen) {
      tooltip.close();
      return;
    }

    // We create the tooltip on the first use
    tooltip = SuperTooltip(
      popupDirection: TooltipDirection.down,
      arrowTipDistance: 10.0,
      content: new Material(
          child: Row(
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(" Keterangan Absen:"),
                    ),
                    Row(
                      children: <Widget>[
                          Container(
                            child:ClipOval(
                                child: Container(
                                  color: Colors.grey,
                                  height: 25.0, // height of the button
                                  width: 25.0, // width of the button
                                  child: Center(
                                        child: Text('M',
                                          style: TextStyle(color: Colors.white)
                                        )
                                  ),
                                ),
                              ),
                          ),
                          Container(
                            child: Text(" : Mobile")
                          ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            child: ClipOval(
                              child: Container(
                                color: Colors.greenAccent,
                                height: 25.0, // height of the button
                                width: 25.0, // width of the button
                                child: Center(
                                    child: Text('F', style: TextStyle(
                                      color: Colors.white
                                    ))
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(" : Fingerprint")
                          ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            child: ClipOval(
                              child: Container(
                                color: Colors.lightBlueAccent,
                                height: 25.0, // height of the button
                                width: 25.0, // width of the button
                                child: Center(
                                    child: Text('W', style: TextStyle(
                                      color: Colors.white
                                    ))
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(" : Web Absen")
                          ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            child: ClipOval(
                              child: Container(
                                color: Colors.green,
                                height: 25.0, // height of the button
                                width: 25.0, // width of the button
                                child: Center(
                                    child: Text('D', style: TextStyle(
                                      color: Colors.white
                                    ))
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(" : SPPD")
                          ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            child: ClipOval(
                              child: Container(
                                color: Colors.deepPurple,
                                height: 25.0, // height of the button
                                width: 25.0, // width of the button
                                child: Center(
                                    child: Text('S', style: TextStyle(
                                      color: Colors.white
                                    ))
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(" : Sakit")
                          ),
                      ],
                    ),
                ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                      Row(
                        children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top:15),
                              child: ClipOval(
                                  child: Container(
                                    color: Colors.deepOrangeAccent,
                                    height: 25.0, // height of the button
                                    width: 25.0, // width of the button
                                    child: Center(
                                        child: Text('C', style: TextStyle(
                                          color: Colors.white
                                        ))
                                    ),
                                  ),
                                ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top:10),
                              child: Text(" : Cuti")
                            ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              child: ClipOval(
                                  child: Container(
                                    color: Colors.purpleAccent,
                                    height: 25.0, // height of the button
                                    width: 25.0, // width of the button
                                    child: Center(
                                        child: Text('I', style: TextStyle(
                                          color: Colors.white
                                        ))
                                    ),
                                  ),
                                ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(" : Izin")
                            ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              child: ClipOval(
                                child: Container(
                                  color: Colors.indigo,
                                  height: 25.0, // height of the button
                                  width: 25.0, // width of the button
                                  child: Center(
                                      child: Text('T', style: TextStyle(
                                        color: Colors.white
                                      ))
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(" : Pengganti Hari Libur")
                            ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              child: ClipOval(
                                child: Container(
                                  color: Colors.pinkAccent,
                                  height: 25.0, // height of the button
                                  width: 25.0, // width of the button
                                  child: Center(
                                      child: Text('G', style: TextStyle(
                                        color: Colors.white
                                      ))
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(" : Penugasan Diluar")
                            ),
                        ],
                      ),
                  ],
                ),
              ],
          ),
      )
    );

    tooltip.show(_containerKey.currentContext);
  }

  final text = new Text('Text here', style: new TextStyle(fontSize: 50.0),);

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;

    return new Scaffold(
      //backgroundColor: Colors.redAccent,
      backgroundColor: Theme.Colors.backgroundAbsen,
      appBar: new AppBar(
        title: Text("widget.title"),
      ),
      body: new SafeArea(
          child: new Column(
            children: [
              new Expanded(
                flex: 2,
                child: new Container(
                  padding: EdgeInsets.only(right: 10.0, left: 10.0),
                  color: Theme.Colors.backgroundAbsen,// variable
                  child: new Column(
                    children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom:15),
                            alignment: Alignment.centerLeft,
                            child: Text(
                                        'Tanggal',
                                        style: TextStyle(
                                              color: Colors.white,
                                        ),
                                    ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: width/2.3,
                                child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        color: Colors.white,
                                        onPressed: () {
                                            DatePicker.showDatePicker(context,
                                                                  showTitleActions: true,
                                                                  minTime: DateTime(2018, 3, 5),
                                                                  maxTime: DateTime(2019), 
                                                                  onChanged: (date) {
                                                                                      print('change $date');
                                                                  }, 
                                                                  onConfirm: (date) {
                                                                                      print('confirm $date');
                                                                  }, 
                                                                  currentTime: DateTime.now(), locale: LocaleType.en);
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Text("2019/08/19", textAlign: TextAlign.center,),
                                            Flexible(fit: FlexFit.tight, child: SizedBox()),
                                            Icon(Icons.date_range),
                                          ],
                                        ),
                                      ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                width: width/2.3,
                                child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        color: Colors.white,
                                        onPressed: () {
                                            DatePicker.showDatePicker(context,
                                                                  showTitleActions: true,
                                                                  minTime: DateTime(2018, 3, 5),
                                                                  maxTime: DateTime(2019), 
                                                                  onChanged: (date) {
                                                                                      print('change $date');
                                                                  }, 
                                                                  onConfirm: (date) {
                                                                                      print('confirm $date');
                                                                  }, 
                                                                  currentTime: DateTime.now(), locale: LocaleType.en);
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Text("2019/08/19", textAlign: TextAlign.center,),
                                            Flexible(fit: FlexFit.tight, child: SizedBox()),
                                            Icon(Icons.date_range),
                                          ],
                                        ),
                                      ), 
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom:15),
                            alignment: Alignment.centerLeft,
                            child: Text('Keterangan',
                                        style: TextStyle(
                                              color: Colors.white,
                                        ),
                                      ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(left:15, right: 15),
                            decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(width: 1.0, style: BorderStyle.solid),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      color: Colors.white,
                                    ),
                            child: DropdownButton(
                                    value: _selectedKeterangan,
                                    items: _dropDownMenuItems,
                                    onChanged: changedDropDownItem,
                            ),
                          ),
                          Container(
                              alignment: Alignment.centerRight,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(top:25),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () async {
                                  // makePostRequest();
                                },
                                child: Text("Filter"),
                                color: Theme.Colors.bacgroundButton,
                                textColor: Theme.Colors.colorTextWhite,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              new Expanded(
                flex: 3,
                child: new Container(
                  width: width, // this will give you flexible width not fixed widt
                  color: Colors.white,//variable
                  child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(
                              child: StickyHeader(
                                header:
                                new Container(
                                  height: 50.0,
                                  color: Colors.lightBlueAccent,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                      children: <Widget>[
                                        new Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.only(left:15),
                                                  child: new Text("No",style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15
                                                  ))
                                                )
                                              ),
                                        new Expanded(child: new Text("Tanggal",style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15
                                              ))),
                                        new Expanded(child: new Text("Jam Masuk",style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15
                                              ))),
                                        new Expanded(
                                                child: Container(
                                                    padding: EdgeInsets.only(left:10),
                                                    child: new Text("Jam Pulang",style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15
                                                    ))
                                                ),
                                              ),
                                        new Expanded(
                                            child: Container(
                                                child: GestureDetector(
                                                  onTap: onTap,
                                                  child: Container(
                                                      key: _containerKey,
                                                      padding: EdgeInsets.only(left:30),
                                                      child: new Text("Ket",style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15
                                                      )
                                                  ),
                                                ),
                                              )
                                            ),
                                        ),
                                      ]
                                  ),
                                ),
                                content: new Container(
                                  child: Table(
                                     children: [
                                          TableRow(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(left:16),
                                                child: Text("1"),
                                              ),
                                              Text("2019-07-03"),
                                              Container(
                                                padding: EdgeInsets.only(left:10),
                                                child: Text("08:22:24"),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(left:18),
                                                child:  Text("05:22:24"),
                                              ),
                                              Center(
                                                  child: Container(
                                                      padding: EdgeInsets.only(bottom: 5),
                                                      child: GestureDetector(
                                                      child: ClipOval(
                                                        child: Container(
                                                          color: Colors.grey,
                                                          height: 25.0, // height of the button
                                                          width: 25.0, // width of the button
                                                          child: Center(child: Text('M',
                                                                style: TextStyle(color: Colors.white)
                                                          )),
                                                        ),
                                                      ),
                                                    )
                                                  ),
                                              )
                                            ]
                                          ),
                                          TableRow(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(left:16),
                                                child: Text("2"),
                                              ),
                                              Text("2019-07-03"),
                                              Container(
                                                padding: EdgeInsets.only(left:10),
                                                child: Text("08:22:24"),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(left:18),
                                                child:  Text("05:22:24"),
                                              ),
                                              Center(
                                                  child: GestureDetector(
                                                    onTap: onTap,
                                                    child: ClipOval(
                                                      child: Container(
                                                        color: Colors.greenAccent,
                                                        height: 25.0, // height of the button
                                                        width: 25.0, // width of the button
                                                        child: Center(
                                                            child: Text('F', style: TextStyle(
                                                              color: Colors.white
                                                            ))
                                                        ),
                                                      ),
                                                    ),
                                                    )
                                              )
                                            ]
                                          ),
                                          TableRow(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(left:16),
                                                child: Text("3"),
                                              ),
                                              Text("2019-07-03"),
                                              Container(
                                                padding: EdgeInsets.only(left:10),
                                                child: Text("08:22:24"),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(left:18),
                                                child:  Text("05:22:24"),
                                              ),
                                              Center(
                                                  child: GestureDetector(
                                                    onTap: () {},
                                                    child: ClipOval(
                                                      child: Container(
                                                        color: Colors.lightBlueAccent,
                                                        height: 25.0, // height of the button
                                                        width: 25.0, // width of the button
                                                        child: Center(
                                                            child: Text('W', style: TextStyle(
                                                              color: Colors.white
                                                            ))
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                )
                                            ]
                                          ),
                                          TableRow(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(left:16),
                                                child: Text("4"),
                                              ),
                                              Text("2019-07-03"),
                                              Container(
                                                padding: EdgeInsets.only(left:10),
                                                child: Text("08:22:24"),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(left:18),
                                                child:  Text("05:22:24"),
                                              ),
                                              Center(
                                                  child: GestureDetector(
                                                    onTap: () {},
                                                    child: ClipOval(
                                                      child: Container(
                                                        color: Colors.green,
                                                        height: 25.0, // height of the button
                                                        width: 25.0, // width of the button
                                                        child: Center(
                                                            child: Text('D', style: TextStyle(
                                                              color: Colors.white
                                                            ))
                                                        ),
                                                      ),
                                                    ),
                                                    ))
                                            ]
                                          ),
                                          TableRow(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(left:16),
                                                child: Text("5"),
                                              ),
                                              Text("2019-07-03"),
                                              Container(
                                                padding: EdgeInsets.only(left:10),
                                                child: Text("08:22:24"),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(left:18),
                                                child:  Text("05:22:24"),
                                              ),
                                              Center(
                                                  child: GestureDetector(
                                                    onTap: () {},
                                                    child: ClipOval(
                                                      child: Container(
                                                        color: Colors.deepPurple,
                                                        height: 25.0, // height of the button
                                                        width: 25.0, // width of the button
                                                        child: Center(
                                                            child: Text('S', style: TextStyle(
                                                              color: Colors.white
                                                            ))
                                                        ),
                                                      ),
                                                    ),))
                                            ]
                                          ),
                                          TableRow(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(left:16),
                                                child: Text("6"),
                                              ),
                                              Text("2019-07-03"),
                                              Container(
                                                padding: EdgeInsets.only(left:10),
                                                child: Text("08:22:24"),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(left:18),
                                                child:  Text("05:22:24"),
                                              ),
                                              Center(
                                                  child: GestureDetector(
                                                    onTap: () {},
                                                    child: ClipOval(
                                                      child: Container(
                                                        color: Colors.deepOrangeAccent,
                                                        height: 25.0, // height of the button
                                                        width: 25.0, // width of the button
                                                        child: Center(
                                                            child: Text('C', style: TextStyle(
                                                              color: Colors.white
                                                            ))
                                                        ),
                                                      ),
                                                    ),))
                                            ]
                                          ),
                                          TableRow(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(left:16),
                                                child: Text("7"),
                                              ),
                                              Text("2019-07-03"),
                                              Container(
                                                padding: EdgeInsets.only(left:10),
                                                child: Text("08:22:24"),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(left:18),
                                                child:  Text("05:22:24"),
                                              ),
                                              Center(
                                                  child: GestureDetector(
                                                    onTap: () {},
                                                    child: ClipOval(
                                                      child: Container(
                                                        color: Colors.purpleAccent,
                                                        height: 25.0, // height of the button
                                                        width: 25.0, // width of the button
                                                        child: Center(
                                                            child: Text('I', style: TextStyle(
                                                              color: Colors.white
                                                            ))
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                              )
                                            ]
                                          ),
                                          TableRow(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(left:16),
                                                child: Text("8"),
                                              ),
                                              Text("2019-07-03"),
                                              Container(
                                                padding: EdgeInsets.only(left:10),
                                                child: Text("08:22:24"),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(left:18),
                                                child:  Text("05:22:24"),
                                              ),
                                              Center(
                                                  child: GestureDetector(
                                                    onTap: () {},
                                                    child: ClipOval(
                                                      child: Container(
                                                        color: Colors.pinkAccent,
                                                        height: 25.0, // height of the button
                                                        width: 25.0, // width of the button
                                                        child: Center(
                                                            child: Text('G', style: TextStyle(
                                                              color: Colors.white
                                                            ))
                                                        ),
                                                      ),
                                                    ),))
                                            ]
                                          ),
                                          TableRow(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(left:16),
                                                child: Text("9"),
                                              ),
                                             Text("2019-07-03"),
                                              Container(
                                                padding: EdgeInsets.only(left:10),
                                                child: Text("08:22:24"),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(left:18),
                                                child:  Text("05:22:24"),
                                              ),
                                              Center(
                                                  child: GestureDetector(
                                                    onTap: () {},
                                                    child: ClipOval(
                                                      child: Container(
                                                        color: Colors.indigo,
                                                        height: 25.0, // height of the button
                                                        width: 25.0, // width of the button
                                                        child: Center(
                                                            child: Text('T', style: TextStyle(
                                                              color: Colors.white
                                                            ))
                                                        ),
                                                      ),
                                                    ),))
                                            ]
                                          ),
                                      ],
                                  ),
                                  ),
                                ),
                              ),
                            ),
                  )   
                ),
              ]),
          ),
      );
    //);
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _selectedKeterangan = selectedCity;
    });
  }
}