import 'package:doublevpartners/domain/entities/counter_loader_entity.dart';
import 'package:flutter/material.dart';

class ModalProgressWidget extends StatefulWidget {
  final CounterLoaderEntity counter;
  final String text;

  const ModalProgressWidget({
    super.key,
    required this.text,
    required this.counter,
  });

  @override
  State<StatefulWidget> createState() => ModalProgressWidgetState();
}

class ModalProgressWidgetState extends State<ModalProgressWidget> {
  late CounterLoaderEntity counter;

  @override
  void initState() {
    counter = widget.counter;
    super.initState();
  }

  void changeState(CounterLoaderEntity _change) {
    setState(() {
      counter = _change;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          LinearProgressIndicator(value: counter.percent),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  counter.description,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8),
              Text("${counter.currentStep}/${counter.totalSteps}"),
            ],
          ),
        ],
      ),
    );
  }
}
