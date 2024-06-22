import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_budget_managemet/screens/add_expense/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:personal_budget_managemet/widgets/button.dart';
import 'package:uuid/uuid.dart';


Future getCreateCategoryModule(BuildContext context){
  List<String> myCategoriesIcons = [
    'entertainment',
    'food',
    'shopping',
    'travel',
    'tech',
    'home',
    'pet',
  ];

  String message = '';

  return showDialog(
      context: context,
      builder: (ctx){
        bool isExpanded = false;
        String iconSelected = '';
        Color categoryColor = Colors.white;

        TextEditingController categoryNameController = TextEditingController();
        TextEditingController categoryIconController = TextEditingController();
        TextEditingController categoryColorController = TextEditingController();
        bool isLoading = false;
       Category category = Category.empty;

        return  BlocProvider.value(
          value: context.read<CreateCategoryBloc>(),
          child: StatefulBuilder(
            builder: (ctx, setState) {
              return BlocListener<CreateCategoryBloc, CreateCategoryState>(
                listener: (context, state) {
                  if (state is CreateCategorySuccess) {
                    setState(() {
                      message = "Category Created!";
                    });
                    Navigator.pop(ctx, category);
                  } else if (state is CreateCategoryLoading) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                },
                child: AlertDialog(
                  title: const Text(
                    textAlign: TextAlign.center,
                    'Create a Category',
                    style: TextStyle(
                      color: Color.fromARGB(255, 65, 19, 73),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 16,),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: TextFormField(
                          controller: categoryNameController,
                          textAlignVertical: TextAlignVertical.center,
                          // readOnly: true,
                          onTap: () {
                            setState(() {
                              isExpanded = false;
                            });
                          },

                          decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Name',
                            prefixIcon: const Icon(
                                FontAwesomeIcons.listCheck, size: 16,
                                color: Colors.grey),
                            border: OutlineInputBorder
                              (
                              borderRadius: BorderRadius.circular(28),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 65, 19, 73),
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 148, 2, 2),
                                // Border color when focused
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
                                // Border color when there is an error
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),

                        ),
                      ),
                      const SizedBox(height: 16,),

                      TextFormField(
                        controller: categoryIconController,

                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        
                        textAlignVertical: TextAlignVertical.center,
                        // ignore: dead_code
                        // readOnly: isExpanded ? true : false,
                        readOnly: true,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white,
                          hintText: iconSelected != '' ? iconSelected : 'Icon',
                          prefixIcon: const Icon(FontAwesomeIcons.icons,
                              size: 16, color: Colors.grey),
                          suffixIcon: const Icon(FontAwesomeIcons.circleChevronDown,
                              size: 16,
                              color: Color.fromARGB(255, 53, 22, 58),

                          ),
                          border: OutlineInputBorder
                            (
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 65, 19, 73),
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 148, 2, 2),
                              // Border color when focused
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                              // Border color when there is an error
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),

                      ),
                      isExpanded ?
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5
                            ),
                            itemCount: myCategoriesIcons.length,
                            itemBuilder: (context, int i) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    iconSelected = myCategoriesIcons[i];
                                  });
                                },
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 3,
                                          color: iconSelected ==
                                              myCategoriesIcons[i]
                                              ? const Color.fromARGB(
                                              255, 58, 27, 63) : Colors.grey
                                      ),
                                     
                                      borderRadius: BorderRadius.circular(100),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'assets/${myCategoriesIcons[i]}.png',
                                        ),
                                        scale: 2
                                        // fit: BoxFit.cover,
                                      ),

                                    )
                                ),
                              );
                            },
                          ),
                        ),
                      )
                          : Container(),
                      const SizedBox(height: 16,),

                      TextFormField(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (cxt2) {
                                return BlocProvider.value(
                                  value: context.read<CreateCategoryBloc>(),
                                  child: AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ColorPicker(
                                          pickerColor: categoryColor,
                                          onColorChanged: (value) {
                                            setState(() {
                                              categoryColor = value;
                                            });
                                          },
                                        ),
                                        //button
                                        const SizedBox(height: 16,),
                                        Button(
                                          text: 'Save Color',
                                          icon: Icons.save,
                                          onPressed: () {
                                            // save color
                                            Navigator.pop(cxt2);
                                          },
                                        ),

                                      ],
                                    ),
                                  ),
                                );
                              }
                          );
                        },
                        controller: categoryColorController,
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: categoryColor,
                          hintText: 'Color',
                          prefixIcon: const Icon(FontAwesomeIcons
                              .heartCircleCheck,
                              size: 16,
                              color: Colors.grey),
                          border: OutlineInputBorder
                            (
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 65, 19, 73),
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 148, 2, 2),
                              // Border color when focused
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                              // Border color when there is an error
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),

                      ),
                      const SizedBox(height: 16,),
                      SizedBox(
                        child: isLoading == true
                            ? const Center(child: CircularProgressIndicator(),)
                            : Button(
                          text: 'Save Category',
                          icon: Icons.save,
                          onPressed: () {
                            // create category and pop
                            setState(() {
                              category.categoryId = const Uuid().v1();
                              category.name = categoryNameController.text;
                              category.icon = categoryIconController.text != ''
                                  ? categoryIconController.text
                                  : iconSelected;
                              category.color = categoryColor.value;
                            });
                            
                            context.read<CreateCategoryBloc>().add(
                                CreateCategory(category));
                            // Navigator.pop(context);
                          },
                        ),
                      ),

                    ],
                  ),
                ),
              );
            },
          ),
        );
      }
  );
}