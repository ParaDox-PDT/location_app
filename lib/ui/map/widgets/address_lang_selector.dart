import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/providers/address_call_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constants.dart';
import '../../../utils/images.dart';


class LanguageOfAddress extends StatefulWidget {
  const LanguageOfAddress({Key? key}) : super(key: key);

  @override
  State<LanguageOfAddress> createState() => _LanguageOfAddressState();
}

class _LanguageOfAddressState extends State<LanguageOfAddress> {
  String selectedLang = langList.first;

  @override
  Widget build(BuildContext context) {
    final languageSelectionProvider =
    Provider.of<AddressCallProvider>(context);
    String selectedLang = languageSelectionProvider.lang;
    return PopupMenuButton<String>(
      color: Colors.black.withOpacity(0.8),
      icon: Container(
        height: 33,
        width: 33,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.black.withOpacity(0.8),
        ),
        child: ClipOval(
          child: Image.asset(
            selectedLang == langList[0]
                ? AppImages.uzbekFlag
                : selectedLang == langList[1]
                ? AppImages.rusFlag
                : selectedLang == langList[2]
                ? AppImages.usaFlag
                : AppImages.turkishFlag,
            fit: BoxFit.cover,
          ),
        ),
      ),
      initialValue: selectedLang,
      onSelected: (String value){
        setState(() async {
          selectedLang = value;
          languageSelectionProvider.updateLang(value);
          context.read<AddressCallProvider>().updateLang(selectedLang);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('selectedLanguage', value);
        });
      },
      itemBuilder: (BuildContext context) {
        return langList.asMap().entries.map<PopupMenuEntry<String>>(
              (MapEntry<int, String> entry) {
            int index = entry.key;
            String value = entry.value;
            String text;
            switch (index) {
              case 1:
                text = 'Русский';
                break;
              case 2:
                text = 'English';
                break;
              case 3:
                text = 'Türkçe';
                break;
              default:
                text = 'Uzbek';
            }

            return PopupMenuItem<String>(
              value: value,
              child: Text(
                text,
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        ).toList();
      },
    );
  }
}