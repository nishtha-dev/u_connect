abstract class DropdownMenuEnum {
  final String name;

  const DropdownMenuEnum({
    required this.name,
  });
}

enum PronounTypeEnum implements DropdownMenuEnum {
  sheHer(
    name: 'She/her',
  ),
  heHim(
    name: 'He/him',
  ),
  theyThem(
    name: 'They/them',
  ),
  custom(
    name: 'Custom',
  ),

  none(name: '');

  @override
  final String name;

  const PronounTypeEnum({
    required this.name,
  });

  bool get isCustom => this == PronounTypeEnum.custom;
  bool get isNone => this == PronounTypeEnum.none;
  static List<PronounTypeEnum> get filteredList {
    return [
      PronounTypeEnum.sheHer,
      PronounTypeEnum.heHim,
      PronounTypeEnum.theyThem,
      PronounTypeEnum.custom,
    ];
  }
}
