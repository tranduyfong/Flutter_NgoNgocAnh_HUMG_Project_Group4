import 'package:flutter/material.dart';

class InternationalFootball extends StatefulWidget {
  const InternationalFootball({super.key});

  @override
  State<InternationalFootball> createState() => _InternationalFootball();
}

class _InternationalFootball extends State<InternationalFootball> {
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
