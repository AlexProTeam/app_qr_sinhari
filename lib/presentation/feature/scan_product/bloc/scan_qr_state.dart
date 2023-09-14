part of 'scan_qr_bloc.dart';

abstract class ScanState {}

class InitialScanState extends ScanState {}

class ImageScanState extends ScanState {}

class ProductScanState extends ScanState {}

class InvoiceScanState extends ScanState {
  final String toastMessage;

  InvoiceScanState(this.toastMessage);
}
