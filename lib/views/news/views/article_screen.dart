import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../consts/app_text_styles/news_text_style.dart';
import '../../../consts/app_text_styles/synopsis_text_style.dart';
import '../../../data/models/news_model.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key, required this.newsModel});

  final NewsModel newsModel;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        elevation: 0,
        title: const Text(
          'Назад',
          style: SynopsisTextStyle.appbar,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: SvgPicture.asset(
            'assets/icons/arrow.svg',
            width: screenSize.width * 0.08,
            height: screenSize.width * 0.08,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: screenSize.height * 0.3,
              width: screenSize.width * 0.9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: FancyShimmerImage(
                  boxFit: BoxFit.cover,
                  imageUrl: newsModel.imageUrl,
                ),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.05,
                  vertical: screenSize.width * 0.01),
              child: Text(
                newsModel.title,
                style: NewsTextStyle.articleTitle,
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(screenSize.width * 0.05),
                child: Text(
                  newsModel.text,
                  style: NewsTextStyle.articleText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
