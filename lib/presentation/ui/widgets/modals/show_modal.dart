import 'package:doublevpartners/domain/entities/counter_loader_entity.dart';
import 'package:doublevpartners/domain/states/localization/localization_state.dart';
import 'package:doublevpartners/presentation/provider/language/key_word_localization.dart';
import 'package:doublevpartners/presentation/ui/widgets/modals/modal_progress_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowModal {
  static Future<void> openDialog({
    required context,
    String title = '',
    String text = '',
    List<Widget>? actions,
  }) async {
    final localization = Provider.of<LocalizationState>(context, listen: false);
    await showCupertinoDialog<String>(
      context: context,
      barrierDismissible: true,
      builder:
          (BuildContext context) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(text),
            actions:
                actions ??
                [
                  TextButton(
                    child: Text(
                      localization.translate(KeyWordsLocalization.Accept),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
          ),
    );
  }

  static void showLoading({required context}) {
    showCupertinoDialog<String>(
      context: context,
      barrierDismissible: false,
      builder:
          (BuildContext context) => CupertinoAlertDialog(
            content: Container(
              alignment: FractionalOffset.center,
              width: MediaQuery.of(context).size.width,
              height: 40,
              padding: const EdgeInsets.all(20.0),
              child: CupertinoActivityIndicator(animating: true),
            ),
          ),
    );
  }

  static void showSnackBar({
    required context,
    required text,
    bool? error,
    bool? success,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:
            error == true
                ? Colors.red
                : (success == true ? Colors.green : null),
        content: Text(text),
      ),
    );
  }

  static Future<dynamic> openCustomDialog({
    required context,
    String title = '',
    required Widget content,
    List<Widget>? actions,
  }) {
    final localization = Provider.of<LocalizationState>(context, listen: false);
    return showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder:
          (BuildContext context) => CupertinoAlertDialog(
            content: Container(
              padding: EdgeInsets.all(16),
              // decoration: new BoxDecoration(
              //   image: new DecorationImage(
              //       image: ExactAssetImage('assets/appIcon/bg-modal.png'),
              //       alignment: Alignment.topRight),
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  content,
                ],
              ),
            ),
            actions:
                actions ??
                [
                  TextButton(
                    child: Text(
                      localization.translate(KeyWordsLocalization.Accept),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
          ),
    );
  }

  static Future<void> showProggressModal({
    required context,
    required String text,
    Key? key,
    required CounterLoaderEntity counter,
  }) {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder:
          (BuildContext context) => CupertinoAlertDialog(
            content: ModalProgressWidget(
              key: key,
              text: text,
              counter: counter,
            ),
          ),
    );
  }
}
