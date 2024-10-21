import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controller/lines_notifier_provider/lines_provider.dart';

class LinesScreen extends ConsumerStatefulWidget {
  const LinesScreen({super.key});

  @override
  ConsumerState<LinesScreen> createState() => _LinesScreenState();
}

class _LinesScreenState extends ConsumerState<LinesScreen> {

  @override
  Widget build(BuildContext context) {
    // final linesRepo = ref.watch(linesRepoProvider);
    final linesAsyncProvider = ref.watch(linesNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lines Screen'),
        centerTitle: true,
      ),
      body: linesAsyncProvider.when(
        data: (lines) => ListView.builder(
          itemCount: lines.length,
          itemBuilder: (context, index) {
            log('inside_lines_screen: ${lines}');
            // log('inside_lines_screen: ${lines[0]['lines']}');

            final line = lines[index];
            return Card(
              color: Colors.grey.shade100,
              surfaceTintColor: Colors.grey.shade50,
              margin: EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(line),
              ),
            );
            // return Container();
          },
        ),
        loading: () => Center(
            child: CircularProgressIndicator()
        ),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}