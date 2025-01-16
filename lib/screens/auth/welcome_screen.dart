import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State <WelcomeScreen> createState() => _WelcomeScreenState();

}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  late TabController tabController;

@override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context),colorScheme.background,
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(20, -1.2),
                child:Container(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    shape: BoxShape.circle,
                  ),
                )
              ),
               Align(
                alignment: AlignmentDirectional(-2.7, -1.2),
                child:Container(
                  height: MediaQuery.of(context).size.width/1.3,
                  width: MediaQuery.of(context).size.width/1.3,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    shape: BoxShape.circle,
                  ),
                )
              ),
               Align(
                alignment: AlignmentDirectional(2.7, -1.2),
                child:Container(
                  height: MediaQuery.of(context).size.width/1.3,
                  width: MediaQuery.of(context).size.width/1.3,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                )
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0,sigmaY: 100.0),
                child: Container(),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height/1.8,
                    child : Column(
                      children:[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50.0),
                          child: TabBar(
                            controller: tabController,
                            unselectedLabelColor: Theme.of(context).colorScheme.onBackground,
                            labelColor: Theme.of(context).colorScheme.onBackground,
                            tabs: [
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  'sign in',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),)
                              ),
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  'sign up',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),)
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              Container(),
                              Container()
                            ],
                            ),
                            )
                      ]
                    )
                  ))
            ],
          )
        ) ,)
    );
  }
   
}