import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../consts/app_text_styles/synopsis_text_style.dart';
import '../../../data/models/news_model.dart';
import '../../../util/app_routes.dart';
import '../../app/widgets/banner_widget.dart';
import '../widgets/news_item_widget.dart';

class SynopsisScreen extends StatelessWidget {
  const SynopsisScreen({super.key, required this.newsModel});
  final List<NewsModel> newsModel;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Привет!',
            style: SynopsisTextStyle.appbar,
          ),
          actions: [
            IconButton(
              iconSize: 24,
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.profile);
              },
              icon: SvgPicture.asset('assets/icons/profile.svg'),
            ),
          ],
        ),
        body: Container(
          child: Column(children: [
            OperationBanner(),
            Expanded(
              child: ListView.builder(
                itemCount: newsModel.length,
                itemBuilder: (BuildContext context, int index) {
                  return NewsItemWidget(newsModel: newsModel[index]);
                },
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
          ]),
        ));
  }
}
