import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/screen_size.dart';
import 'my_information_setting_system.dart';

final MyInformationSettingController _myInformationSettingController =
    Get.put(MyInformationSettingController());

class SettingMyNameWidget extends StatefulWidget {
  const SettingMyNameWidget({super.key});

  @override
  State<SettingMyNameWidget> createState() => _SettingMyNameWidgetState();
}

class _SettingMyNameWidgetState extends State<SettingMyNameWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _myInformationSettingController.controllerName,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        hintStyle: const TextStyle(fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}

class SettingDropDownWidget extends StatefulWidget {
  const SettingDropDownWidget({super.key});

  @override
  State<SettingDropDownWidget> createState() => _SettingDropDownWidgetState();
}

class _SettingDropDownWidgetState extends State<SettingDropDownWidget> {
  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: InputDecoration(
        // Add Horizontal padding using menuItemStyleData.padding so it matches
        // the menu padding when button's width is not specified.
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        fillColor: Colors.white,
        // Add more decoration..
      ),
      hint: const Text(
        '선택',
        style: TextStyle(fontSize: 14),
      ),
      items: genderItems
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select gender.';
        }
        return null;
      },
      value: 'Male',
      onChanged: (value) {
        //Do something when selected item is changed.
      },
      onSaved: (value) {
        selectedValue = value.toString();
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
