import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';


Widget buildSkeleton(BuildContext context) => Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade800),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SkeletonContainer.rounded(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 15,
              ),
              const SizedBox(height: 8),
              SkeletonContainer.rounded(
                width: 60,
                height: 13,
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: <Widget>[
              SkeletonContainer.rounded(
                width: MediaQuery.of(context).size.width * 0.90,
                height: 50,
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SkeletonContainer.rounded(
                width: 50,
                height: 30,
              ),
              SkeletonContainer.rounded(
                width: 50,
                height: 30,
              ),
              SkeletonContainer.rounded(
                width: 50,
                height: 30,
              ),
            ],
          ),
        ],
      ),
    ),
  ),
);



class SkeletonContainer extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const SkeletonContainer._({
    this.width = double.infinity,
    this.height = double.infinity,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    Key key,
  }) : super(key: key);

  const SkeletonContainer.square({
    double width,
    double height,
  }) : this._(width: width, height: height);

  const SkeletonContainer.rounded({
    double width,
    double height,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(12)),
  }) : this._(width: width, height: height, borderRadius: borderRadius);

  const SkeletonContainer.circular({
    double width,
    double height,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(80)),
  }) : this._(width: width, height: height, borderRadius: borderRadius);

  @override
  Widget build(BuildContext context) => SkeletonAnimation(
    //gradientColor: Colors.orange,
    //shimmerColor: Colors.red,
    //curve: Curves.easeInQuad,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: borderRadius,
      ),
    ),
  );
}