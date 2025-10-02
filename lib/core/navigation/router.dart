import 'package:go_router/go_router.dart';
import 'package:harubee/presentation/today/views/today_view.dart';

// * Router
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (_, _) => const TodayView(),
      routes: <RouteBase>[
        //GoRoute(path: 'transaction_input', builder: (context, state) => )
      ],
    ),

    // GoRoute(
    //   path: '/details/:id',
    //   builder: (context, state) =>
    //       DetailsScreen(id: state.pathParameters['id']!),
    // ),
  ],
);


// showModalBottomSheet(
//                 context: context,
//                 isScrollControlled: true,
//                 shape: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                 ),
//                 builder: (context) => ChangeNotifierProvider(
//                   create: (_) => TransactionInputViewmodel(),
//                   child: const TransactionInputView(),
//                 ),
//               );