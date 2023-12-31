
import 'package:flutter_spring/models/Status.dart';

class Tool{
   int id;
   int category;
   String title;
   String imageUrl;
   String smallDescription;
   double rentPriceParHour;
   Status? status;


   Tool({
     this.id=0,
     this.category=0,
     this.title="",
     this.imageUrl="",
     this.smallDescription="",
     this.rentPriceParHour=0.0,
     this.status=null
  });

  get getId => this.id;

 set setId( id) => this.id = id;

  get getCategory => this.category;

 set setCategory( category) => this.category = category;

  get getTitle => this.title;

 set setTitle( title) => this.title = title;

  get getImageUrl => this.imageUrl;

 set setImageUrl( imageUrl) => this.imageUrl = imageUrl;

  get getSmallDescription => this.smallDescription;

 set setSmallDescription( smallDescription) => this.smallDescription = smallDescription;

  get getRentPriceParHour => this.rentPriceParHour;

 set setRentPriceParHour( rentPriceParHour) => this.rentPriceParHour = rentPriceParHour;

  get getStatus => this.status;

 set setStatus( status) => this.status = status;
@override
    String toString() => '{id:$id,category:$category,title:$title,imageUrl:$imageUrl,smallDescription:$smallDescription,rentPriceParHour:$rentPriceParHour}';
}

