import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quotogeneratorapp/api.dart';
import 'package:quotogeneratorapp/quoteModel.dart';

class QuotoGenerator extends StatefulWidget {
  const QuotoGenerator({super.key});

  @override
  State<QuotoGenerator> createState() => _QuotoGeneratorState();
}

class _QuotoGeneratorState extends State<QuotoGenerator> {
  bool inProgress = false;
  QuoteModel? quote;

  @override
  void initState() {

    _fetchQuote();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Qutoes",
                  style: const TextStyle(
                    color: Colors.red,
                    fontFamily: 'monospace',
                    fontSize: 24,
                  ),
                ),
                const Spacer(),
                Text(
                  quote?.q ?? "..........",
                  style: const TextStyle(
                    fontSize: 30,
                    fontFamily: 'monospace',
                  ),
                  textAlign: TextAlign.center,
                ),
                const Gap(16),
                Text(
                  quote?.a ?? "..........",
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 20,
                    fontFamily: 'serif',
                  ),
                ),
                const Spacer(),
                inProgress
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : ElevatedButton(
                        onPressed: () {
                          _fetchQuote();
                        },
                        child: Text(
                          "Generate",
                          style: TextStyle(color: Colors.black87),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _fetchQuote() async{
    setState(() {
      inProgress = true;
    });
    try{
      final fetchQuote = await Api.fetchRandomQuote();
      quote = fetchQuote;
    }
    catch (e){
      debugPrint("Failed To Generate Quote");
    }
    finally{
      setState(() {
        inProgress = false;
      });
    }
  }

}
