library mvvm_generator;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/generators/cache_cubit_generator.dart';
import 'src/generators/cache_usecase_generator.dart';
import 'src/generators/cubit_generator.dart';
import 'src/generators/local_data_source_generator.dart';
import 'src/generators/optimize/move_remote_data_source_generator.dart';
import 'src/generators/optimize/optimize_generator.dart';
import 'src/generators/repository_generator.dart';
import 'src/generators/requests_generator.dart';
import 'src/generators/test/cache_cubit_test_generator.dart';
import 'src/generators/test/cache_usecase_test_generator.dart';
import 'src/generators/test/cubit_test_generator.dart';
import 'src/generators/test/get_cache_usecase_test_generator.dart';
import 'src/generators/test/local_data_source_test_generator.dart';
import 'src/generators/test/repository_test_generator.dart';
import 'src/generators/test/usecase_test_generator.dart';
import 'src/generators/usecase_generator.dart';

export 'src/annotations.dart';
export 'src/generators/main/clean_architecture_set_up.dart';

Builder generateCleanArchitecture(BuilderOptions options) => SharedPartBuilder(
      [
        OptimizeGenerator(),
        RequestsGenerator(),
        LocalDataSourceGenerator(),
        RepositoryGenerator(),
        CacheUseCaseGenerator(),
        UseCaseGenerator(),
        CubitGenerator(),
        CacheCubitGenerator(),

        ///[Test]
        RepositoryTestGenerator(),
        LocalDataSourceTestGenerator(),
        UseCaseTestGenerator(),
        CacheUseCaseTestGenerator(),
        GetCacheUseCaseTestGenerator(),
        CubitTestGenerator(),
        CacheCubitTestGenerator(),

        ///[Move Remote data source]
        MoveRemoteDataSourceGenerator()
      ],
      'clean_architecture',
      // formatOutput: (code) {
      //   return '#BUILD DONE SUCCESSFULLY';
      // },
    );
