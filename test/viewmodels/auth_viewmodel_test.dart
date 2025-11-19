import 'package:flutter_test/flutter_test.dart';
import 'package:app_ecommerce/presentation/viewmodels/auth_viewmodel.dart';
import 'package:app_ecommerce/domain/repositories/auth_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@GenerateMocks([AuthRepository])
import 'auth_viewmodel_test.mocks.dart';

void main() {
  late AuthViewModel viewModel;
  late MockAuthRepository mockRepository;
  late ProviderContainer container;

  setUp(() {
    mockRepository = MockAuthRepository();
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  group('AuthViewModel', () {
    test('initial state should be AuthInitial', () {
      // Arrange
      viewModel = AuthViewModel(mockRepository);

      // Assert
      expect(viewModel.debugState, isA<AuthInitial>());
    });

    test(
      'signIn should emit loading then success states on successful login',
      () async {
        // Arrange
        const email = 'test@example.com';
        const password = 'password123';

        when(mockRepository.signIn(any, any)).thenAnswer((_) async => {});

        viewModel = AuthViewModel(mockRepository);

        // Act
        final future = viewModel.signIn(email, password);

        // Assert - check loading state
        expect(viewModel.debugState, isA<AuthLoading>());

        await future;

        // Assert - check success state
        expect(viewModel.debugState, isA<AuthSuccess>());
        verify(mockRepository.signIn(email, password)).called(1);
      },
    );

    test('signIn should emit error state on failure', () async {
      // Arrange
      const email = 'test@example.com';
      const password = 'wrong';
      const errorMessage = 'Invalid credentials';

      when(mockRepository.signIn(any, any)).thenThrow(Exception(errorMessage));

      viewModel = AuthViewModel(mockRepository);

      // Act
      await viewModel.signIn(email, password);

      // Assert
      expect(viewModel.debugState, isA<AuthError>());
      final errorState = viewModel.debugState as AuthError;
      expect(errorState.message, contains(errorMessage));
    });

    test('signUp should call repository with correct parameters', () async {
      // Arrange
      const name = 'John Doe';
      const email = 'john@example.com';
      const password = 'password123';

      when(mockRepository.signUp(any, any, any)).thenAnswer((_) async => {});

      viewModel = AuthViewModel(mockRepository);

      // Act
      await viewModel.signUp(name, email, password);

      // Assert
      verify(mockRepository.signUp(name, email, password)).called(1);
      expect(viewModel.debugState, isA<AuthSuccess>());
    });

    test('signOut should call repository signOut', () async {
      // Arrange
      when(mockRepository.signOut()).thenAnswer((_) async => {});

      viewModel = AuthViewModel(mockRepository);

      // Act
      await viewModel.signOut();

      // Assert
      verify(mockRepository.signOut()).called(1);
    });
  });
}
