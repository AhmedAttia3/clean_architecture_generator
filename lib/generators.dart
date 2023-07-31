library generators;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/generators/cubit_generator.dart';
import 'src/generators/repository_generator.dart';
import 'src/generators/requests_generator.dart';
import 'src/generators/test/cubit_test_generator.dart';
import 'src/generators/test/usecase_test_generator.dart';
import 'src/generators/usecase_generator.dart';

Builder generateCubit(BuilderOptions options) => SharedPartBuilder(
      [CubitGenerator()],
      'cubit',
    );

Builder generateCubitUnitTest(BuilderOptions options) => SharedPartBuilder(
      [CubitTestGenerator()],
      'cubit_test',
    );

Builder generateRepository(BuilderOptions options) => SharedPartBuilder(
      [RepositoryGenerator()],
      'repository',
    );

Builder generateRequests(BuilderOptions options) => SharedPartBuilder(
      [RequestsGenerator()],
      'requests',
    );

Builder generateUseCase(BuilderOptions options) => SharedPartBuilder(
      [UseCaseGenerator()],
      'usecase',
    );

Builder generateUseCaseUnitTest(BuilderOptions options) => SharedPartBuilder(
      [UseCaseTestGenerator()],
      'usecase_test',
    );
