import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../messages.dart';

class FormGeneric extends StatefulWidget {
  final Function action;
  final Function children;

  FormGeneric({this.action, this.children});

  @override
  _FormGeneric createState() => _FormGeneric();
}

class _FormGeneric extends State<FormGeneric> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool _isSubmitDisabled;

  @override
  void initState() {
    // submit button enabled
    _isSubmitDisabled = false;
    super.initState();
  }

  @override
  Widget build(context) {
    final messages = Messages.fromJson();

    return FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.children(
          disabled: _isSubmitDisabled,
          onSubmit: () async {
            try {
              final form = _formKey.currentState;
              // do not submit if form invalid
              if (!form.validate()) return;
              // gets the input values
              form.save();
              // visual clues
              setState(() {
                _isSubmitDisabled = true;
              });
              // show waiting message
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(messages.processing),
                ),
              );
              await widget.action(form.value);
            } catch (error) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  content: Text(error.message ?? messages.unexpectedError,
                      style: TextStyle(
                        color: Colors.red,
                      )),
                ),
              );
              // re-enable submit button
              setState(() {
                _isSubmitDisabled = false;
              });
              // remove waiting message
              Scaffold.of(context).removeCurrentSnackBar();
            }
          },
        ),
      ),
    );
  }
}
