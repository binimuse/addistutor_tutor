import 'package:flutter/material.dart';

class ActivityItemWidget extends StatelessWidget {
  const ActivityItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).cardColor,
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
            child: Row(
              children: <Widget>[
                const CircleAvatar(
                    maxRadius: 19,
                    backgroundImage: AssetImage('assets/images/profile2.jpg')),
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Robel musema ',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                          TextSpan(
                              text: ' Booked Tutor',
                              style: Theme.of(context).textTheme.subtitle1),
                          TextSpan(
                              text: ' 23/feb',
                              style: Theme.of(context).textTheme.subtitle1),
                        ])))),
              ],
            ),
          ),
          onTap: () {},
        ));
  }
}
