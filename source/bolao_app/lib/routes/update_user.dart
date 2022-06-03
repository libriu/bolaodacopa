import 'package:bolao_app/widgets/user_form.dart';
import 'package:flutter/material.dart';

class UpdateUserRoute extends StatefulWidget {

  const UpdateUserRoute({
    Key? key
  }) : super(key: key);

  @override
  State<UpdateUserRoute> createState() => _UpdateUserRouteState();
}

class _UpdateUserRouteState extends State<UpdateUserRoute> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            right: -40.0,
            top: -40.0,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const CircleAvatar(
                child: Icon(Icons.close),
                backgroundColor: Colors.red,
              ),
            ),
          ),
          const UserForm()
        ],
        ),
    );
  }
}
