// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:testimony/model/testimony_model.dart';
import 'package:testimony/service/home_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeService) : super(HomeInitial());

  final HomeService _homeService;

  List<TestimonyModel> testimonies = [];

  Future<void> getTestimonies() async {
    try {
      emit(HomeInitial());
      testimonies = await _homeService.getTestimonies(page: 1);
      emit(HomeSuccess(testimonies: testimonies));
    } catch (e) {
      emit(HomeError(error: e.toString()));
    }
  }

  Future<void> getMoreTestimonies(BuildContext context, {required int page}) async {
    try {
      final newTestimonies = await _homeService.getTestimonies(page: page);
      testimonies.addAll(newTestimonies);
      emit(HomeSuccess(testimonies: testimonies));
    } catch (e) {
      emit(HomeSuccess(testimonies: testimonies, fullLoaded: true));
    }
  }

  Future<void> searchTestimonies({required String search}) async {
    try {
      emit(HomeInitial());
      testimonies = await _homeService.getTestimonies(search: search);
      emit(HomeSuccess(testimonies: testimonies));
    } on DioException catch (e) {
      emit(HomeError(error: e.response.toString()));
    } catch (e) {
      emit(HomeError(error: e.toString()));
    }
  }
}
