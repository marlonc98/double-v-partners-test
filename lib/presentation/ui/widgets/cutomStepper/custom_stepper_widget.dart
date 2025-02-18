import 'package:flutter/material.dart';

class CustomStep {
  final String title;
  final Widget content;

  CustomStep({required this.title, required this.content});
}

class CustomStepperWidget extends StatefulWidget {
  final List<CustomStep> steps;
  final int currentStep;
  final Function(int) onStepTapped;
  final Function()? onTapBack;

  const CustomStepperWidget({
    super.key,
    required this.steps,
    required this.currentStep,
    required this.onStepTapped,
    this.onTapBack,
  });

  @override
  State<CustomStepperWidget> createState() => _CustomStepperWidgetState();
}

class _CustomStepperWidgetState extends State<CustomStepperWidget> {
  final ScrollController scrollController = ScrollController();
  final ScrollController verticalcontroller = ScrollController();
  final GlobalKey rowKey = GlobalKey();
  late List<Widget> steps;

  Color _currentColor(CustomStep step) {
    final index = widget.steps.indexOf(step);
    if (widget.currentStep == index) {
      return Theme.of(context).primaryColor;
    } else if (widget.currentStep > index) {
      return Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;
    } else {
      return (Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black)
          .withAlpha(153);
    }
  }

  //onChange step center scroll to current step
  void _onChangeStep() {
    try {
      double scrollX = steps.sublist(0, widget.currentStep).fold(0.0, (
        previousValue,
        element,
      ) {
        RenderBox? renderBox =
            (element.key as GlobalKey).currentContext?.findRenderObject()
                as RenderBox?;
        final widgetWidth = renderBox?.size.width ?? 0;
        return previousValue + widgetWidth;
      });
      verticalcontroller.animateTo(
        0,
        duration: Duration(microseconds: 100),
        curve: Curves.ease,
      );
      scrollController.animateTo(
        scrollX,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  void didUpdateWidget(covariant CustomStepperWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if widget.step has changed and perform an action
    if (widget.currentStep != oldWidget.currentStep &&
        widget.currentStep < widget.steps.length) {
      _onChangeStep();
    }
  }

  @override
  Widget build(BuildContext context) {
    steps =
        widget.steps
            .map(
              (step) => Container(
                key: GlobalKey(),
                padding: EdgeInsets.all(8),
                child: InkWell(
                  onTap: () => widget.onStepTapped(widget.steps.indexOf(step)),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: _currentColor(step),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            '${widget.steps.indexOf(step) + 1}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          step.title,
                          style: TextStyle(color: _currentColor(step)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList();
    return SafeArea(
      child: SingleChildScrollView(
        controller: verticalcontroller,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  if (widget.onTapBack != null)
                    IconButton(
                      onPressed: widget.onTapBack,
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: scrollController,
                      child: Row(key: rowKey, children: steps),
                    ),
                  ),
                ],
              ),
            ),
            widget.steps[widget.currentStep].content,
          ],
        ),
      ),
    );
  }
}
