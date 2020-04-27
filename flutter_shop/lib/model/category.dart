
//一级分类
class CategoryBigModel extends Object{
  String mallCategoryId;
  String mallCategoryName;
  List<dynamic> bxMallSubDto;
  Null comments;
  String image;

  CategoryBigModel({this.mallCategoryId,this.mallCategoryName,this.bxMallSubDto, this.comments,this.image});

  factory CategoryBigModel.fromJson(dynamic json){
    return CategoryBigModel(
      mallCategoryId: json["mallCategoryId"],
      mallCategoryName: json["mallCategoryName"],
      bxMallSubDto: json["bxMallSubDto"],
      comments: json["comments"],
      image: json["image"]
    );
  }
}

//总体数据
class CategoryBigListModel extends Object{
  List<CategoryBigModel> data;

  CategoryBigListModel(List<CategoryBigModel> list, {this.data});

  factory CategoryBigListModel.fromJson(List json){
    return CategoryBigListModel(
      json.map((i) => CategoryBigModel.fromJson(i)).toList()
    );
  }

}

