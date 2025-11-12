// // ignore_for_file: unnecessary_statements

// import 'package:flutter/material.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// import 'package:flutter_sms/flutter_sms.dart';
// import 'package:get/get.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:url_launcher/url_launcher.dart';

// class JobDetailModal extends StatelessWidget {
//   JobDetailModal({
//     Key? key,
//   }) : super(key: key);

//   final TextEditingController _addGroupController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     Color constGrey = Colors.grey;

//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(15),
//             child: Container(
//               width: 70,
//               height: 8,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: const Color.fromARGB(255, 204, 202, 202),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.03),
//                     spreadRadius: 10,
//                     blurRadius: 3,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
              
//             },
//             child: CustomJobDetail(
//               textTitle: 'Add Group'.tr,
//               textDescription: '',
//               iconData: Icons.group_add,
//               colorIcon: AppColors.backgroundColorButtonBlue,
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               Share.share(widget.cardDetails.company ?? '');
//             },
//             child: CustomJobDetail(
//               textTitle: 'Share'.tr,
//               textDescription: 'Share contacts'.tr,
//               iconData: Icons.share,
//               colorIcon: Colors.blueAccent,
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               FlutterPhoneDirectCaller.callNumber(
//                   widget.cardDetails.phone ?? '');
//             },
//             child: CustomJobDetail(
//               textTitle: 'Call'.tr,
//               textDescription: 'Call phone'.tr,
//               iconData: Icons.call,
//               colorIcon: Color.fromARGB(255, 89, 128, 5),
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               sendingSMS('', [widget.cardDetails.phone ?? '']);
//             },
//             child: CustomJobDetail(
//               textTitle: 'SMS'.tr,
//               textDescription: 'Send message'.tr,
//               iconData: Icons.sms,
//               colorIcon: Colors.blue,
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               launchMap(
//                 widget.cardDetails.address ?? '',
//               );
//             },
//             child: CustomJobDetail(
//               textTitle: 'Location'.tr,
//               textDescription: 'Check location contact'.tr,
//               iconData: Icons.location_on,
//               colorIcon: Colors.redAccent,
//             ),
//           ),
//           SizedBox(
//             height: 50,
//           )
//         ],
//       ),
//     );
//   }

//   void sendingSMS(String msg, List<String> listRecipients) async {
//     try {
//       String sendResult =
//           await sendSMS(message: msg, recipients: listRecipients);
//       print(sendResult);
//     } catch (err) {
//       SnackbarHelper.showSnackbar(context, 'No contact to send message'.tr);
//     }
//   }

//   Future<void> launchMap(String address) async {
//     final query = Uri.encodeComponent(address);
//     final url = 'https://www.google.com/maps/search/?api=1&query=$query';
//     // ignore: deprecated_member_use
//     if (await canLaunch(url)) {
//       // ignore: deprecated_member_use
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
// }
