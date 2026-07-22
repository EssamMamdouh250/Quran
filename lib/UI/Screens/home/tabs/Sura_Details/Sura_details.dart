import 'package:flutter/material.dart';
import 'package:quran/UI/Screens/utilites/AssetsManeger.dart';
import 'package:quran/UI/Screens/utilites/appColors.dart';
import 'package:quran/UI/Screens/utilites/quranlist.dart';

class SuraDetails extends StatefulWidget {
  static const routeName = 'Sura_details';

  final String suraName;
  final int suraIndex;
  final List<String> verses;

  const SuraDetails({
    super.key,
    required this.suraName,
    required this.suraIndex,
    required this.verses,
  });

  @override
  State<SuraDetails> createState() => _SuraDetailsState();
}

class _SuraDetailsState extends State<SuraDetails> {
  static const _verseStyle = TextStyle(
    fontSize: 20,
    height: 2,
    color: AppColors.black,
  );

  static const _bismillahStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  List<List<String>>? _cachedPages;
  double? _cachedWidth;
  double? _cachedHeight;
  
  TextSpan _measureSpanFor(String verseText, int verseNumber) {
    return TextSpan(
      text: "$verseText  ⚬$verseNumber⚬  ",
      style: _verseStyle,
    );
  }

  double _measureHeight(List<TextSpan> spans, double maxWidth) {
    final painter = TextPainter(
      text: TextSpan(children: spans),
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
    );
    painter.layout(maxWidth: maxWidth);
    return painter.height;
  }

  List<List<String>> _paginate({
    required double maxWidth,
    required double firstPageHeight,
    required double otherPagesHeight,
  }) {
    final pages = <List<String>>[];
    var currentVerses = <String>[];
    var currentSpans = <TextSpan>[];
    var verseNumber = 1;

    const safetyFactor = 0.92;

    for (final verse in widget.verses) {
      final newSpan = _measureSpanFor(verse, verseNumber);
      final tentativeSpans = [...currentSpans, newSpan];
      final height = _measureHeight(tentativeSpans, maxWidth);
      final budget =
          (pages.isEmpty ? firstPageHeight : otherPagesHeight) * safetyFactor;

      if (height <= budget || currentVerses.isEmpty) {
        currentSpans = tentativeSpans;
        currentVerses = [...currentVerses, verse];
      } else {
        pages.add(currentVerses);
        currentSpans = [newSpan];
        currentVerses = [verse];
      }
      verseNumber++;
    }
    if (currentVerses.isNotEmpty) pages.add(currentVerses);
    if (pages.isEmpty) pages.add([]);
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    String arabicSuraName = Constantas.arabicAuranSuras[widget.suraIndex];
    bool showBismillah = widget.suraIndex != 0 && widget.suraIndex != 8;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 217, 197),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetsManager.suraName),
                  ),
                ),
                child: Center(
                  child: SizedBox(
                    height: 60,
                    child: Center(
                      child: Text(
                        arabicSuraName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final maxWidth = constraints.maxWidth - 20;
                  final maxHeight = constraints.maxHeight;

                  double bismillahHeight = 0;
                  if (showBismillah) {
                    final bp = TextPainter(
                      text: const TextSpan(
                        text: "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ ",
                        style: _bismillahStyle,
                      ),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                    )..layout(maxWidth: maxWidth);
                    bismillahHeight = bp.height + 10;
                  }

                  if (_cachedPages == null ||
                      _cachedWidth != maxWidth ||
                      _cachedHeight != maxHeight) {
                    _cachedPages = _paginate(
                      maxWidth: maxWidth,
                      firstPageHeight: maxHeight - bismillahHeight,
                      otherPagesHeight: maxHeight,
                    );
                    _cachedWidth = maxWidth;
                    _cachedHeight = maxHeight;
                  }

                  final pages = _cachedPages!;

                  return PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: pages.length,
                    itemBuilder: (context, pageIndex) {
                      final pageVerses = pages[pageIndex];
                      final verseOffset = pages
                          .sublist(0, pageIndex)
                          .fold<int>(0, (sum, p) => sum + p.length);

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            if (pageIndex == 0 && showBismillah)
                              const Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ ",
                                  style: _bismillahStyle,
                                ),
                              ),
                            Expanded(
                              child: RichText(
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                                text: TextSpan(
                                  children: [
                                    for (int i = 0; i < pageVerses.length; i++) ...[
                                      TextSpan(
                                        text: "${pageVerses[i]} ",
                                        style: _verseStyle,
                                      ),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 4,
                                          ),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Image.asset(
                                                AssetsManager.ayaNumer,
                                                width: 32,
                                                height: 32,
                                              ),
                                              Text(
                                                "${verseOffset + i + 1}",
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}