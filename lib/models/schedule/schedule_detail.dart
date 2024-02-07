class ScheduleDetail {
  final int vesselSequence;
  final String serviceCode, vesselCode, vesselName, voyageNumber;
  final String loadingPortCode,
      loadingPortName,
      loadingTerminalCode,
      loadingTerminalName;
  final String dischargingPortCode,
      dischargingPortName,
      dischargingTerminalCode,
      dischargingTerminalName;
  final String departureDate, arrivalDate;

  ScheduleDetail.fromJson(Map<String, dynamic> json)
      : vesselSequence = json['VesselSequence'],
        serviceCode = json['ServiceCode'] ?? '',
        vesselCode = json['VesselCode'] ?? '',
        vesselName = json['VesselName'],
        voyageNumber = json['VoyageNumber'] ?? '',
        loadingPortCode = json['LoadingPortCode'],
        loadingPortName = json['LoadingPortName'],
        loadingTerminalCode = json['LoadingTerminalCode'] ?? '',
        loadingTerminalName = json['LoadingTerminalName'] ?? '',
        dischargingPortCode = json['DischargingPortCode'],
        dischargingPortName = json['DischargingPortName'],
        dischargingTerminalCode = json['DischargingTerminalCode'] ?? '',
        dischargingTerminalName = json['DischargingTerminalName'] ?? '',
        departureDate = json['DepartureDate'] ?? '',
        arrivalDate = json['ArrivalDate'] ?? '';
}
