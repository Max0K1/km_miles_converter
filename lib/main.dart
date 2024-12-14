import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Універсальний Конвертор',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Converter(),
    );
  }
}

class Converter extends StatefulWidget {
  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  String _inputValue = '';
  String _result = '';
  String _conversionType = 'kmToMiles'; // Тип конвертації за замовчуванням

  final Map<String, String> _conversionLabels = {
    'kmToMiles': 'Кілометри в Милі',
    'milesToKm': 'Милі в Кілометри',
    'inchesToCm': 'Дюйми в Сантиметри',
    'cmToInches': 'Сантиметри в Дюйми',
    'acresToHectares': 'Акри в Гектари',
    'hectaresToAcres': 'Гектари в Акри',
    'kgToPounds': 'Кілограми в Фунти',
    'poundsToKg': 'Фунти в Кілограми',
    'litersToGallons': 'Літри в Галони',
  };

  final Map<String, double> _conversionFactors = {
    'kmToMiles': 0.621371,
    'milesToKm': 1 / 0.621371,
    'inchesToCm': 2.54,
    'cmToInches': 1 / 2.54,
    'acresToHectares': 0.404686,
    'hectaresToAcres': 1 / 0.404686,
    'kgToPounds': 2.20462,
    'poundsToKg': 1 / 2.20462,
    'litersToGallons': 0.264172,
  };

  void _convert() {
    if (_inputValue.isNotEmpty) {
      double input = double.parse(_inputValue);
      double factor = _conversionFactors[_conversionType]!;
      setState(() {
        _result = (input * factor).toStringAsFixed(2);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Універсальний Конвертор'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Випадаючий список для вибору типу конвертації
            DropdownButton<String>(
              value: _conversionType,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  _conversionType = newValue!;
                  _result = '';
                });
              },
              items: _conversionLabels.entries
                  .map<DropdownMenuItem<String>>((entry) {
                return DropdownMenuItem<String>(
                  value: entry.key,
                  child: Text(entry.value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // Поле для вводу
            TextField(
              decoration: InputDecoration(
                labelText: 'Введіть значення',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _inputValue = value;
                  _result = '';
                });
              },
            ),
            SizedBox(height: 20),
            // Кнопка для конвертації
            ElevatedButton(
              onPressed: _convert,
              child: Text('Конвертувати'),
            ),
            SizedBox(height: 20),
            // Відображення результату
            Text(
              _result.isNotEmpty ? 'Результат: $_result' : '',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}