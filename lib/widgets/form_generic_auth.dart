import 'package:flutter/material.dart';
import 'package:simply_news/state/user_state.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:simply_news/lib/report_error.dart';
import 'package:simply_news/widgets/form_generic.dart';

class GenericAuthForm extends StatelessWidget {
  final String redirectButtonText;
  final Function redirectButtonRoute;
  final String submitButtonText;
  final Function authenticate;

  GenericAuthForm({
    this.authenticate,
    this.submitButtonText,
    this.redirectButtonText,
    this.redirectButtonRoute,
  });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);

    return FormGeneric(
      action: (value) async {
        String pwd = value['password'];
        String email = value['email'];
        // call authentication service
        final currentUser = await authenticate(email, pwd);
        user.email = currentUser.email;
        try {
          // !!> has to happen before updating user status (which triggers a redirection: see RequireAuth widget) <!!
          await user.getData();
        } catch (error) {
          // silent error: couldn't get the user data but we'll
          // try again when they navigate to their vocab page
          // and only display an error message if that fails then
          reportError(error);
        }
        // set user as signed in (this triggers a redirection: see RequireAuth widget)
        user.status = Auth.SignedIn;
      },
      children: ({onSubmit, disabled}) => [
        FormBuilderTextField(
          attribute: 'email',
          keyboardType: TextInputType.text,
          decoration: InputDecoration(labelText: 'Email'),
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.email(),
            FormBuilderValidators.maxLength(100),
          ],
        ),
        FormBuilderTextField(
          attribute: 'password',
          obscureText: true,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(labelText: 'Password'),
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(6),
            FormBuilderValidators.maxLength(15),
          ],
        ),
        SizedBox(height: 15.0),
        RaisedButton(
            child: Text(submitButtonText),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            splashColor: Colors.blueAccent,
            onPressed: disabled ? null : onSubmit),
        SizedBox(height: 15.0),
        FlatButton(
          child: Text(redirectButtonText),
          textColor: Theme.of(context).primaryColor,
          onPressed: redirectButtonRoute,
        ),
      ],
    );
  }
}
