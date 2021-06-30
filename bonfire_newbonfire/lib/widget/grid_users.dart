import 'package:flutter/material.dart';

class GridUsers extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(30, (index) {
        return Center(
          child: Column(
            children: <Widget>[
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://picsum.photos/500/500?random=$index',
                    ),
                  )
                ),
              ),
              Text(
                'User $index',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        );
      }),
    );
  }
}
