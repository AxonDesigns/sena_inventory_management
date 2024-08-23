import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/core/core.dart';
import 'package:sena_inventory_management/presentation/presentation.dart';
import 'package:path/path.dart' as p;

class AxFilePicker extends ConsumerStatefulWidget {
  const AxFilePicker({
    super.key,
    required this.labelText,
    this.required = false,
    this.multiSelect = false,
    this.fileType = FileType.any,
    required this.files,
    required this.onChanged,
    this.focusNode,
  });

  final String labelText;
  final bool required;
  final bool multiSelect;
  final FocusNode? focusNode;
  final List<String> files;
  final FileType fileType;
  final void Function(List<String> files) onChanged;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FilePickerState();
}

class _FilePickerState extends ConsumerState<AxFilePicker> {
  late final _focusNode = widget.focusNode ?? FocusNode();
  //late final _files = List<String>.from(widget.files);

  @override
  Widget build(BuildContext context) {
    final files = widget.files;

    return FieldContainer(
      focusNode: _focusNode,
      handleHoveredState: false,
      builder: (states) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14.0, top: 10.0, bottom: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.labelText,
                      style: context.theme.textTheme.bodyMedium!.copyWith(color: context.theme.colorScheme.onSurface.withOpacity(0.5))),
                  const SizedBox(width: 4),
                  if (widget.required)
                    Text(
                      '*',
                      style: context.theme.textTheme.bodyMedium!.copyWith(
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
            ),
            const Divider(
              height: 1,
              indent: 0,
              endIndent: 0,
            ),
            if (files.isNotEmpty)
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 250),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                    final isNetwork = files[index].startsWith('http');
                    return ListTile(
                      title: Text(
                        p.basename(isNetwork ? Uri.parse(files[index]).path : files[index]),
                        style: context.theme.textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        isNetwork ? 'Stored' : files[index],
                        style: context.theme.textTheme.bodySmall!.copyWith(color: context.theme.colorScheme.onSurface.withOpacity(0.5)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: isNetwork
                            ? Image.network(
                                files[index],
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                                isAntiAlias: true,
                                filterQuality: FilterQuality.medium,
                              )
                            : Image.file(
                                File(files[index]),
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                                isAntiAlias: true,
                                filterQuality: FilterQuality.medium,
                              ),
                      ),
                      trailing: Button.ghost(
                        onPressed: () {
                          var newList = List<String>.from(files)..removeAt(index);
                          widget.onChanged.call(newList);
                          setState(() {});
                        },
                        children: const [Icon(FluentIcons.delete_16_regular)],
                      ),
                      contentPadding: const EdgeInsets.only(left: 14, right: 14, top: 0, bottom: 0),
                    );
                  },
                ),
              ),
            if (files.isNotEmpty && widget.multiSelect)
              const Divider(
                height: 1,
                indent: 0,
                endIndent: 0,
              ),
            if ((!widget.multiSelect && files.isEmpty) || widget.multiSelect)
              Button.ghost(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    allowMultiple: widget.multiSelect,
                    type: widget.fileType,
                  );
                  if (result != null) {
                    var newFiles = result.files.where(
                      (element) {
                        var filePath = (element.path?.toString() ?? '').replaceAll("\\", "/");
                        return !files.contains(filePath);
                      },
                    ).toList();

                    var newList = List<String>.from(files)..addAll(newFiles.map((e) => (e.path?.toString() ?? '').replaceAll("\\", "/")));
                    setState(() {});
                    widget.onChanged.call(newList);
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
