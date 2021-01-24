import 'package:flutter/material.dart';

class SearchMedicineBar extends StatelessWidget {
  const SearchMedicineBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // onChanged: (value) => model.changePhoneNum(value),
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: "Enter medicine",
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(
          Icons.search,
          color: Colors.blue,
          size: 30,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
        // suffixIcon: model.addressController.text.isEmpty
        //     ? null
        //     : InkWell(
        //         onTap: () => model.addressController.clear(),
        //         child: Icon(Icons.clear),
        //       ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
