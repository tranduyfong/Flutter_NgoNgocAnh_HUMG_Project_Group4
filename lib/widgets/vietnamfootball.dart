import 'package:flutter/material.dart';

class VietNamFootBall extends StatefulWidget {
  const VietNamFootBall({super.key});

  @override
  State<VietNamFootBall> createState() => _VietNamFootBall();
}

class _VietNamFootBall extends State<VietNamFootBall> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 100,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    'Title $index',
                    style: TextTheme.of(context).headlineSmall,
                  ),
                ),
              ),
              Divider(
                height: 5,
              )
            ],
          );
        });
  }
}
