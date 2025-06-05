part of 'news_cubit.dart';


abstract class NewsState extends Equatable {
const NewsState();
 @override
  List<Object> get props => [];
}

final class NewsFetchingState extends NewsState {} 

final class NewsErrorState extends NewsState {

    final String message;
  const NewsErrorState ({required this.message});

  @override
  List<Object> get props => [message];
 
  

}

final class NewsFetchedState extends NewsState {
  final News news;
  const NewsFetchedState({required this.news});
  @override
  List<Object> get props => [news];
}

final class NewsInitialState extends NewsState {}

final class ErrorState extends NewsState {
  final String error;
  const ErrorState({required this.error});
  @override
  List<Object> get props => [error];
}