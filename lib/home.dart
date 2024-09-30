import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String fromCurrency = "BRL";
  String toCurrency = "USD";
  double rate = 0.0;
  double total = 0.0;
  TextEditingController amountController = TextEditingController();
  List<String> currencies = [];

  @override
  void initState() {
    super.initState();
    _getCurrencies();
  }

  Future<void> _getCurrencies()async{
    var response = await http.get(Uri.parse('https://api.exchangerate-api.com/v4/latest/USD'));

    var data = json.decode(response.body);
    setState(() {
      currencies = (data['rates'] as Map<String, dynamic>).keys.toList();
      rate = (data['rates'][toCurrency] as num).toDouble();

    });
  }

   Future<void> _getRate() async {
  var response = await http.get(Uri.parse('https://api.exchangerate-api.com/v4/latest/$fromCurrency'));
  var data = json.decode(response.body);
  setState(() {
    rate = (data['rates'][toCurrency] as num).toDouble();
    
    if (amountController.text.isNotEmpty) {
      double amount = double.parse(amountController.text);
      total = amount * rate;
    }
  });
}

void _swapCurrencies() {
  setState(() {
    String temp = fromCurrency;
    fromCurrency = toCurrency;
    toCurrency = temp;
    _getRate(); 
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1d2630),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: const Text("Conversor de Moedas"),
      ),
      body: Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
           Padding(
            padding: const EdgeInsets.all(40),
            child: Image.asset('assets/images/switch.png',
            width: MediaQuery.of(context).size.width /2,
            ),
           ),
           Padding(padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
           child: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              labelText: "Quantia",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              labelStyle: const TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
              ),
               focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                color: Colors.white,
                ),
            ),
           ),
           onChanged: (value){
            if(value != ''){
              setState(() {
                double amount = double.parse(value);
                total = amount = amount * rate;
              });
            }
           },
           ),
          ),
          Padding(padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 100,
                child: DropdownButton<String>(
                  value: fromCurrency,
                  isExpanded: true,
                  style: const TextStyle(color: Colors.white),
                  dropdownColor: Color(0xFF1d2630),
                  items: currencies.map((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue){
                    setState(() {
                      fromCurrency = newValue!;
                      _getRate();
                    });
                  },
                ),
              ),
              IconButton(
                onPressed: _swapCurrencies,
                icon: const Icon(
                  Icons.swap_horiz,
                  size: 40,
                  color: Colors.white,
                ),
                ),
                  SizedBox(
                  width: 100,
                  child: DropdownButton<String>(
                    value: toCurrency,
                    isExpanded: true,
                    style: const TextStyle(color: Colors.white),
                    dropdownColor: Color(0xFF1d2630),
                    items: currencies.map((String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue){
                      setState(() {
                        toCurrency = newValue!;
                        _getRate();
                      });
                    },
                  ),
                ),
            ],
          ),
          ),
          const SizedBox(height: 10),
          Text("Taxa de conversao $rate",
          style: const TextStyle(
            fontSize: 20, 
            color: Colors.white,
          ),
          ),
                 const SizedBox(height: 20),
          Text('${total.toStringAsFixed(3)}',
            style: const TextStyle(
              color: Colors.greenAccent,
              fontSize: 40,
            ),
          ),
          ],
        ),
      ),
      ),
    );
  }
}