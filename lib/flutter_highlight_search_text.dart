library flutter_highlight_search_text;

import 'package:flutter/material.dart';

class SearchHighlightText extends StatelessWidget {
  final String text;
  final String query;
  final TextStyle? textStyle;
  final TextStyle? highlightTextStyle;
  final int? maxLines;

  const SearchHighlightText(
      {super.key,
      required this.text,
      required this.query,
      this.textStyle,
      this.highlightTextStyle,
      this.maxLines});

  final TextStyle defaultTextStyle = const TextStyle(
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  final TextStyle defaultHighlightTextStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: Colors.blue,
  );

  @override
  Widget build(BuildContext context) {
    // Use the provided function to split the text and find the query position.
    final result = _splitTextAndFindQueryPosition(text, query.trimRight());
    final List<String> splitText = result['splitText'];
    final int queryIndex = result['queryIndex'];

    // Build the TextSpans based on the split text and query position.
    List<TextSpan> textSpans = [];

    for (int i = 0; i < splitText.length; i++) {
      textSpans.add(
        TextSpan(
            text: splitText[i],
            style: i == queryIndex
                ? (highlightTextStyle ?? defaultHighlightTextStyle)
                : (textStyle ?? defaultTextStyle)),
      );
    }

    return RichText(
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: textSpans,
        style: DefaultTextStyle.of(context).style,
      ),
    );
  }
}

/// Functions
Map<String, dynamic> _splitTextAndFindQueryPosition(
    String actualText, String query) {
  // Initialize an empty list to hold the parts of the text.
  List<String> splitText = [];
  int queryIndex = -1;

  // Check if the query is empty or does not exist in the actualText.
  if (query.trim().isEmpty ||
      !actualText.toLowerCase().contains(query.toLowerCase())) {
    splitText = [actualText];
    return {
      'splitText': splitText,
      'queryIndex': queryIndex,
    };
  }

  // Find the first occurrence of the query.
  String lowerCaseActualText = actualText.toLowerCase();
  String lowerCaseQuery = query.toLowerCase();
  queryIndex = lowerCaseActualText.indexOf(lowerCaseQuery);

  if (queryIndex != -1) {
    // Split the text into three parts.
    String beforeQuery = actualText.substring(0, queryIndex);
    String afterQuery = actualText.substring(queryIndex + query.length);
    String queryMain = _getCaseSensitiveSubstring(actualText, query);
    // Add the parts to the splitText list.
    splitText.add(beforeQuery);
    splitText.add(queryMain);
    splitText.add(afterQuery);

    return {
      'splitText': splitText,
      'queryIndex': 1, // The query is at index 1 in the splitText list.
    };
  }

  // If the query is not found (just in case).
  splitText = [actualText];
  return {
    'splitText': splitText,
    'queryIndex': queryIndex,
  };
}

String _getCaseSensitiveSubstring(String text, String word) {
  // Convert both text and word to lower case for case-insensitive search.
  String lowerText = text.toLowerCase();
  String lowerWord = word.toLowerCase();

  // Find the case-insensitive index of the word.
  int index = lowerText.indexOf(lowerWord);

  // If the word is found, extract the substring with its original case.
  if (index != -1) {
    return text.substring(index, index + word.length);
  }

  // If the word is not found, return an empty string or handle it as needed.
  return '';
}
