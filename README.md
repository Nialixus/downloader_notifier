<p align="center">
  <img src="https://user-images.githubusercontent.com/45191605/272785686-7a626063-6047-463a-b931-db256c708335.png" alt="Downloader Notifier Logo" width="150">
</p>

# Type Writer Text

<a href='https://pub.dev/packages/downloader_notifier'><img src='https://img.shields.io/pub/v/downloader_notifier.svg?logo=flutter&color=blue&style=flat-square'/></a>
<a href="https://codecov.io/gh/Nialixus/downloader_notifier"><img src="https://codecov.io/gh/Nialixus/downloader_notifier/graph/badge.svg?token=T66X1R33QE"/></a>
<a href="https://github.com/Nialixus/downloader_notifier/actions"><img src="https://github.com/Nialixus/downloader_notifier/actions/workflows/test_coverage.yaml/badge.svg" alt="test"/></a>
\
\
A floating bar for real-time download progress updates, designed for both Android and iOS.

## Preview

<img src="https://github.com/user-attachments/assets/451d0265-dd2d-4134-807d-a02e1f17b8bb" alt="Downloader Notifier Preview" width="300">


## Install

Add this line to your pubspec.yaml.

```yaml
dependencies:
  downloader_notifier: ^1.0.0
```

## Usage

First, import the typewriter package.

```dart
import 'package:downloader_notifier/downloader_notifier.dart';
```
<!-- 
And use it like this

```dart
TypeWriter.text(
  'lorem ipsum dolot sit amet ...',
  duration: const Duration(milliseconds: 50),
);
```

And for the builder, you need to initiate a controller like this one.

```dart
final controller = TypeWriterController(text: 'Hello World',
  duration: const Duration(milliseconds: 50),
);

// also if you want the typewriter to not only changing
// the character but also words, you can use this controller.

final valueController = TypeWriterController.fromValue(
  TypeWriterValue([
    'First Paragraph',
    'Next Paragraph',
    'Last Paragraph',
  ]),
  duration: const Duration(milliseconds: 50),
);

// you can also integrate the controller with Stream<String> like this one.

final streamController = TypeWriterController.fromStream(
  StreamController<String>().stream
);

TypeWriter(
  controller: controller, // valueController // streamController
  builder: (context, value) {
    return Text(
      value.text,
      maxLines: 2,
      minFontSize: 2.0,
    );
  }
);
``` -->

## Documentation
<!-- 
### TypeWriter.text

| Property           | Purpose                                                                                                           |
| ------------------ | ----------------------------------------------------------------------------------------------------------------- |
| repeat             | Specifies whether the animation should repeat once completed (default is `false`).                                |
| enabled            | Is the flag to play the animation or not.                                                                         |
| maintainSize       | Specifies whether the size of the layout text should be maintained.                                               |
| duration           | Delay time between each character.                                                                                |
| alignment          | Alignment of the text layout.                                                                                     |
| text               | The text to be displayed during the typewriter animation.                                                         |
| onChanged          | Callback function for when the text is changed.                                                                   |
| textAlign          | Alignment of the text.                                                                                            |
| style              | Style of the text.                                                                                                |
| maxLines           | Maximum number of lines to be displayed.                                                                          |
| overflow           | Overflow behavior of the text.                                                                                    |
| semanticsLabel     | Semantics label of the text.                                                                                      |
| softWrap           | Specifies whether the text should break at soft line breaks.                                                      |
| strutStyle         | Strut style of the text.                                                                                          |
| locale             | Locale of the text.                                                                                               |
| textDirection      | Text direction of the text.                                                                                       |
| textHeightBehavior | Text height behavior of the text.                                                                                 |
| textWidthBasis     | Text width basis of the text.                                                                                     |
| selectionColor     | Color of the selection.                                                                                           |
| onFinished         | Is a callback that triggered when the animation is done. This requires [enabled] as `true` and repeat as `false`. |

### TypeWriter

| Property   | Purpose                                                                                                           |
| ---------- | ----------------------------------------------------------------------------------------------------------------- |
| controller | Controller that manage the animation. You can use `TypeWriterController` or `TypeWriterController.fromValue`.     |
| enabled    | Is the flag to play the animation or not.                                                                         |
| builder    | Builder that contains `TypeWriterValue` in sequence.                                                              |
| onFinished | Is a callback that triggered when the animation is done. This requires [enabled] as `true` and repeat as `false`. | -->

## Example

- <a href="https://github.com/Nialixus/downloader_notifier/blob/master/example/lib/main.dart">downloader_notifier/example/lib/main.dart</a>
