import 'dart:convert';

import 'package:addistutor_tutor/Wallet/topuppage.dart';
import 'package:addistutor_tutor/constants.dart';
import 'package:addistutor_tutor/controller/walletcontroller.dart';
import 'package:addistutor_tutor/remote_services/service.dart';
import 'package:addistutor_tutor/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

final WalletContoller walletContoller = Get.put(WalletContoller());

class _EditProfilePageState extends State<WalletPage> {
  late Balance? balance;
  var ids;
  @override
  void initState() {
    _fetchUser();

    super.initState();
  }

  void _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      var body = json.decode(token);

      if (body["teacher_id"] != null) {
        setState(() {
          ids = int.parse(body["teacher_id"]);
          walletContoller.getbalance(ids);
          walletContoller.gettransaction(ids);
        });

        print("yes Id");
      } else {
        var noid = "noid";
        print("no Id");
      }
    } else {
      print("no Token");
    }
  }

  var balancewallet = 10;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    setState(() {
      // _getlocation();
      _fetchUser();
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));

    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => walletContoller.isfetchedtransaction.value
        ? SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,

            //cheak pull_to_refresh
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                color: kPrimaryColor,
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                walletContoller.wallet.toString() + ' birr',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 29,
                                    fontWeight: FontWeight.w700),
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 16,
                                    ),
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                        child: Image.network(
                                          'https://tutor.oddatech.com/api/teacher-profile-picture/${ids}',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Text(
                            "Available Balance",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.blue[100]),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push<dynamic>(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                      builder: (BuildContext context) =>
                                          TopUpPage(),
                                    ),
                                  );
                                },
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                243, 245, 248, 1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(18))),
                                        child: Icon(
                                          Icons.trending_down,
                                          color: Colors.blue[900],
                                          size: 30,
                                        ),
                                        padding: EdgeInsets.all(12),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Topup",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            color: Colors.blue[100]),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    DraggableScrollableSheet(
                      builder: (context, scrollController) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(243, 245, 248, 1),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 24,
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Recent Transactions",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 32),
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  child: Text(
                                    "Recent",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey[500]),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 32),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                ListView.builder(
                                  physics: const ScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final Transaction transaction =
                                        walletContoller.listtransaction[index];
                                    return Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 32),
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Row(
                                        children: <Widget>[
                                          Stack(children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 4,
                                                      color: Theme.of(context)
                                                          .scaffoldBackgroundColor),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        spreadRadius: 2,
                                                        blurRadius: 10,
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        offset:
                                                            const Offset(0, 10))
                                                  ],
                                                  color: Colors.grey[100],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(18))),
                                              child: Icon(
                                                Icons.account_balance_wallet,
                                                color: Colors.lightBlue[900],
                                              ),
                                              padding: EdgeInsets.all(12),
                                            ),
                                          ]),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "Payment Success",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.grey[900]),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                transaction.amount + " Birr",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.lightGreen),
                                              ),
                                              Text(
                                                "26 Jan",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.grey[500]),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount:
                                      walletContoller.listtransaction.length,
                                  padding: EdgeInsets.all(0),
                                ),
                              ],
                            ),
                            controller: scrollController,
                          ),
                        );
                      },
                      initialChildSize: 0.65,
                      minChildSize: 0.65,
                      maxChildSize: 1,
                    )
                  ],
                ),
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator()));
  }
}
