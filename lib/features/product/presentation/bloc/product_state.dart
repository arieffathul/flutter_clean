part of 'product_bloc.dart';

abstract class ProdukState extends Equatable {}

class ProdukInitial extends ProdukState {
  @override
  List<Object?> get props => [];
}

class ProdukStateLoading extends ProdukState {
  @override
  List<Object?> get props => [];
}

class ProdukStateError extends ProdukState {
  final String message;

  ProdukStateError({required this.message});
  @override
  List<Object?> get props => [message];
}

class ProdukStateLoadedAll extends ProdukState {
  final List<Produk> produks;

  ProdukStateLoadedAll({required this.produks});

  @override
  List<Object?> get props => [produks];
}

class ProdukStateLoaded extends ProdukState {
  final Produk produk;

  ProdukStateLoaded({required this.produk});

  @override
  List<Object?> get props => [produk];
}

class ProdukStateSuccess extends ProdukState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
