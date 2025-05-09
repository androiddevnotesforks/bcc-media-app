import 'package:auto_route/auto_route.dart';
import 'package:brunstadtv_app/components/status/loading_indicator.dart';
import 'package:bccm_core/platform.dart';
import 'package:brunstadtv_app/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';

import 'package:bccm_core/design_system.dart';
import 'package:universal_io/io.dart';

import '../../helpers/svg_icons.dart';
import '../../l10n/app_localizations.dart';
import 'pulse_animation.dart';
import '../misc/shiny_clipper.dart';
import 'study_progress.dart';

class StudyButton extends HookWidget {
  const StudyButton({super.key, required this.lessonProgressFuture, required this.onNavigateBack});
  final Future<Query$GetEpisodeLessonProgress?> lessonProgressFuture;
  final void Function() onNavigateBack;

  @override
  Widget build(BuildContext context) {
    final delayedFuture = useMemoized(
      () => Future.delayed(const Duration(milliseconds: 300), () async => await lessonProgressFuture),
      [lessonProgressFuture],
    );
    final future = useFuture(delayedFuture);

    if (future.connectionState == ConnectionState.waiting) {
      return const _LoadingWidget();
    } else if (future.hasError || future.data == null) {
      return const SizedBox.shrink();
    }

    final lesson = future.data?.episode.lessons.items[0];

    return lesson?.showDiscoverPage != false
        ? StudyMoreButton(lessonProgress: future.data!, onNavigateBack: onNavigateBack)
        : StudyQuizButton(lessonProgress: future.data!, onNavigateBack: onNavigateBack);
  }
}

class StudyMoreButton extends HookWidget {
  const StudyMoreButton({super.key, required this.lessonProgress, required this.onNavigateBack});
  final Query$GetEpisodeLessonProgress lessonProgress;
  final void Function() onNavigateBack;

  String title(Fragment$LessonProgressOverview progressOverview, BuildContext context) {
    final total = progressOverview.progress.total;
    final completed = progressOverview.progress.completed;
    if (completed < total) {
      final plural = total > 1;
      return '$completed/$total ${!plural ? S.of(context).taskCompleted : S.of(context).tasksCompleted}';
    }
    return S.of(context).discoverMore;
  }

