class Realisation {
  double target;
  double currentValue;
  String name;
  double percentage;
  double percentagePond;

  Realisation({
    required this.target,
    required this.currentValue,
    required this.name,
    this.percentage = 0,
        this.percentagePond = 0,

  });

  factory Realisation.fromJson(Map<String, dynamic> json) {
    return Realisation(
        percentage: json["percentage"],
                percentagePond: json["percentagePond"],

        target: json["target"],
        currentValue: json["value"],
        name: json["name"]);
  }
}

class TotalRealisation {
  int assignedTo;
  String trimester;
  String year;
  double increase;
  
  double ? increaseResult;
  List<Realisation> realisations;

  TotalRealisation(
      {required this.increase,
      required this.realisations,
      required this.trimester,
      required this.year,
      required this.assignedTo,
        this.increaseResult,
   
      });

  factory TotalRealisation.fromJson(Map<String, dynamic> json) {
    return TotalRealisation(
        trimester: json["trimester"],
        year: json["year"],
        assignedTo: json["assigned_to"],
        increase: json["increase"],
        increaseResult:json["increaseResult"],
        realisations: (json["realisations"] as List)
            .map((item) => Realisation.fromJson(item))
            .toList());
  }

  factory TotalRealisation.fromUnstructuredJson(Map<String, dynamic> json) {
    return TotalRealisation(
      increase:
          double.tryParse((json["pct_resultat_salaire"] ?? "0").toString()) ??
              0,
       increaseResult:
          double.tryParse((json["pct_resultat_final"] ?? "0").toString()) ??
              0,
      assignedTo: json["assigned_to"],
      trimester: json["trimester"],
      year: json["year"],
 
      realisations: [
        Realisation(
          name: "GA",
          target: double.tryParse((json["target_ga"] ?? "0").toString()) ?? 0,
          currentValue:
              double.tryParse((json["real_ga"] ?? "0").toString()) ?? 0,
          percentage: double.tryParse((json["pct_ga"] ?? "0").toString()) ?? 0,
          percentagePond:  double.tryParse((json["pct_pond_ga"] ?? "0").toString()) ?? 0,
        ),
        Realisation(
          name: "Net Adds",
          target:
              double.tryParse((json["target_net_adds"] ?? "0").toString()) ?? 0,
          currentValue:
              double.tryParse((json["real_net_adds"] ?? "0").toString()) ?? 0,
          percentage:
              double.tryParse((json["pct_net_adds"] ?? "0").toString()) ?? 0,
                        percentagePond:  double.tryParse((json["pct_pond_net_adds"] ?? "0").toString()) ?? 0,

        ),
        Realisation(
          name: "Solutions",
          target:
              double.tryParse((json["target_solutions"] ?? "0").toString()) ??
                  0,
          currentValue:
              double.tryParse((json["real_solutions"] ?? "0").toString()) ?? 0,
          percentage:
              double.tryParse((json["pct_solutions"] ?? "0").toString()) ?? 0,
         percentagePond:  double.tryParse((json["pct_pond_solutions"] ?? "0").toString()) ?? 0,

        ),
        Realisation(
          name: "New Compte",
          target:
              double.tryParse((json["target_new_compte"] ?? "0").toString()) ??
                  0,
          currentValue:
              double.tryParse((json["real_new_compte"] ?? "0").toString()) ?? 0,
          percentage:
              double.tryParse((json["pct_new_compte"] ?? "0").toString()) ?? 0,
                       percentagePond:  double.tryParse((json["pct_pond_new_compte"] ?? "0").toString()) ?? 0,

        ),
         Realisation(
          name: "Evaluation",
          target:
              double.tryParse((json["target_eval_qual"] ?? "0").toString()) ??
                  0,
          currentValue:
              double.tryParse((json["real_eval_qual"] ?? "0").toString()) ?? 0,
          percentage:
              double.tryParse((json["pct_eval_qual"] ?? "0").toString()) ?? 0,
          percentagePond:  double.tryParse((json["pct_pond_eval_qual"] ?? "0").toString()) ?? 0,

        ),
      ],
    );
  }
}
