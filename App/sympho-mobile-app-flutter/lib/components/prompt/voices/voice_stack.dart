import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:sympho/classes/voice.dart';
import 'package:sympho/components/prompt/voices/gender_filter.dart';
import 'package:sympho/components/prompt/voices/player.dart';
import 'package:sympho/data/voices/voices.dart';
import 'package:sympho/provider/data/prompt.dart';
import 'package:sympho/data/theme/shadcn.dart';

class PromptVoice extends StatefulWidget {
  const PromptVoice({super.key});

  @override
  State<PromptVoice> createState() => _PromptVoiceState();
}

class _PromptVoiceState extends State<PromptVoice> {
  String searchValue = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: TextField(
                placeholder: Text('Search voice ...'),
                autocorrect: false,
                initialValue: searchValue,
                enableIMEPersonalizedLearning: false,
                enableSuggestions: false,
                enableInteractiveSelection: false,
                textInputAction: TextInputAction.search,
                features: [
                  InputFeature.clear(
                    icon: Icon(LucideIcons.x, color: Colors.white),
                    visibility: InputFeatureVisibility.textNotEmpty,
                  ),
                ],
                onChanged: (v) => setState(() => searchValue = v),
                onTapOutside: (_) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
            ),
            Consumer<PromptVoiceGenderFilterProvider>(
              builder: (context, gender, _) {
                return PromptVoiceGenderFilter(
                  gender: gender.gender,
                  onChange: (g) => gender.set(g),
                );
              },
            ),
          ],
        ).gap(16),
        Flexible(
          child: SingleChildScrollView(
            child: Consumer<PromptVoiceGenderFilterProvider>(
              builder: (context, gender, _) {
                List<Voice> voices = allVoices;
                voices = searchValue.length >= 2
                    ? voices
                          .where(
                            (v) => v.name.toLowerCase().contains(searchValue),
                          )
                          .toList()
                    : voices;

                if (gender.gender == VoiceGender.all) {
                  voices = [...voices];
                } else {
                  voices = voices
                      .where((g) => g.gender == gender.gender)
                      .toList();
                }

                voices.sort((a, b) => !a.isPro ? -1 : 1);

                return Consumer<PromptVoiceProvider>(
                  builder: (context, voiceProvider, _) {
                    return Column(
                      children: voices.mapIndexed((index, voice) {
                        bool isActive = voiceProvider.id == voice.id;
                        bool isMale = voice.gender == VoiceGender.male;

                        /// If the voice is Pro only prevent the users with free access
                        bool hasAccess = voice.isPro ? false : true;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Button(
                                onPressed: () {
                                  if (hasAccess) {
                                    voiceProvider.set(voice.id);
                                  } else {
                                    /// TODO Here you can check if the user has access
                                    /// TODO like user with Pro plan or have a Purchased access

                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Upgrade Your Plan!'),
                                          content: Text(
                                            'You way want to display the purchase modal/page to showcase your subscriptions.',
                                          ),
                                          actions: [
                                            PrimaryButton(
                                              child: const Text('OK'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                style:
                                    ButtonStyle.outline(
                                      density: ButtonDensity.compact,
                                    ).withBorder(
                                      border: Border.all(
                                        color: isActive
                                            ? ShadcnThemer().secondary()
                                            : ShadcnThemer().border(),
                                      ),
                                    ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${isMale ? "👨" : "👩"}  ${voice.name}",
                                            style: TextStyle(
                                              color: isActive
                                                  ? ShadcnThemer().secondary()
                                                  : null,
                                              fontSize: 20,
                                            ),
                                          ).withPadding(all: 8),
                                          !hasAccess
                                              ? Icon(LucideIcons.lock)
                                              : const SizedBox.shrink(),
                                        ],
                                      ),
                                    ),
                                    isActive
                                        ? Icon(
                                            LucideIcons.check,
                                            color: ShadcnThemer().secondary(),
                                            size: 24,
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                ).withMargin(right: 12, left: 6),
                              ).withMargin(vertical: 6),
                            ),
                            PromptVoiceSamplePlay(id: voice.id),
                          ],
                        ).gap(16).withMargin(vertical: 4);
                      }).toList(),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    ).gap(12).withPadding(all: 12);
  }
}
