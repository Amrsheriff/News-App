import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import '../../modules/web_view/web_view.dart';
// import 'package:untitled/modules/web_view/web_view.dart';


Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  height = 50.0,
  double radius = 10,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChanged,
  required Function validate,
  required String label,
  required IconData prefix,
  bool isPassword = false,
  IconData? suffix,
  Function? onPressed,
  Function? onTap,
  context,
  double radius = 10.0,
}) =>
    TextFormField(
      controller: controller,
      onTap: () {
        onTap!();
      },
      keyboardType: type,
      onFieldSubmitted: (value) {
        return onSubmit!(value);
      },
      // onChanged: (value) {
      //   return onChanged!(value);
      // },
      validator: (value) {
        return validate(value);
      },
      obscureText: isPassword,
      decoration: InputDecoration(
        // focusedBorder: OutlineInputBorder(
        //   borderSide: BorderSide(
        //       color: Colors.white,
        //   ),
        // ),

        labelText: label,
        labelStyle: Theme.of(context).textTheme.bodyText2,
        prefixIcon: Icon(
          prefix,

        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  onPressed!();
                },
                icon: Icon(suffix),
              )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius),
      ),

      ),
    );




Widget buildSwipeActionRight() => Container(
  alignment: Alignment.centerRight,
  padding: EdgeInsets.symmetric(horizontal: 20.0),
  color: Colors.red,
  child: Icon(Icons.delete,
    color: Colors.white,
    size: 32.0,
  ),

);


Widget SeparatorPadding() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget buildArticleItem(article, context)=> InkWell(
  onTap: (){
    navigateTo(context, webViewScreen(article['url']));
  },
  child:   Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children: [
  
        Container(
  
          width: 120.0,
  
          height: 120.0,
  
          decoration: BoxDecoration(
  
            borderRadius: BorderRadius.circular(10.0),
  
            image: DecorationImage(
  
              image: NetworkImage('${article['urlToImage']}'),
  
              fit: BoxFit.cover,
  
            ),
  
          ),
  
        ),
  
        SizedBox(
  
          width: 20,
  
        ),
  
        Expanded(
  
          child: Container(
  
            height: 120.0,
  
            child: Column(
  
              mainAxisAlignment: MainAxisAlignment.start,
  
              crossAxisAlignment: CrossAxisAlignment.start,
  
              children: [
  
                Expanded(
  
                  child: Text(
  
                    '${article['title']}',
  
                    style: Theme.of(context).textTheme.bodyText1,
  
                    maxLines: 3,
  
                    overflow: TextOverflow.ellipsis,
  
                  ),
  
                ),
  
                Text(
  
                  '${article['publishedAt']}',
  
                  style: TextStyle(
  
                    color: Colors.grey,
  
                  ),
  
                ),
  
              ],
  
            ),
  
          ),
  
        ),
  
      ],
  
    ),
  
  ),
);

Widget articleBuilder(list, context,{isSearch = false})=> ConditionalBuilder(
    condition: list.length>0,
    builder: (context) => ListView.separated(
      //physics: ClampingScrollPhysics(),
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildArticleItem(list[index], context),
      separatorBuilder: (context, index) => SeparatorPadding(),
      itemCount: list.length,
    ),
    fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator())
);

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
      builder: (context) => widget,
  ),
);

Widget defaultFormFieldSearch({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  required Function onChange,
  required String hint_label,
  required IconData prefix,
  bool isPassword = false,
  IconData? suffix,
  Function? onPressed,
  Function? onTap,
  context,
  double radius = 10.0,
}) =>
    TextFormField(
      onChanged: (value){
        return onChange(value);
      },
      controller: controller,
      onTap: () {
        onTap!();
      },
      style: Theme.of(context).textTheme.bodyText2,
      keyboardType: type,
      onFieldSubmitted: (value) {
        return onSubmit!(value);
      },
      // onChanged: (value) {
      //   return onChanged!(value);
      // },
      obscureText: isPassword,
      decoration: InputDecoration(
         contentPadding:
         EdgeInsets.only(left: 0, bottom: 0, top: 14, right: 0), // make a space in text filed not form field
        // focusedBorder: OutlineInputBorder(
        //   borderSide: BorderSide(
        //       color: Colors.white,
        //   ),
        // ),
        border: InputBorder.none,
        hintText: hint_label,
        hintStyle: Theme.of(context).textTheme.bodyText2,
        //labelStyle: Theme.of(context).textTheme.bodyText2,
        prefixIcon: Icon(
          prefix,
          color: Theme.of(context).primaryColorDark,

        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: () {
            onPressed!();
          },
          icon: Icon(suffix),
        )
            : null,
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius),
        ),

      );


