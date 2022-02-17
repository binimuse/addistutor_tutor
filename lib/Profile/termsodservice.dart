import 'package:addistutor_tutor/Home/components/design_course_app_theme.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ProductDescriptionPage extends StatefulWidget {
  final String name, image;

  const ProductDescriptionPage({Key? key, this.name = '', this.image = ''})
      : super(key: key);
  @override
  _ProductDescriptionPageState createState() => _ProductDescriptionPageState();
}

class _ProductDescriptionPageState extends State<ProductDescriptionPage> {
  // initialize reusable widget

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 4);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Material(
            color: Colors.white,
            child: InkWell(
              borderRadius:
                  BorderRadius.circular(AppBar().preferredSize.height),
              child: const Icon(
                Icons.arrow_back_ios,
                color: DesignCourseAppTheme.nearlyBlack,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: const Text(
            "Terms of Service ",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'WorkSans',
            ),
          ),
        ),
        body: ListView(
          children: [
            _createProductImageAndTitle(boxImageSize),
            Divider(height: 0, color: Colors.grey[400]),
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                "1. Payment \nPayment will be made monthly. You are responsible for submitting your monthly invoice within 5 working days after the end of the month. NextGen will not be responsible for any delays on payment if you fail to submit your invoice in time.\n\n"
                '2. Siblings\nA sibling can join a session provided that s/he is in the same category (KG, first cycle primary, second cycle primary, secondary or Preparatory) as the child to whom the service is requested. In such instances no additional payment is required. However, if the sibling is not in the same category or it is more than one sibling, a separate booking needs to be made.\n\n'
                '3. Set up\nYou may wait a maximum of 20 minutes from the agreed start time in rare cases where children are not ready. If session starts more than 20 minutes later, you have the right to finish the session at the originally agreed time and charge for the whole session.  \n\n'
                '4. Cancellation and tardiness\nYou can cancel or postpone a session 24 hours in advance at no cost. However, cancellations or postponements less than 24 hours will result in a penalty of ETB 100 for each session.  If you arrive more than 20 minutes later than the agreed start time for a session, parents have the right to cancel the session. Whether the session proceeds or is cancelled, you will be penalized ETB 50 per incident. If you are penalized three times within three months, you will be suspended for six months.   \n\n'
                '5. Confirmation of service delivery\n Parents have the responsibility to ensure that the QR code is available for scanning at the end of each session as a way of confirmation of service delivery. If the QR code is not scanned for any reason, the system will automatically assume that service has successfully been delivered and deduct payment from the available balance. If the tutor is absent, it is your responsibility to inform the office before the system automatically deducts from your balance. \n\n'
                '6. Treatment of children\nYou agree to NextGen’s child protection and safeguarding policy. Any reports of mistreatment of children will be taken seriously and may result in temporary or permanent suspension and even legal action.\n\n'
                '7. Dressing code\nTutors should dress up in decency for their tutorial. What is not normally accepted in the classroom will not be accepted during tutorials. \n\n'
                '8. Liability\nevent shall the aggregate liability of NextGen exceed the amount paid for a session.  \n\n'
                '9. Dealing with a parent/child outside of the system\nAll dealings with a parent/child should be done through NextGen. This includes schedule arrangement, additional bookings, payment, etc. If a tutor deals with a parent/child without the knowledge of the company, NextGen won’t take any responsibility whatsoever. Parents and tutors found doing this will be barred from using NextGen Tutorial Services.  \n\n'
                '10.Confidentiality\nAny confidential information about the child, his/her parents and family you may come across as a result of your tutorial service cannot be shared with third parties without the express consent of the child/parent. NextGen has the right to terminate the tutor if found guilty of breaching the confidentiality statement.  \n\n',
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.4,
                  height: 0.9,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ));
  }

  Widget _createProductImageAndTitle(boxImageSize) {
    return Container(
        margin: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                child: Image.asset('assets/images/lg3.png',
                    width: boxImageSize, height: boxImageSize)),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "NextGen Tutorial Services",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.4,
                      height: 0.9,
                      color: kPrimaryColor,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
