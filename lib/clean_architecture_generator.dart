library mvvm_generator;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/generators/optimize/optimize_generator.dart';

export 'models/clean_method.dart';
export 'src/annotations.dart';
export 'src/generators/main/clean_architecture_set_up.dart';

Builder generateCleanArchitecture(BuilderOptions options) => SharedPartBuilder(
      [
        OptimizeGenerator(),
        // RequestsGenerator(),
        // LocalDataSourceGenerator(),
        // RepositoryGenerator(),
        // CacheUseCaseGenerator(),
        // UseCaseGenerator(),
        // CubitGenerator(),
        // CacheCubitGenerator(),
        //
        // ///[Test]
        // RepositoryTestGenerator(),
        // LocalDataSourceTestGenerator(),
        // UseCaseTestGenerator(),
        // CacheUseCaseTestGenerator(),
        // GetCacheUseCaseTestGenerator(),
        // CubitTestGenerator(),
        // CacheCubitTestGenerator(),

        // ///[Move Remote data source]
        // MoveRemoteDataSourceGenerator()
      ],
      'clean_architecture',
      // formatOutput: (code) {
      //   return '#BUILD DONE SUCCESSFULLY';
      // },
    );
