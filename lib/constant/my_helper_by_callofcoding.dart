
// this file is created by callofcoding
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_mpesa/dart_mpesa.dart';

import '../models/withdraw_request_model.dart';

Stream<QuerySnapshot<Map<String, dynamic>>> getWithdrawStream(){
    return FirebaseFirestore.instance.collection('withdrawRequests').where('requestStatus',isEqualTo: 'pending').snapshots();
}


Future<void> approvePayment(WithdrawRequestModel withdrawRequest)async{

    if(withdrawRequest.paymentMethod == 'Bank Transfer'){

      await acceptPayment(withdrawRequest);

    }else if(withdrawRequest.paymentMethod == 'M-pesa'){
      await sendMoneyFromMpesa(withdrawRequest.amount!).then((value) async {
        if(value){
          await acceptPayment(withdrawRequest);
        }else{
          await rejectPayment(withdrawRequest);
        }
      });

    }else{
        throw Exception('withdraw payment method not supported ${withdrawRequest.paymentMethod}');
    }

}


Future<void> rejectPayment(WithdrawRequestModel withdrawRequest)async{
  await _updatePaymentStatus(hostId: withdrawRequest.hostId!, date: withdrawRequest.dateTime!, paymentStatus: 'reject', paymentAmount: withdrawRequest.amount!);
}

Future<void> acceptPayment(WithdrawRequestModel withdrawRequest)async{
  await _updatePaymentStatus(hostId: withdrawRequest.hostId!, date: withdrawRequest.dateTime!, paymentStatus: 'accept', paymentAmount: withdrawRequest.amount!);

}






Future<void> _updatePaymentStatus(
    {required String hostId, required String date, required String paymentStatus, String? rejectionMsg,required double paymentAmount})async{

    if(paymentStatus == 'accept'){
        await FirebaseFirestore.instance.collection('withdrawRequests').doc(hostId).update({"requestStatus" : paymentStatus});
        await FirebaseFirestore.instance.collection('users').doc(hostId).get().then((value) async {
            Map<String,dynamic> userMap = value.data()!;
           List<dynamic> paymentHistoryList = userMap['hostWallet']['paymentHistory'];

           // getting the index where we want to change status
            int index = paymentHistoryList.indexWhere((element) => element['id'] == date);


            // changing payment status
           paymentHistoryList[index]['paymentMethod'] = paymentStatus.toUpperCase();

            // updating main list of paymentHistory

            await FirebaseFirestore.instance.collection('users').doc(hostId).update({'hostWallet' : {"paymentHistory" : paymentHistoryList,"date" : userMap['hostWallet']['date'],"currentBalance":userMap['hostWallet']['currentBalance']}});

            print('--------COMPLETE--------');
    });

    }else if ( paymentStatus == 'reject'){
      await FirebaseFirestore.instance.collection('withdrawRequests').doc(hostId).update({"requestStatus" : paymentStatus});
      await FirebaseFirestore.instance.collection('users').doc(hostId).get().then((value) async {
        Map<String,dynamic> userMap = value.data()!;
        List<dynamic> paymentHistoryList = userMap['hostWallet']['paymentHistory'];

        // getting the index where we want to change status
        int index = paymentHistoryList.indexWhere((element) => element['id'] == date);


        // changing payment status
        paymentHistoryList[index]['paymentMethod'] = paymentStatus.toUpperCase();

        // updating main list of paymentHistory

        await FirebaseFirestore.instance.collection('users').doc(hostId).update({'hostWallet' : {"paymentHistory" : paymentHistoryList,"date" : userMap['hostWallet']['date'],"currentBalance": (userMap['hostWallet']['currentBalance'] +  paymentAmount) }});

        print('--------COMPLETE -- Rejection--------');
      });



    }else{
        throw Exception('payment status not supported $paymentStatus');
    }

}


Future<bool> sendMoneyFromMpesa(double amount)async{
 Mpesa mpesa = Mpesa(
      shortCode: "601426",
      consumerKey: "VxSb94SoPku6ugjAAkwqDJoyTSWzXFQmsX8jtmrQsGpnI6rQ",
      consumerSecret: "3iHObDhr69hGXYYKi32aHP5zWztEEGG8rbtdPyEiTsZlShTxoYur0c7DrMg3kChE",
      initiatorName: "apitest361",
      securityCredential: "LLnW6FVFKl5sSkbRt2VT5z2vFyK6D2Wf/60t0SuE6s/TZwvPTftIJ5Tkgx+6FEbbMFf3gzCCm51WvXxszvdvW99winbpILVELw0gLK+s+8q8oH8n0MuD7BG9n9vOV0jCcEmW2hEr/ZgT9dstREh20dd6t8VBftUt+8lpeMtkuVdQVdpclteekIoRtt+C3ez+hsoLrZ4EgMl1kU5Mf721xi9f7058yaVTbObN3Y9NeqBUbSeGUfrEeDXgFjLaaActDA2y7tiC2j4LlrzOpS+V5zDZgfiUq+25DPj5Ct1eDtOPESMqwaYfIVRWivWH2mEeO3jG6W0ZoMll+3l8cEOk3Q==",
      passKey: "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919",
      identifierType: IdentifierType.OrganizationShortCode, // Type of organization, options, OrganizationShortCode, TillNumber, OrganizationShortCode
      applicationMode: ApplicationMode.test
  );



  MpesaResponse _res = await mpesa.b2cTransaction(
      phoneNumber: '254708374149',
      amount: amount,
      remarks: 'Careno',
      occassion: 'work',
      queueTimeOutURL: 'https://peternjeru.co.ke/safdaraja/api/callback.php',
      resultURL: 'https://peternjeru.co.ke/safdaraja/api/callback.php'
  );

  if(_res.statusCode == 200){
    return true;
  }else{
    return false;
  }
}