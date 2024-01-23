import 'package:mobile_ebiz/models/schedule_detail.dart';

class Schedule {
  late String loadingPortCode,
      loadingPortName,
      dischargingPortCode,
      dischargingPortName;
  late String documentCutOffTime,
      cargoCutOffTime,
      departureDate,
      arrivalDate,
      availableForBooking;
  late String mrn, tsPortCode, tsPortName, callSign;
  List<ScheduleDetail> vesselInformation = [];

  Schedule();

  Schedule.fromJson(Map<String, dynamic> json)
      : loadingPortCode = json['LoadingPortCode'],
        loadingPortName = json['LoadingPortName'],
        dischargingPortCode = json['DischargingPortCode'],
        dischargingPortName = json['DischargingPortName'],
        documentCutOffTime = json['DocumentCutOffTime'],
        cargoCutOffTime = json['CargoCutOffTime'],
        departureDate = json['DepartureDate'],
        arrivalDate = json['ArrivalDate'],
        availableForBooking = json['AvailableForBooking'],
        mrn = json['MRN_Number'],
        tsPortCode = json['TS_PortCode'],
        tsPortName = json['TS_PortName'],
        callSign = json['CallSign'],
        vesselInformation = (json['VesselInformation'] as List)
            .map((i) => ScheduleDetail.fromJson(i))
            .toList();
}
