part of 'create_category_bloc.dart';

sealed class CreateCategoryEvent extends Equatable {
  const CreateCategoryEvent();

  @override
  List<Object> get props => [];

  Category get category;
}

class CreateCategory extends CreateCategoryEvent {
  @override
  final Category category;

  CreateCategory(this.category);

  @override
  List<Object> get props => [category];
}