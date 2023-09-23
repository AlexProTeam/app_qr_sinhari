part of 'scan_qr_bloc.dart';

abstract class ScanEvent {}

class UpdateCurrentIndex extends ScanEvent {
  final int newIndex;

  UpdateCurrentIndex(this.newIndex);
}
