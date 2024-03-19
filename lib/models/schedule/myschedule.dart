class MySchedule {
  final String pol, polnm, pod, podnm;

  MySchedule.fromJson(Map<String, dynamic> json)
      : pol = json['pol'].toString(),
        polnm = json['polnm'].toString(),
        pod = json['pod'].toString(),
        podnm = json['podnm'].toString();
}
