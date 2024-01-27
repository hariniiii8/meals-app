import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

class MonthlyPage extends StatefulWidget {
  @override
  _MonthlyPageState createState() => _MonthlyPageState();
}

class _MonthlyPageState extends State<MonthlyPage> {
  List<Map<String, dynamic>> _monthlyData = [];
  List<double> _caloriesPerDay =
      List.filled(7, 0); // Assuming 7 days of the week

  @override
  void initState() {
    super.initState();
    _fetchMonthlyData();
  }

  Future<void> _fetchMonthlyData() async {
    final url = Uri.https('flutterproject-e937e-default-rtdb.firebaseio.com',
        'todays_meals.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final List<Map<String, dynamic>> monthlyDataList =
          data.entries.map((entry) {
        final Map<String, dynamic> entryData = entry.value;
        return {
          'name': entryData['name'],
          'calories': entryData['calories'],
          'date': entryData['date'],
          'dayOfWeek': entryData['dayOfWeek'],
          'time': entryData['time'],
        };
      }).toList();

      setState(() {
        _monthlyData = monthlyDataList;
        _updateCaloriesPerDay();
      });
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
    }
  }

  void _updateCaloriesPerDay() {
    _caloriesPerDay = List.filled(7, 0);
    for (var entry in _monthlyData) {
      final dayIndex = _getDayIndex(entry['dayOfWeek']);
      _caloriesPerDay[dayIndex] += entry['calories'];
    }
  }

  int _getDayIndex(String dayOfWeek) {
    switch (dayOfWeek) {
      case 'Monday':
        return 0;
      case 'Tuesday':
        return 1;
      case 'Wednesday':
        return 2;
      case 'Thursday':
        return 3;
      case 'Friday':
        return 4;
      case 'Saturday':
        return 5;
      case 'Sunday':
        return 6;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Page'),
      ),
      body:Container(
        color: Color.fromARGB(255, 210, 101, 230),
        child: Column(
        children: [
          Expanded(
            child: _monthlyData.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: _monthlyData.length,
                    itemBuilder: (context, index) {
                      final item = _monthlyData[index];
                      return ListTile(
                        title: Text(
                          item['name'],
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Calories: ${item['calories']}',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Date: ${item['date']}',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Day of Week: ${item['dayOfWeek']}',
                              style: TextStyle(color: Colors.white),
                            ),
                            Flexible(
                              child: Text(
                                'Time: ${item['time']}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AspectRatio(
              aspectRatio: 1.5,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.center,
                  groupsSpace: 12,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.blueAccent,
                    ),
                    touchCallback: (barTouchResponse, _) {
                      // Handle touch interactions if needed
                    },
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: SideTitles(
                      showTitles: true,
                    ),
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTitles: (value) {
                        return _getDayOfWeek(value.toInt());
                      },
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: _buildBarGroups(),
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    checkToShowHorizontalLine: (double value) {
                      return value % 5 == 0; // Adjust the interval as needed
                    },
                    getDrawingHorizontalLine: (value) {
                      return FlLine(color: Colors.white); // Set line color here
                    },
                  ),
                  axisTitleData: FlAxisTitleData(
                    leftTitle: AxisTitle(
                        showTitle: true,
                        titleText: 'Calories',
                        textStyle: TextStyle(color: Colors.white)
                        )
                        ,
                    bottomTitle: AxisTitle(
                        showTitle: true,
                        titleText: 'Days',
                        textStyle: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),),
    );
  }

  String _getDayOfWeek(int index) {
    switch (index) {
      case 0:
        return 'Mon';
      case 1:
        return 'Tue';
      case 2:
        return 'Wed';
      case 3:
        return 'Thu';
      case 4:
        return 'Fri';
      case 5:
        return 'Sat';
      case 6:
        return 'Sun';
      default:
        return '';
    }
  }

  List<BarChartGroupData> _buildBarGroups() {
    return List.generate(
      _caloriesPerDay.length,
      (index) => BarChartGroupData(
        x: index,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            y: _caloriesPerDay[index],
            colors: [Colors.blueAccent], // Use colors instead of color
            width: 16,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
        ],
      ),
    );
  }
}
