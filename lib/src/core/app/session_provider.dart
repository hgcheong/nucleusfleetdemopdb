import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nucleusv2/src/app.dart';
import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/core/app/storage.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/utils/dialogs.dart';
import 'package:nucleusv2/src/feature/auth/models/token.dart';
import 'package:nucleusv2/src/feature/auth/services/auth_service.dart';
import 'package:nucleusv2/src/feature/user/models/user.dart';
import 'package:nucleusv2/src/feature/user/services/user_service.dart';

class SessionModel {
  final Token? token;
  final User? user;
  final bool isAuthenticated;
  final bool ready;
  final Map<String, dynamic> metaData;

  const SessionModel({
    this.token,
    this.isAuthenticated = false,
    this.user,
    this.ready = false,
    this.metaData = const {},
  });

  SessionModel copyWith(
      {Token? token,
      User? user,
      bool? isAuthenticated,
      bool? ready,
      Map<String, dynamic>? metaData}) {
    return SessionModel(
      token: token ?? this.token,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      ready: ready ?? this.ready,
      metaData: metaData ?? this.metaData,
    );
  }
}

class SessionProvider extends StateNotifier<SessionModel> {
  final Ref ref;
  Timer? _refreshTimer;

  static const _initial = SessionModel();

  SessionProvider(this.ref, [SessionModel sessionModel = _initial])
      : super(sessionModel) {
    init();
  }

  Future<void> init() async {
    // final tokenString = singleton<Storage>().getString(Token.AUTH_TOKEN_KEY);

    // if (tokenString != null) {
    //   final token = Token.fromJson(jsonDecode(tokenString));

    //   if (token.accessTokenIsExpired()) {
    //     if (!token.refreshTokenIsExpired()) {
    //       final refreshedToken = await _refreshToken(token);
    //       if (refreshedToken != null) {
    //         await setToken(refreshedToken);
    //         return;
    //       }
    //     }
    //   } else {
    //     await setToken(token);
    //     return;
    //   }
    // }

    state = state.copyWith(ready: true, isAuthenticated: false);
  }

  Future<Token?> _refreshToken(Token token) async {
    return await AuthService().refresh(token.refresh_token, token.access_token);
  }

  Future<void> setToken(Token token) async {
    singleton<Storage>().setString(Token.AUTH_TOKEN_KEY, token.toJson());

    final user = await UserService().me();

    state = state.copyWith(
      token: token,
      isAuthenticated: true,
      user: user,
      ready: true,
    );

    int secondsUntilExpiry = token.secondsUntilExpiry();

    if (_refreshTimer != null) {
      _refreshTimer!.cancel();
    }

    _refreshTimer = Timer(Duration(seconds: secondsUntilExpiry), () async {
      final refreshedToken = await _refreshToken(token);
      if (refreshedToken != null) {
        setToken(refreshedToken);
      } else {
        logout(forcedlogout: true);
      }
    });
  }

  Future<void> refreshUser() async {
    final user = await UserService().me();
    state = state.copyWith(user: user);
  }

  Future<bool> logout({bool forcedlogout = false}) async {
    if (!forcedlogout) {
      bool confirmed = await ConfirmDialog.show(
        title: "Logout",
        body: "Are you sure you want to logout?",
        destructive: true,
        confirmText: "Logout",
        cancelText: "Cancel",
      );

      if (!confirmed) {
        return false;
      }

      state = state.copyWith(
        ready: true,
        isAuthenticated: false,
        user: null,
        token: null,
      );
      singleton<Storage>().remove(Token.AUTH_TOKEN_KEY);

      final context = rootNavigatorKey.currentContext!;
      if (context.mounted) {
        singleton<AppRouter>().replace(const AuthLandingRoute());
      }
      return true;
    } else {
      state = state.copyWith(
        ready: true,
        isAuthenticated: false,
        user: null,
        token: null,
      );
      singleton<Storage>().remove(Token.AUTH_TOKEN_KEY);

      // final context = rootNavigatorKey.currentContext!;
      singleton<AppRouter>().replace(const AuthLandingRoute());
      return true;
    }
  }

  void setMetaData(Map<String, dynamic> data) {
    Map<String, dynamic> metaData = {...state.metaData};

    state = state.copyWith(
      metaData: {...metaData, ...data},
    );
  }
}

final sessionStateNotifierProvider =
    StateNotifierProvider<SessionProvider, SessionModel>(
  (ref) => SessionProvider(ref),
);
