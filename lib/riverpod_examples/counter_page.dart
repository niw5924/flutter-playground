import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterState {
  final int count;
  final bool isEven;

  const CounterState(this.count) : isEven = count % 2 == 0;
}

class CounterNotifier extends StateNotifier<CounterState> {
  CounterNotifier() : super(const CounterState(0));

  void increment() {
    state = CounterState(state.count + 1);
    print(state.isEven);
  }

  void decrement() {
    state = CounterState(state.count - 1);
    print(state.isEven);
  }

  void square() {
    state = CounterState(state.count * state.count);
  }
}

final counterProvider = StateNotifierProvider<CounterNotifier, CounterState>((
  ref,
) {
  return CounterNotifier();
});

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Riverpod 카운터 예제")),
      body: Center(
        child: Text(
          'Count: ${state.count}',
          style: const TextStyle(fontSize: 32),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () => ref.read(counterProvider.notifier).increment(),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            onPressed: () => ref.read(counterProvider.notifier).decrement(),
            child: const Icon(Icons.remove),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            onPressed: () => ref.read(counterProvider.notifier).square(),
            child: const Icon(Icons.exposure_plus_2),
          ),
        ],
      ),
    );
  }
}
