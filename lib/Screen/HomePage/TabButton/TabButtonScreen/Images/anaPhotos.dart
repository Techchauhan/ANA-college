import 'package:ana/Const/Colors.dart';
import 'package:flutter/material.dart';

class AnaPhoto extends StatelessWidget {
  final List<String> folderNames = [
    'National Conference on “Solar Energy For Sustainable Development”',
    'Diwali Celebration 2023',
    'DANDIYA UTSAV 2023 at A.N.A Group Of Institutions',
    'World Pharmacist Day_2023',
    'Engineer`s Day_2023'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Folder List'),
      ),
      body: ListView.builder(
        itemCount: folderNames.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.folder, color: AppColors.defaultColor,),
            title: Text(folderNames[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FolderContents(folderName: folderNames[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class FolderContents extends StatelessWidget {
  final String folderName;

  FolderContents({required this.folderName});

  List<String> getFolderContents() {
    switch (folderName) {
      case 'National Conference on “Solar Energy For Sustainable Development”':
        return [
          'http://adminpanel.inventive.in/images/photogallery/063fANA123405435855_294347620255435_710056634291009818_n.jpg',
          'http://adminpanel.inventive.in/images/photogallery/7c7bANA123405328762_294347586922105_8611783383653873753_n.jpg',
          'http://adminpanel.inventive.in/images/photogallery/7fdcANA123405277358_294347186922145_1720548524482068114_n.jpg',
          'http://adminpanel.inventive.in/images/photogallery/afbcANA123405316141_294346966922167_668970621836749151_n.jpg',
          'http://adminpanel.inventive.in/images/photogallery/02e8ANA123406616246_294347356922128_1905287474305728619_n.jpg',
          'http://adminpanel.inventive.in/images/photogallery/446fANA123405236063_294347803588750_4412353112282147435_n.jpg',
          'http://adminpanel.inventive.in/images/photogallery/5ab1ANA123405203695_294347133588817_840037084074494152_n.jpg',
          'http://adminpanel.inventive.in/images/photogallery/416bANA123405215274_294347363588794_8178139966903766371_n.jpg',
          'http://adminpanel.inventive.in/images/photogallery/1b2bANA123405263518_294347233588807_8403280125619161813_n.jpg',
          'http://adminpanel.inventive.in/images/photogallery/03feANA123405246231_294347033588827_4208693599417764825_n.jpg',
          'http://adminpanel.inventive.in/images/photogallery/d3dfANA123405375101_294347263588804_6263124699727002674_n.jpg',
          'http://adminpanel.inventive.in/images/photogallery/35deANA123405305308_294347880255409_4020865313537223760_n.jpg',
          'http://adminpanel.inventive.in/images/photogallery/5f63ANA123405215716_294347883588742_7412864295523543095_n.jpg',
          'http://adminpanel.inventive.in/images/photogallery/03f0ANA123405354233_294347556922108_5243071263675138672_n.jpg',
          "http://adminpanel.inventive.in/images/photogallery/c80eANA123405279397_294347560255441_8158946731265770486_n.jpg",
          'http://adminpanel.inventive.in/images/photogallery/c80eANA123405279397_294347560255441_8158946731265770486_n.jpg'
        ];
      case 'Diwali Celebration 2023':
        return [
          'http://adminpanel.inventive.in/images/photogallery/33a2ANA123IMG-20231120-WA0031.jpg',
          'http://adminpanel.inventive.in/images/photogallery/c2f3ANA123coverimage.jpg',
          'http://adminpanel.inventive.in/images/photogallery/c56eANA123IMG-20231120-WA0032.jpg',
          'http://adminpanel.inventive.in/images/photogallery/712cANA123IMG-20231120-WA0025.jpg',
          'http://adminpanel.inventive.in/images/photogallery/8649ANA123IMG-20231120-WA0026.jpg',
          'http://adminpanel.inventive.in/images/photogallery/7f1aANA123IMG-20231120-WA0027.jpg',
          'http://adminpanel.inventive.in/images/photogallery/de36ANA123IMG-20231120-WA0029.jpg',
          'http://adminpanel.inventive.in/images/photogallery/fbc8ANA123IMG-20231120-WA0021.jpg',
          'http://adminpanel.inventive.in/images/photogallery/615cANA123IMG-20231120-WA0022.jpg',
          'http://adminpanel.inventive.in/images/photogallery/267fANA123IMG-20231120-WA0023.jpg',
          'http://adminpanel.inventive.in/images/photogallery/9952ANA123IMG-20231120-WA0017.jpg',
          'http://adminpanel.inventive.in/images/photogallery/8461ANA123IMG-20231120-WA0019.jpg',
          'http://adminpanel.inventive.in/images/photogallery/536cANA123IMG-20231120-WA0020.jpg',
          'http://adminpanel.inventive.in/images/photogallery/a313ANA123IMG-20231120-WA0013.jpg',
          'http://adminpanel.inventive.in/images/photogallery/fb5cANA123IMG-20231120-WA0005.jpg',
          'http://adminpanel.inventive.in/images/photogallery/7283ANA123IMG-20231120-WA0008.jpg'
        ];
      case 'DANDIYA UTSAV 2023 at A.N.A Group Of Institutions':
        return [
          'http://adminpanel.inventive.in/images/photogallery/303cANA123XlD_6vMiXZjgAnUupGQK0yJTxt0ur9xcn72o6UcSb6I=_plaintext_638342346774753322.jpg',
          'http://adminpanel.inventive.in/images/photogallery/89a0ANA123coverimage.jpg',
          'http://adminpanel.inventive.in/images/photogallery/3e78ANA123hKMDkhrNwCqicQMUUAtJ9PVJm7GiqB6dg1ikYL5gdaA=_plaintext_638342346774753322.jpg',
          'http://adminpanel.inventive.in/images/photogallery/c26bANA123pnlo8WSjkVsM3qR5rnV4UB10hQATlMM-yaGIOelbjvw=_plaintext_638342346774753322.jpg',
          'http://adminpanel.inventive.in/images/photogallery/71c1ANA123dzwcTrfLh23mbb56h0uirYV9ul-UtYkJWOEv67vt_O4=_plaintext_638342346774586680.jpg',
          'http://adminpanel.inventive.in/images/photogallery/2a8aANA123nth17ZUv2Dcie9pdJkxPLg1ZeCJZG05y_vznreqatnE=_plaintext_638342346774586680.jpg',
          'http://adminpanel.inventive.in/images/photogallery/71c1ANA123dzwcTrfLh23mbb56h0uirYV9ul-UtYkJWOEv67vt_O4=_plaintext_638342346774586680.jpg',
          'http://adminpanel.inventive.in/images/photogallery/bde0ANA123MCxD4ZnPmUnNIr2chWbuL8oujGC1I8okOL1-Wuw2_Sc=_plaintext_638342346774753322.jpg',
          'http://adminpanel.inventive.in/images/photogallery/68a4ANA123BIlA8rXzq2YiHPSukV-hiB_zRz1QVDoJlckf1gAxqas=_plaintext_638342346774753322.jpg',
          'http://adminpanel.inventive.in/images/photogallery/2a8aANA123nth17ZUv2Dcie9pdJkxPLg1ZeCJZG05y_vznreqatnE=_plaintext_638342346774586680.jpg',
          'http://adminpanel.inventive.in/images/photogallery/81d1ANA123v-wv2U7wHtoE-b2_Hx7NN0Ze4zR4WxdlaR8EvN1N6yo=_plaintext_638342346774753322.jpg'

        ];
      case 'World Pharmacist Day_2023':
        return[
          'http://adminpanel.inventive.in/images/photogallery/7c8eANA123coverimage.jpg',
          'http://adminpanel.inventive.in/images/photogallery/33a1ANA123WhatsAppImage2023-09-26at13.00.55.jpg',
          'http://adminpanel.inventive.in/images/photogallery/e292ANA123IMG-20230926-WA0026.jpg',
          'http://adminpanel.inventive.in/images/photogallery/f62fANA123IMG-20230926-WA0024.jpg',
          'http://adminpanel.inventive.in/images/photogallery/43c7ANA123IMG-20230926-WA0022.jpg',
          'http://adminpanel.inventive.in/images/photogallery/fd95ANA123IMG-20230926-WA0021.jpg',
          'http://adminpanel.inventive.in/images/photogallery/8eaaANA123IMG-20230926-WA0019.jpg',
          'http://adminpanel.inventive.in/images/photogallery/90c1ANA123WhatsAppImage2023-09-26at12.58.21.jpg',
          'http://adminpanel.inventive.in/images/photogallery/cb60ANA123WhatsAppImage2023-09-26at12.56.46.jpg'

        ];
      case 'Engineer`s Day_2023': return[
        'http://adminpanel.inventive.in/images/photogallery/3735ANA123IMG-20230916-WA0034.jpg',
        'http://adminpanel.inventive.in/images/photogallery/2bceANA123coverimage.jpg',
        'http://adminpanel.inventive.in/images/photogallery/4804ANA123IMG_1315.jpg',
        'http://adminpanel.inventive.in/images/photogallery/93d5ANA123IMG_1330.jpg',
        'http://adminpanel.inventive.in/images/photogallery/f0c2ANA123IMG-20230916-WA0027.jpg'
      ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> folderContents = getFolderContents();

    return Scaffold(
      appBar: AppBar(
        title: Text(folderName),
      ),
      body: ListView.builder(
        itemCount: folderContents.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Image.network(
              folderContents[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
