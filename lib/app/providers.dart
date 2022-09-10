import 'package:ecommerce/services/firestore_service.dart';
import 'package:ecommerce/services/payment_service.dart';
import 'package:ecommerce/services/storage_service.dart';
import 'package:ecommerce/view_models/bag_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthprovider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final authStateChangesProvider = StreamProvider<User?>(
    (ref) => ref.watch(firebaseAuthprovider).authStateChanges());
final databaseProvider = Provider<FirestoreService?>((ref) {
  final auth = ref.watch(authStateChangesProvider);
  String? uid = auth.asData?.value?.uid;
  if (uid != null) {
    return FirestoreService(uid: uid);
  }
  return null;
});
final storageProvider = Provider<StorageService?>((ref) {
  final auth = ref.watch(authStateChangesProvider);
  String? uid = auth.asData?.value?.uid;
  if (uid != null) {
    return StorageService(uid: uid);
  }
  return null;
});

final bagProvider = ChangeNotifierProvider<BagViewModel>((ref) {
  return BagViewModel();
});

final paymentProvider = Provider<PaymentService>((ref) {
  return PaymentService();
});
