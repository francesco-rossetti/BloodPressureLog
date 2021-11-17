import 'package:bloodpressurelog/domain/lang/app_localization.dart';
import 'package:bloodpressurelog/domain/providers/measurement_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterMeasurements extends StatelessWidget {
  const FilterMeasurements({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
            child: Card(
                child: Column(children: [
              const SizedBox(height: 10),
              Text(AppLocalizations.of(context)!.translate("filter")!,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                  height: 50,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: [
                        TextButton(
                          child: Text(
                              AppLocalizations.of(context)!.translate("week")!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal)),
                          onPressed: () {
                            Provider.of<MeasurementProvider>(context,
                                    listen: false)
                                .changeFilter(0);
                          },
                        ),
                        TextButton(
                          child: Text(
                              AppLocalizations.of(context)!.translate("month")!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal)),
                          onPressed: () {
                            Provider.of<MeasurementProvider>(context,
                                    listen: false)
                                .changeFilter(1);
                          },
                        ),
                        TextButton(
                          child: Text(
                              AppLocalizations.of(context)!.translate("year")!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal)),
                          onPressed: () {
                            Provider.of<MeasurementProvider>(context,
                                    listen: false)
                                .changeFilter(2);
                          },
                        ),
                        TextButton(
                          child: Text(
                              AppLocalizations.of(context)!.translate("all")!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal)),
                          onPressed: () {
                            Provider.of<MeasurementProvider>(context,
                                    listen: false)
                                .changeFilter(3);
                          },
                        )
                      ]))
            ]))));
  }
}
