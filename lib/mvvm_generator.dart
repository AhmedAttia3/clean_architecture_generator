library mvvm_generator;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/generators/cache_usecase_generator.dart';
import 'src/generators/cubit_generator.dart';
import 'src/generators/repository_generator.dart';
import 'src/generators/requests_generator.dart';
import 'src/generators/test/cache_usecase_test_generator.dart';
import 'src/generators/test/cubit_test_generator.dart';
import 'src/generators/test/repository_test_generator.dart';
import 'src/generators/test/usecase_test_generator.dart';
import 'src/generators/usecase_generator.dart';

export 'src/mvvm_generator_annotations.dart';

Builder generateMVVM(BuilderOptions options) => SharedPartBuilder(
      [
        RequestsGenerator(),
        RepositoryGenerator(),
        UseCaseGenerator(),
        CacheUseCaseGenerator(),
        CubitGenerator(),

        ///[Test]
        RepositoryTestGenerator(),
        UseCaseTestGenerator(),
        CacheUseCaseTestGenerator(),
        CubitTestGenerator(),
      ],
      'mvvm',
      formatOutput: (code) {
        return '#BUILD DONE SUCCESSFULLY';
      },
    );
