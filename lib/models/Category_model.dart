

import 'dart:ui';

class Category{
   String id;
   String title;
   Color color;
  get getId => this.id;

 set setId( id) => this.id = id;

  get getTitle => this.title;

 set setTitle( title) => this.title = title;

  get getColor => this.color;

 set setColor( color) => this.color = color;

   Category({
    required this.id,
    required this.title,
    required this.color
  });
}