import 'package:flutter/material.dart';
import 'package:mobile_ebiz/models/schedule/port.dart';
import 'package:mobile_ebiz/services/api_port.dart';
import 'package:side_navigation/side_navigation.dart';

class PortList extends StatefulWidget {
  const PortList(
      {Key? key,
      required this.gb,
      required this.func,
      required this.initNation})
      : super(key: key);
  final String gb, initNation;
  final Function func;

  @override
  State<PortList> createState() => _PortListState();
}

class _PortListState extends State<PortList> {
  List<Widget> views = [];

  final Future<List<Port>> ports = ApiPort.getPortList();

  int _selectedIndex = 0, nationCount = 0;
  bool firstSelected = false;

  @override
  Widget build(BuildContext context) {
    String compareStr = "";
    List<SideNavigationBarItem> nationWidgets = [];

    void addListIntoView(List<Map<String, String>> list) {
      if (list.isNotEmpty) {
        List<Widget> portList = [];
        for (Map item in list) {
          String code = '', name = '';
          item.forEach((key, value) {
            code = key;
            name = value;
          });
          portList.add(GestureDetector(
            onTap: () {
              widget.func(widget.gb, code, name);
              Navigator.of(context).pop();
            },
            child: SizedBox(
              height: 30,
              child: Text(
                name,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ));
        }
        views.add(Center(
          child: ListView(
            padding: const EdgeInsets.only(left: 3),
            children: portList,
          ),
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Port List'),
      ),
      body: FutureBuilder(
        future: ports,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Map<String, String>> portList = [];
            for (Port port in snapshot.data!) {
              if (compareStr != port.nation) {
                nationWidgets.add(SideNavigationBarItem(
                    icon: Icons.control_point, label: port.nation));
                if (port.nation == widget.initNation &&
                    firstSelected == false) {
                  _selectedIndex = nationCount;
                  firstSelected = true;
                }
                nationCount++;
                compareStr = port.nation;
                addListIntoView(portList);
                portList.clear();
                portList.add({port.port: port.portnm});
              } else {
                portList.add({port.port: port.portnm});
              }
            }
            addListIntoView(portList);

            return Row(children: [
              Expanded(
                flex: 3,
                child: SideNavigationBar(
                    theme: SideNavigationBarTheme(
                      itemTheme: SideNavigationBarItemTheme(
                        unselectedBackgroundColor:
                            Theme.of(context).colorScheme.background,
                        selectedBackgroundColor:
                            Theme.of(context).colorScheme.primary,
                        iconSize: 20,
                        labelTextStyle:
                            Theme.of(context).textTheme.displaySmall,
                      ),
                      togglerTheme: SideNavigationBarTogglerTheme.standard(),
                      dividerTheme: SideNavigationBarDividerTheme.standard(),
                    ),
                    selectedIndex: _selectedIndex,
                    items: nationWidgets.toList(),
                    onTap: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    }),
              ),
              Expanded(
                flex: 7,
                child: views.elementAt(_selectedIndex),
              )
            ]);
          } else {
            return const Column(
              children: [
                SizedBox(
                  height: 10,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
