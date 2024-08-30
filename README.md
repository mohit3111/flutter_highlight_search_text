# flutter_highlight_search_text

**flutter_highlight_search_text** is a Flutter package designed to highlight search text within a string. It provides a customizable and efficient way to emphasize specific portions of text, making it ideal for search functionalities and text displays.

## Features

- **Customizable Text and Highlight Styles:**
    - Easily apply custom text styles for both the regular and highlighted portions of your text. Set your preferred colors, fonts, sizes, and more.

- **Supports Case-Insensitive Matching:**
    - The widget can highlight text regardless of the case, ensuring that all instances of the search query are highlighted correctly.

- **Efficient Text Splitting:**
    - Optimized for splitting and finding the query within the text, ensuring smooth performance even with large strings.

- **Flexible Max Lines:**
    - Control the number of lines displayed with the `maxLines` parameter, allowing text to be truncated with ellipsis when necessary.

- **Handles Edge Cases:**
    - The widget gracefully handles cases where the search query is empty or not found within the text, ensuring consistent behavior.

- **Easy Integration:**
    - Simply drop the `SearchHighlightText` widget into your app and customize it according to your needs with a few lines of code.
    - 
## Getting started

To use this package, follow these steps:

1. **Add the Dependency:**

   Add `flutter_highlight_search_text` to your `pubspec.yaml` file:

## Usage

```dart
  SearchHighlightText(
text: 'This is text',
query: "text",
),

```