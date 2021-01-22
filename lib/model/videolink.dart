class Videolink {
  final String videotitle;
  final String videolink;

  Videolink({this.videotitle, this.videolink});

  String toParams() => "?videotitle=$videotitle&videolink=$videolink";
}
