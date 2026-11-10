import 'package:flutter/material.dart';
import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/components/acx_action_spacing.dart';

class AcxBackToList extends StatelessWidget {
  const AcxBackToList({
    super.key,
    required this.listUrl,
    this.fnBeforeNav, this.useFunctionOnly,

  });

  final String listUrl;
  final Function? fnBeforeNav;
  final bool? useFunctionOnly;
  @override
  Widget build(BuildContext context) =>
      AcxActionSpacing(child: _buildButton(context));

  Widget _buildButton(BuildContext context) {
    return ElevatedButton(
      child: const SizedBox(width: 30, child: Icon(Icons.arrow_back)),
      onPressed: () {
        if (fnBeforeNav != null) {
          fnBeforeNav!();
          if(useFunctionOnly!=null&&useFunctionOnly!){
            return;
          }
        }
        singleton<AppRouter>().navigatePath(listUrl);
      },
    );
  }
}
