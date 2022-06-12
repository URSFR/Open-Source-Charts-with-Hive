import 'package:checkingmysales/model/boxes.dart';
import 'package:checkingmysales/model/sale.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
class SalesScreen extends StatefulWidget {
   const SalesScreen({Key? key}) : super(key: key);

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {

  double? TheMonth; String TheMonthDD = "";
  double? TheYear;  String TheYearDD = "";
  final  _months = [
    "",
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  final  _years = [
    "",
    "2021",
    "2022",
    "2023",
    "2024",
    "2025",
    "2026",
    "2027",
    "2028"
  ];

  List<FlSpot> dataSet =[];
  TextEditingController amountET =TextEditingController();
  final box = Boxes.getTransactions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("CHECK MY SALES",style: GoogleFonts.anton(fontSize: 65,color: Colors.white),),
            SizedBox(height: 15,),
            Container(
              width: 200,
              child: TextFormField(
                style: GoogleFonts.numans(color: Colors.blue),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: amountET,
                decoration: InputDecoration(fillColor: Colors.white70,filled: true,focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 5.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 5.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),),
              ),
            ),
            Row(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [

              Container(
                width: 125,
                child: DropdownButton<String>(value: TheMonthDD, items: _months.map(buildMenuItem).toList(), onChanged: (value){
                  if(value=="January"){
                    TheMonth=1;
                    TheMonthDD="January";
                    setState((){

                    });
                  }
                  else if(value=="February"){
                    TheMonth=2;
                    TheMonthDD="February";
                    setState((){

                    });                 }
                 else if(value=="March"){
                    setState((){
                      TheMonth=3;
                      TheMonthDD="March";
                    });                 }
                 else  if(value=="April"){
                    setState((){
                      TheMonth=4;
                      TheMonthDD="April";
                    });                 }
                 else if(value=="May"){
                    setState((){
                      TheMonth=5;
                      TheMonthDD="May";
                    });                 }
                 else  if(value=="June"){
                    setState((){
                      TheMonth=6;
                      TheMonthDD="June";
                    });                 }
                 else  if(value=="July"){
                    setState((){
                      TheMonth=7;
                      TheMonthDD="July";
                    });                 }
                 else  if(value=="August"){
                    setState((){
                      TheMonth=8;
                      TheMonthDD="August";
                    });                 }
                 else if(value=="September"){
                    setState((){
                      TheMonth=9;
                      TheMonthDD="September";
                    });                 }
                 else if(value=="October"){
                    setState((){
                      TheMonth=10;
                      TheMonthDD="October";
                    });                 }
                 else if(value=="November"){
                    setState((){
                      TheMonth=11;
                      TheMonthDD="November";
                    });                 }
                 else if(value=="December"){
                    setState((){
                      TheMonth=12;
                      TheMonthDD="December";
                    });                 }

                }),
              ),

              SizedBox(width: 40,),
              Container(
                width: 125,
                child: DropdownButton<String>(value: TheYearDD,items: _years.map(buildMenuItem).toList(), onChanged: (value){
                  int yearChoosed = int.parse(value!);

                  if(yearChoosed==2021){
                    TheYear=2021;
                    TheYearDD="2021";
                    setState((){

                    });
                  }
                  if(yearChoosed==2022){
                    setState((){
                      TheYear=2022;
                      TheYearDD="2022";
                    });                  }
                  if(yearChoosed==2023){
                    setState((){
                      TheYear=2023;
                      TheYearDD="2023";
                    });                  }
                  if(yearChoosed==2024){
                    setState((){
                      TheYear=2024;
                      TheYearDD="2024";
                    });                  }
                  if(yearChoosed==2025){
                    setState((){
                      TheYear=2025;
                      TheYearDD="2025";
                    });                  }
                  if(yearChoosed==2026){
                    setState((){
                      TheYear=2026;
                      TheYearDD="2026";
                    });                  }
                }),
              ),
            ],),

            ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.green),onPressed: (){
              EasyLoading.show(status: "LOADING");
              // DateTime today = new DateTime.now();
              // var _today = DateTime.parse(today.toString());
              // var _formatToday = DateFormat.yMMMd().format(today);
              if(TheMonth!=null && TheYear!=null&&amountET.text!=""&&amountET.text!=null){
                AddSale(double.parse(amountET.text), TheMonth!, TheYear!);
                EasyLoading.showSuccess("SUCCESS");

              }
              else{
                EasyLoading.showError("MUST COMPLETE ALL FIELDS");
              }
            }, child: Text("Submit",)),
            SizedBox(height: 5,),

               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: AspectRatio(
                 aspectRatio: 5,
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        ),
                        color: Color(0xff232d37)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 18.0, left: 12.0, top: 24, bottom: 12),
                      child: LineChart(
                        // showAvg ? avgData():
                        mainData(),
                      ),
                    ),
                  ),
              ),
               ),

            Text("All bills",style: GoogleFonts.anton(fontSize: 32,color: Colors.white),),
            box==null?CircularProgressIndicator():
            Container(
              width: 300,
              height: 300,
              child: ValueListenableBuilder(valueListenable: box.listenable(), builder: (context, Box<Sale> data, _){
                List<int> keys = data.keys.cast<int>().toList();

                return ListView.builder(
                  itemCount: keys.length,
                  itemBuilder: (_, index){
                    Sale? record = data.get(keys[index]);
                    if(!dataSet.contains({
                      record!.month,record.amount*0.0001
                    })){
                      dataSet.remove(FlSpot(record.month, record.amount*0.0001));
                      dataSet.add(FlSpot(record.month, record.amount*0.0001));

                    }
                    // if(levelled==false){
                    //   levelled=true;
                    //   print("DISTANCIA "+dataSet.length.toString());
                    // }


                    return forsenLevel(keys[index],record);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, Sale sale, ) {

    // set up the buttons
    Widget remindButton = TextButton(
      child: Text("Remove"),
      onPressed:  () async {
        removeSale(sale);
        Navigator.of(context, rootNavigator: true).pop('dialog');

      },
    );
    Widget cancelButton = TextButton(
      child: Text("Update"),
      onPressed:  () {
        Navigator.of(context, rootNavigator: true).pop('dialog');

        _displayTextInputDialog(context, sale);
      },
    );
    Widget launchButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context, rootNavigator: true).pop('dialog');

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Options"),
      content: Text("Its Time To Choose..."),
      actions: [
        remindButton,
        cancelButton,
        launchButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  TextEditingController amountChangedET = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context, Sale sale,) async {
    return showDialog(
        context: context,
        builder: (context) {
          double? ADTheMonth;
          String ADTheMonthDD = "";
          double? ADTheYear;
          String ADTheYearDD = "";
          return AlertDialog(
            title: Text('Update'),
            content: Column(
              children: [
                TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {

                  },
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: amountChangedET,
                  decoration: InputDecoration(hintText: "Amount"),
                ),
                Container(
                  width: 200,
                  child: DropdownButton<String>(value: ADTheMonthDD, items: _months.map(buildMenuItem).toList(), onChanged: (value){
                    if(value=="January"){
                      ADTheMonth=1;
                      ADTheMonthDD="January";
                      setState((){

                      });
                    }
                    else if(value=="February"){
                      ADTheMonth=2;
                      ADTheMonthDD="February";
                      setState((){

                      });                 }
                    else if(value=="March"){
                      setState((){
                        ADTheMonth=3;
                        ADTheMonthDD="March";
                      });                 }
                    else  if(value=="April"){
                      setState((){
                        ADTheMonth=4;
                        ADTheMonthDD="April";
                      });                 }
                    else if(value=="May"){
                      setState((){
                        ADTheMonth=5;
                        ADTheMonthDD="May";
                      });                 }
                    else  if(value=="June"){
                      setState((){
                        ADTheMonth=6;
                        ADTheMonthDD="June";
                      });                 }
                    else  if(value=="July"){
                      setState((){
                        ADTheMonth=7;
                        ADTheMonthDD="July";
                      });                 }
                    else  if(value=="August"){
                      setState((){
                        ADTheMonth=8;
                        ADTheMonthDD="August";
                      });                 }
                    else if(value=="September"){
                      setState((){
                        ADTheMonth=9;
                        ADTheMonthDD="September";
                      });                 }
                    else if(value=="October"){
                      setState((){
                        ADTheMonth=10;
                        ADTheMonthDD="October";
                      });                 }
                    else if(value=="November"){
                      setState((){
                        ADTheMonth=11;
                        ADTheMonthDD="November";
                      });                 }
                    else if(value=="December"){
                      setState((){
                        ADTheMonth=12;
                        ADTheMonthDD="December";
                      });                 }

                  }),
                ),

                Container(
                  width: 200,
                  child: DropdownButton<String>(value: ADTheYearDD,items: _years.map(buildMenuItem).toList(), onChanged: (value){
                    int yearChoosed = int.parse(value!);

                    if(yearChoosed==2021){
                      ADTheYear=2021;
                      ADTheYearDD="2021";
                      setState((){

                      });
                    }
                    if(yearChoosed==2022){
                      setState((){
                        ADTheYear=2022;
                        ADTheYearDD="2022";
                      });                  }
                    if(yearChoosed==2023){
                      setState((){
                        ADTheYear=2023;
                        ADTheYearDD="2023";
                      });                  }
                    if(yearChoosed==2024){
                      setState((){
                        ADTheYear=2024;
                        ADTheYearDD="2024";
                      });                  }
                    if(yearChoosed==2025){
                      setState((){
                        ADTheYear=2025;
                        ADTheYearDD="2025";
                      });                  }
                    if(yearChoosed==2026){
                      setState((){
                        ADTheYear=2026;
                        ADTheYearDD="2026";
                      });                  }
                  }),
                ),
              ],
            ),            actions: <Widget>[
              ElevatedButton(
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
            ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    if(amountChangedET.text!=""&&amountChangedET.text!=null&&ADTheMonth!=null&&ADTheYear!=null){
                      editSale(sale, double.parse(amountChangedET.text), ADTheMonth!, ADTheYear!);

                    }else{
                      Fluttertoast.showToast(msg: "You must choose and complete the fields");
                    }

                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  Widget forsenLevel(var key,Sale data){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          showAlertDialog(context, data);
          // EasyLoading.show(status: "DELETING");
          //
          // await box.delete(key).whenComplete(() {
          //   EasyLoading.showSuccess("REMOVED");
          // });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: Colors.grey[400]!,
              width: 5,
            ),

          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Text(DateFormat('MMMM').format(DateTime(0,data.month.toInt()))),
              Text(data.year.toString()),
              Text(data.amount.toString()),
            ],),
          ),
        ),
      ),
    );

  }
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item,style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold,fontSize: 20),));


  AddSale(double amount,double month, double year) {
  final sale = Sale(amount: amount, month: month,year: year);
      box.add(sale);
       dataSet.add(FlSpot(month, amount*0.0001));

  }


  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];


  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('Jan', style: style);
        break;
      case 2:
        text = const Text('Feb', style: style);
        break;
      case 3:
        text = const Text('Mar', style: style);
        break;
      case 4:
        text = const Text('Apr', style: style);
        break;
      case 5:
        text = const Text('May', style: style);
        break;
      case 6:
        text = const Text('Jun', style: style);
        break;
      case 7:
        text = const Text('Jul', style: style);
        break;
      case 8:
        text = const Text('Aug', style: style);
        break;
      case 9:
        text = const Text('Sep', style: style);
        break;
      case 10:
        text = const Text('Oct', style: style);
        break;
      case 11:
        text = const Text('Nov', style: style);
        break;
      case 12:
        text = const Text('Dec', style: style);
        break;

      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = value.toInt==value?value.toString():"10K";
        break;
      case 3:
        text = value.toInt==value?value.toString():"30K";
        break;
      case 5:
        text = value.toInt==value?value.toString():"50K";
        break;
      case 8:
        text = value.toInt==value?value.toString():"80K";
        break;
      case 10:
        text = value.toInt==value?value.toString():"100K";
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
    );

  }
  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
          getTouchedSpotIndicator:
              (LineChartBarData barData, List<int> spotIndexes) {
            return spotIndexes.map((spotIndex) {
              final spot = barData.spots[spotIndex];
              if (spot.x == 0 || spot.x == 6) {
                return null;
              }
              return TouchedSpotIndicatorData(
                FlLine(color: Colors.blue, strokeWidth: 4),
                FlDotData(
                  getDotPainter: (spot, percent, barData, index) {
                    if (index % 2 == 0) {
                      return FlDotCirclePainter(
                          radius: 8,
                          color: Colors.white,
                          strokeWidth: 5,
                          strokeColor: Colors.deepOrange);
                    } else {
                      return FlDotSquarePainter(
                        size: 16,
                        color: Colors.white,
                        strokeWidth: 5,
                        strokeColor: Colors.deepOrange,
                      );
                    }
                  },
                ),
              );
            }).toList();
          },
          touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Colors.blueAccent,
              getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                return touchedBarSpots.map((barSpot) {
                  final flSpot = barSpot;
                  if (flSpot.x == 0 || flSpot.x == 6) {
                    return null;
                  }

                  TextAlign textAlign;
                  switch (flSpot.x.toInt()) {
                    case 1:
                      textAlign = TextAlign.left;
                      break;
                    case 5:
                      textAlign = TextAlign.right;
                      break;
                    default:
                      textAlign = TextAlign.center;
                  }

                  return LineTooltipItem(
                    '',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: '${(flSpot.y.toDouble()*10000).toStringAsFixed(0)} \$ \n',
                        style: TextStyle(
                          color: Colors.grey[100],
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      // const TextSpan(
                      //   text: ' \$ ',
                      //   style: TextStyle(
                      //     fontStyle: FontStyle.italic,
                      //     fontWeight: FontWeight.normal,
                      //   ),
                      // ),
                      const TextSpan(
                        text: 'Billed',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                    textAlign: textAlign,
                  );
                }).toList();
              }),
          touchCallback:
              (FlTouchEvent event, LineTouchResponse? lineTouch) {
            if (!event.isInterestedForInteractions ||
                lineTouch == null ||
                lineTouch.lineBarSpots == null) {
              setState(() {
                // touchedValue = -1;
              });
              return;
            }
            final value = lineTouch.lineBarSpots![0].x;

            if (value == 0 || value == 6) {
              setState(() {
                // touchedValue = -1;
              });
              return;
            }

            setState(() {
              // touchedValue = value;
            });
          }),
      // extraLinesData: ExtraLinesData(horizontalLines: [
      //   HorizontalLine(
      //     y: 1.8,
      //     color: Colors.green.withOpacity(0.8),
      //     strokeWidth: 3,
      //     dashArray: [20, 2],
      //   ),
      // ]),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: 18,
      lineBarsData: [
        LineChartBarData(
          spots: dataSet,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
    );
  }


 void editSale(Sale sale, double amount, double month, double year,){
    sale.amount = amount;sale.month = month;sale.year = year;
   // box.put(sale.key, sale);
    sale.save();
}
  void removeSale(Sale sale){
    sale.delete();
  }


}
