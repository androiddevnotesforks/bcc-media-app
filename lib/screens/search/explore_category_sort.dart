import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../components/option_list.dart';

class ExploreCategorySort extends StatefulWidget {
  @override
  State<ExploreCategorySort> createState() => _ExploreCategorySortState();
}

class _ExploreCategorySortState extends State<ExploreCategorySort> {
  final optionData = [
    Option(id: 'recently_published', title: 'Recently published'),
    Option(id: 'a-z', title: 'A - Z'),
  ];

  String selectedOption = 'recently_published';

  void onSelectionChanged(String id) {
    setState(() {
      selectedOption = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Center(
            child: Container(
              height: 5,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color.fromRGBO(112, 124, 142, 1),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: const Text(
            'Sort by',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color.fromRGBO(254, 254, 254, 1),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: OptionList(
            optionData: optionData,
            currentSelection: selectedOption,
            onSelectionChange: onSelectionChanged,
            margin: const EdgeInsets.all(0),
            enableDivider: false,
          ),
        ),
        SizedBox(
          height: 52.1,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromRGBO(204, 221, 255, 0.1),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              side: const BorderSide(
                  width: 1, color: Color.fromRGBO(204, 221, 255, 0.1)),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Color.fromRGBO(254, 254, 254, 1),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
