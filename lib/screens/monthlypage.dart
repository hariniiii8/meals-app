import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MonthlyPage extends StatefulWidget {
  @override
  _MonthlyPageState createState() => _MonthlyPageState();
}

class _MonthlyPageState extends State<MonthlyPage> {
  List<Map<String, dynamic>> _monthlyData = [];

  @override
  void initState() {
    super.initState();
    _fetchMonthlyData();
  }

  Future<void> _fetchMonthlyData() async {
    final url = Uri.https('flutterproject-e937e-default-rtdb.firebaseio.com', 'todays_meals.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final List<Map<String, dynamic>> monthlyDataList = data.entries.map((entry) {
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
      });
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Page'),
      ),
      body: _monthlyData.isEmpty
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
    );
  }
}
