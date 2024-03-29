import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:testimony/cubit/language_cubit.dart';
import 'package:testimony/model/language_model.dart';
import 'package:testimony/model/testimony_model.dart';

class TestimonyCard extends StatefulWidget {
  const TestimonyCard({
    super.key,
    required this.testimony,
  });

  final TestimonyModel testimony;

  @override
  State<TestimonyCard> createState() => _TestimonyCardState();
}

class _TestimonyCardState extends State<TestimonyCard> {
  bool expand = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0.8,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundImage: NetworkImage(widget.testimony.avatar)),
                const SizedBox(width: 8),
                Text(
                  widget.testimony.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                setState(() {
                  expand = !expand;
                });
              },
              child: Column(
                children: [
                  Text(
                    widget.testimony.content,
                    overflow: expand ? null : TextOverflow.ellipsis,
                    maxLines: expand ? null : 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        expand ? AppLocalizations.of(context)!.hide : AppLocalizations.of(context)!.more,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            BlocBuilder<LanguageCubit, LanguageModel>(
              builder: (context, state) {
                return Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${NumberFormat('#,###.###', state.code).format(widget.testimony.likes)} ',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.likes,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
