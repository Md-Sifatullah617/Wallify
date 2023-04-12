import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void successToastMessage(msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
}

void errorToastMessage(msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
}



// class Loading extends StatelessWidget {
//   const Loading({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         loadMore();
//       },
//       child: Container(
//         height: 60,
//         width: double.infinity,
//         color: Colors.black,
//         child: const Center(
//             child: Text(
//           "Load More",
//           style: TextStyle(fontSize: 20, color: Colors.white),
//         )),
//       ),
//     );
//   }
// }