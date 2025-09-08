import 'package:provider/provider.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:sympho/classes/voice.dart';
import 'package:sympho/data/theme/shadcn.dart';

import '../../../provider/ui/generate.dart';

class PromptVoiceGenderFilter extends StatefulWidget {
  final VoiceGender gender;
  final Function(VoiceGender gender) onChange;
  const PromptVoiceGenderFilter({
    super.key,
    required this.gender,
    required this.onChange,
  });

  @override
  State<PromptVoiceGenderFilter> createState() => _PromptVoiceGenderFilterState();
}

class _PromptVoiceGenderFilterState extends State<PromptVoiceGenderFilter> {
  Text selectValue(
    VoiceGender g, {
    bool emoji = true,
    bool voicesWord = true,
    bool genderWord = true,
  }) {
    return Text(
      g == VoiceGender.male
          ? "${emoji ? "  👨" : ""}${genderWord ? "   Male" : ""}${voicesWord ? " voices" : ""}"
          : g == VoiceGender.female
          ? "${emoji ? "  👩" : ""}${genderWord ? "   Female" : ""}${voicesWord ? " voices" : ""}"
          : "${emoji ? "  🧑" : ""}${genderWord ? "   All" : ""}${voicesWord ? " voices" : ""}",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GenerateTTSProcessProvider>(
        builder: (context, process, _) {
        return Select<VoiceGender>(
          padding: EdgeInsets.all(7),
          enabled: !process.onProcess,
          itemBuilder: (context, item) {
            return selectValue(widget.gender, voicesWord: false, genderWord: false);
          },
          onChanged: (g) {
            if (g != null) {
              widget.onChange(g);
            }
          },
          value: widget.gender,
          popupWidthConstraint: PopoverConstraint.intrinsic,
          popup: SelectPopup(
            items: SelectItemList(
              children: [VoiceGender.all, VoiceGender.male, VoiceGender.female]
                  .map(
                    (g) => SelectItemButton(
                      value: g,
                      style: ButtonStyle.outline().withBorder(
                        border: Border.all(
                          color: g == widget.gender
                              ? ShadcnThemer().secondary()
                              : ShadcnThemer().border(),
                        ),
                      ),
                      child: selectValue(g, voicesWord: false),
                    ).withMargin(vertical: 8, horizontal: 4),
                  )
                  .toList(),
            ),
          ).call,
        );
      }
    );
  }
}
