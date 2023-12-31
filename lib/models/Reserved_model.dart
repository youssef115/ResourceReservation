
import 'package:flutter_spring/models/tool_model.dart';

class ReservedTools{
  int id;
  int time;
  int duration;
  int userId;
  Tool? tool;
  get getId => this.id;

 set setId( id) => this.id = id;

  get getTime => this.time;

 set setTime( time) => this.time = time;

  get getDuration => this.duration;

 set setDuration( duration) => this.duration = duration;

  get getUserId => this.userId;

 set setUserId( userId) => this.userId = userId;

  get getTool => this.tool;

 set setTool( toolId) => this.tool = tool;

ReservedTools({
  this.id=0,
  this.time=0,
  this.duration=0,
  this.userId=0,
  this.tool=null
  });



}