  String secondaryTitle(Fragment$LessonProgressOverview progressOverview, BuildContext context) {
    if (progressOverview.locked) {
      return S.of(context).completePreviousTasks;
    }
    if (progressOverview.progress.completed < progressOverview.progress.total) {
      return S.of(context).studyCompleteTaskDescription;
    }
    return S.of(context).studyDiscoverMoreDescription;
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    final episode = lessonProgress.episode;
    final lesson = episode.lessons.items[0];

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        await context.router.root.push(StudyScreenRoute(episodeId: episode.id, lessonId: lesson.id));
        onNavigateBack();
      },
      child: Opacity(
        opacity: lesson.locked ? 0.6 : 1,
        child: Stack(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: design.colors.tint1.withAlpha((255 * 0.1).round()),
              ),
              foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: design.colors.separatorOnLight, width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 42,
                    height: 42,
                    child: LessonProgressTree(
                      completed: lesson.progress.completed,
                      total: lesson.progress.total,
                      outerStrokeWidth: 3,
                      innerStrokeWidth: 1.7,
                      arcToTreePadding: 8,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title(lesson, context),
                          style: design.textStyles.title3,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            secondaryTitle(lesson, context),
                            overflow: TextOverflow.fade,
                            style: design.textStyles.caption1.copyWith(color: design.colors.label3),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Stack(
                      children: [
                        if (!lesson.locked && !Platform.isAndroid) // android has some perf issues because of skia
                          const Positioned.fill(child: PulseAnimation()),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF3D4E63),
                            borderRadius: BorderRadius.circular(45),
                          ),
                          foregroundDecoration: BoxDecoration(
                            border: Border.all(color: design.colors.separatorOnLight, width: 1),
                            borderRadius: BorderRadius.circular(45),
                          ),
                          width: 38,
                          height: 38,
                          child: Center(
                            child: SvgPicture.string(
                              SvgIcons.chevronRight,
                              height: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned.fill(
              child: LayoutBuilder(builder: (context, constraints) {
                return Padding(
                  padding: EdgeInsets.only(left: constraints.maxWidth * 0.6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ClipPath(
                      clipper: ShinyClipper(),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xffccddff), Color(0xffedf2fd), Color(0x00ccddff)],
                          ).scale(0.1),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

class StudyQuizButton extends HookWidget {
  const StudyQuizButton({super.key, required this.lessonProgress, required this.onNavigateBack});
  final Query$GetEpisodeLessonProgress lessonProgress;
  final void Function() onNavigateBack;

  String title(Fragment$LessonProgressOverview progressOverview, BuildContext context) {
    final alternativesCorrectAnswers = progressOverview.progress.alternativesTasksCorrect;
    final alternativesCompletedAnswers = progressOverview.progress.alternativesTasksCompleted;
    final alternativesTotal = progressOverview.progress.alternativesTasksTotal;

    if (!progressOverview.completed || alternativesCompletedAnswers != alternativesTotal) {
      return S.of(context).answerTheQuiz;
    }
    if (alternativesTotal == 0) {
      return S.of(context).studyAllQuestionsAnswered;
    }
    if (alternativesCorrectAnswers == 0) {
      return S.of(context).studyNoAnswersCorrect;
    }
    if (alternativesCorrectAnswers == alternativesTotal) {
      return S.of(context).studyAllAnswersCorrect;
    }
    if (alternativesCorrectAnswers > 0) {
      return S.of(context).studySomeAnswersCorrect(alternativesCorrectAnswers, alternativesTotal);
    }
    return S.of(context).answerTheQuiz;
  }

  String secondaryTitle(Fragment$LessonProgressOverview progressOverview, BuildContext context) {
    final alternativesCorrectAnswers = progressOverview.progress.alternativesTasksCorrect;
    final alternativesCompletedAnswers = progressOverview.progress.alternativesTasksCompleted;
    final alternativesTotal = progressOverview.progress.alternativesTasksTotal;

    if (!progressOverview.completed || alternativesCompletedAnswers != alternativesTotal) {
      return S.of(context).studyAnswerTheQuizDescription;
    }
    if (alternativesTotal == 0) {
      return S.of(context).studyAllQuestionsAnsweredDescription;
    }
    if (alternativesCorrectAnswers == 0) {
      return S.of(context).studyNoAnswersCorrectDescription;
    }
    if (alternativesCorrectAnswers == alternativesTotal) {
      return S.of(context).studyAllAnswersCorrectDescription;
    }
    if (alternativesCorrectAnswers > 0) {
      return S.of(context).studySomeAnswersCorrectDescription;
    }
    return S.of(context).studyAnswerTheQuizDescription;
  }

  Color color(Fragment$LessonProgressOverview progressOverview, BuildContext context) {
    final design = DesignSystem.of(context);
    final alternativesCorrectAnswers = progressOverview.progress.alternativesTasksCorrect;
    final alternativesCompletedAnswers = progressOverview.progress.alternativesTasksCompleted;
    final alternativesTotal = progressOverview.progress.alternativesTasksTotal;

    if (!progressOverview.completed || alternativesCompletedAnswers != alternativesTotal) {
      return design.colors.separatorOnLight;
    }
    if (alternativesTotal == 0) {
      return design.colors.tint1;
    }
    if (alternativesCorrectAnswers == 0) {
      return design.colors.tint2;
    }
    if (alternativesCorrectAnswers > 0) {
      return design.colors.tint1;
    }
    return design.colors.separatorOnLight;
  }

  SvgPicture icon(Fragment$LessonProgressOverview progressOverview, BuildContext context) {
    if (progressOverview.completed && progressOverview.progress.alternativesTasksCompleted == progressOverview.progress.alternativesTasksTotal) {
      return SvgPicture.string(
        SvgIcons.check,
        height: 24,
      );
    }
    return SvgPicture.string(
      SvgIcons.chevronRight,
      height: 11,
    );
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    final episode = lessonProgress.episode;
    final lesson = episode.lessons.items[0];

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        await context.router.root.push(StudyScreenRoute(episodeId: episode.id, lessonId: lesson.id));
        onNavigateBack();
      },
      child: Stack(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: color(lesson, context),
            ),
            foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: design.colors.separatorOnLight, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title(lesson, context),
                        style: design.textStyles.title3.copyWith(color: design.colors.label1),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          secondaryTitle(lesson, context),
                          overflow: TextOverflow.fade,
                          style: design.textStyles.caption1.copyWith(color: design.colors.onTint),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: design.colors.separatorOnLight,
                      borderRadius: BorderRadius.circular(45),
                    ),
                    foregroundDecoration: BoxDecoration(
                      border: Border.all(color: design.colors.separatorOnLight, width: 1),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    width: 38,
                    height: 38,
                    child: Center(
                      child: icon(lesson, context),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: design.colors.tint1.withAlpha((255 * 0.1).round()),
      ),
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: design.colors.separatorOnLight, width: 1),
      ),
      child: const Center(child: LoadingIndicator()),
    );
  }
}
