import 'package:flutter/material.dart';
import 'package:mobile_ebiz/widgets/bldetail/search_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController txtBlNo = TextEditingController();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
          controller: txtBlNo,
          onChanged: (value) => value.toUpperCase(),
          decoration: InputDecoration(
            labelText: 'B/L No.',
            suffix: InkWell(
              child: const Icon(Icons.search),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            SearchWidget(blno: txtBlNo.text)));
              },
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
          keyboardType: TextInputType.text,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
