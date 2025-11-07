import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/src/domain/models/role.dart';
import 'package:uber_clone/src/presentation/screens/roles/bloc/roles_bloc.dart';
import 'package:uber_clone/src/presentation/screens/roles/bloc/roles_state.dart';
import 'package:uber_clone/src/presentation/screens/roles/roles_item.dart';

class RolesScreen extends StatefulWidget {
  const RolesScreen({super.key});

  @override
  State<RolesScreen> createState() => _RolesScreenState();
}

class _RolesScreenState extends State<RolesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RolesBloc, RolesState>(
        builder: (context, state) {
          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromARGB(255, 12, 38, 145),
                    Color.fromARGB(255, 34, 156, 249),
                  ]
                )
              ),
              child: ListView(
                shrinkWrap: true,
                children: state.roles != null 
                ? (state.roles?.map((Role role) {
                    return RolesItem(role);
                  }).toList()
                ) as List<Widget>
                : [],
              ),
            );
        },
      ),
    );
  }
}