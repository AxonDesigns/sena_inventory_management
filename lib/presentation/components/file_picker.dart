import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/presentation/presentation.dart';

class AxFilePicker extends ConsumerStatefulWidget {
  const AxFilePicker({
    super.key,
    this.multiSelect = false,
    this.focusNode,
  });
  final bool multiSelect;
  final FocusNode? focusNode;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FilePickerState();
}

class _FilePickerState extends ConsumerState<AxFilePicker> {
  late final _focusNode = widget.focusNode ?? FocusNode();
  final _files = <PlatformFile>[];

  @override
  Widget build(BuildContext context) {
    return FieldContainer(
      focusNode: _focusNode,
      builder: (states) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /* TextField(
              focusNode: _focusNode,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(12.0),
                border: InputBorder.none,
                filled: false,
                hoverColor: Colors.transparent,
              ),
            ), */
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('File Picker'),
            ),
            const Divider(
              height: 1,
              indent: 0,
              endIndent: 0,
            ),
            if (_files.isNotEmpty)
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 250),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _files.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        _files[index].name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        _files[index].path ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.file(
                          File(_files[index].path!),
                          isAntiAlias: true,
                          filterQuality: FilterQuality.medium,
                        ),
                      ),
                      trailing: const Icon(Icons.delete),
                      onTap: () {
                        _files.removeAt(index);
                        setState(() {});
                      },
                      contentPadding: const EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 5),
                    );
                  },
                ),
              ),
            if (_files.isNotEmpty && widget.multiSelect)
              const Divider(
                height: 1,
                indent: 0,
                endIndent: 0,
              ),
            if ((!widget.multiSelect && _files.isEmpty) || widget.multiSelect)
              Button.ghost(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    _files.addAll(result.files);
                  }
                },
                children: const [
                  Icon(FluentIcons.arrow_download_16_regular),
                  Text('Pick files...'),
                ],
              ),
          ],
        );
      },
    );
  }
}
