import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_editor_plus/data/layer.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'colors_picker.dart';

class TextLayerOverlay extends StatefulWidget {
  final int index;
  final TextLayerData layer;
  final Function onUpdate;
  final TextEditingController controller;

  const TextLayerOverlay({
    Key? key,
    required this.layer,
    required this.index,
    required this.onUpdate,
    required this.controller,
  }) : super(key: key);

  @override
  createState() => _TextLayerOverlayState();
}

class _TextLayerOverlayState extends State<TextLayerOverlay> {
  double slider = 0.0;

  ScrollController sc = ScrollController();

  @override
  void initState() {
    //  slider = widget.sizevalue;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Center(
            child: Text(
              i18n('Caption').toUpperCase(),
              style: const TextStyle(color: Colors.black),
            ),
          ),
          const Divider(),
          Slider(
              activeColor: Colors.black,
              inactiveColor: Colors.grey,
              value: widget.layer.size,
              min: 0.0,
              max: 100.0,
              onChangeEnd: (v) {
                setState(() {
                  widget.layer.size = v.toDouble();
                  widget.onUpdate();
                });
              },
              onChanged: (v) {
                setState(() {
                  slider = v;
                  // print(v.toDouble());
                  widget.layer.size = v.toDouble();
                  widget.onUpdate();
                });
              }),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SingleChildScrollView(
                controller: sc,
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: TextField(
                          controller: widget.controller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Insert Your Message',
                            hintStyle: TextStyle(color: Colors.black),
                            alignLabelWithHint: true,
                          ),
                          scrollPadding: const EdgeInsets.all(20.0),
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 5,
                          style: TextStyle(
                            color: widget.layer.color,
                          ),
                          autofocus: true,
                          onChanged: (value) {
                            setState(() {
                              widget.layer.text = value;
                              widget.onUpdate();
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  i18n('Color'),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              Row(children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: BarColorPicker(
                      width: 300,
                      thumbColor: Colors.white,
                      initialColor: widget.layer.color,
                      cornerRadius: 10,
                      pickMode: PickMode.color,
                      colorListener: (int value) {
                        setState(() {
                          widget.layer.color = Color(value);
                          widget.onUpdate();
                        });
                      },
                    ),
                  ),
                ),
              ]),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  i18n('Background Color'),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              Row(children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: BarColorPicker(
                      width: 300,
                      initialColor: widget.layer.background,
                      thumbColor: Colors.white,
                      cornerRadius: 10,
                      pickMode: PickMode.color,
                      colorListener: (int value) {
                        setState(() {
                          widget.layer.background = Color(value);
                          widget.onUpdate();
                        });
                      },
                    ),
                  ),
                ),
              ]),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  i18n('Background Opacity'),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              Row(children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Slider(
                      min: 0,
                      max: 255,
                      divisions: 255,
                      value: widget.layer.backgroundOpacity.toDouble(),
                      thumbColor: Colors.white,
                      onChanged: (double value) {
                        setState(() {
                          widget.layer.backgroundOpacity = value.toInt();
                          widget.onUpdate();
                        });
                      },
                    ),
                  ),
                ),
              ]),
            ]),
          ),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  removedLayers.add(layers.removeAt(widget.index));
                  Navigator.pop(context);
                  widget.onUpdate();
                },
                child: Text(
                  i18n('Delete'),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
