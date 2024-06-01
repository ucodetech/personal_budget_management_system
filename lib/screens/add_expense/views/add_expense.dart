import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {

TextEditingController expenseController = TextEditingController();
TextEditingController categoryController = TextEditingController();
TextEditingController dateController = TextEditingController();
DateTime selectDate = DateTime.now();
@override
  void initState() {
    // TODO: implement initState
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    super.initState();
  }

List<String> myCategoriesIcons = [
    'entertainment',
    'food',
    'shopping',
    'travel',
    'tech',
    'home',
    'pet',
];
String iconSelected = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
             children: [
                Text(
                  'Add Expenses',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
               const SizedBox(height: 16,),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextFormField(
                    controller: expenseController,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Amount',
                      prefixIcon: const Icon(FontAwesomeIcons.nairaSign, size: 16, color: Colors.grey),
                      border: OutlineInputBorder
                      (
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 65, 19, 73),
                          width: 2.0,
                        ),
                      ),
                       focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 148, 2, 2), // Border color when focused
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red, // Border color when there is an error
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    
                  ),
                ),
                const SizedBox(height: 16,),
                TextFormField(
                    controller: categoryController,
                    textAlignVertical: TextAlignVertical.center,
                    readOnly: true,
                    onTap: () {

                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Category',
                      prefixIcon: const Icon(FontAwesomeIcons.list, size: 16, color: Colors.grey),
                      suffixIcon:  IconButton(
                        onPressed: () {
                            showDialog(
                              context: context, 
                              builder: (ctx){
                                bool isExpanded = false;
                                return  StatefulBuilder(
                                  builder: (context, setState) {
                                  return AlertDialog(
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
                                              width:  MediaQuery.of(context).size.width,
                                              child: TextFormField(
                                                // controller: dateController,
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
                                                  prefixIcon: const Icon(FontAwesomeIcons.listCheck, size: 16, color: Colors.grey),
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
                                                      color: Color.fromARGB(255, 148, 2, 2), // Border color when focused
                                                      width: 2.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  errorBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                      color: Colors.red, // Border color when there is an error
                                                      width: 2.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                ),
                                                
                                              ),
                                            ),
                                            const SizedBox(height: 16,),
                                            TextFormField(
                                              // controller: dateController,
                                              onTap: () {
                                                 setState(() {
                                                        isExpanded = false;
                                                      });
                                              },
                                              textAlignVertical: TextAlignVertical.center,
                                              // ignore: dead_code
                                              readOnly: isExpanded ?  true : false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                filled: true,
                                                fillColor: Colors.white,
                                                hintText: 'Icon',
                                                prefixIcon: const Icon(FontAwesomeIcons.icons, size: 16, color: Colors.grey),
                                                suffixIcon:  IconButton(
                                                  onPressed: () {
                                                      setState(() {
                                                        isExpanded = !isExpanded;
                                                      });
                                                    },
                                                  icon: const Icon(FontAwesomeIcons.circleChevronDown, 
                                                  size: 16, 
                                                  color: Color.fromARGB(255, 53, 22, 58),
                                                  
                                                   ),
                                                   
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
                                                    color: Color.fromARGB(255, 148, 2, 2), // Border color when focused
                                                    width: 2.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red, // Border color when there is an error
                                                    width: 2.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                              ),
                                              
                                            ),
                                            isExpanded ?
                                            Container(
                                              width: MediaQuery.of(context).size.width,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(28),  
                                              ),
                                              child:  Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: GridView.builder(
                                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    mainAxisSpacing: 5,
                                                    crossAxisSpacing: 5
                                                  ),
                                                  itemCount: myCategoriesIcons.length,
                                                  itemBuilder:(context, int i){
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
                                                            width:3,
                                                            color: iconSelected == myCategoriesIcons[i]
                                                            ? const Color.fromARGB(255, 58, 27, 63) : Colors.grey
                                                          ),
                                                          color:  iconSelected == myCategoriesIcons[i]
                                                            ? Color.fromARGB(255, 206, 133, 219) : Colors.grey,
                                                          borderRadius:  BorderRadius.circular(100),
                                                          image: DecorationImage(
                                                            image: AssetImage(
                                                              'assets/${myCategoriesIcons[i]}.png',
                                                              ),
                                                              // fit: BoxFit.cover,
                                                          ),
                                                          
                                                        )
                                                      ),
                                                    );
                                                  } ,
                                                ),
                                              ),
                                            )
                                            : Container(),
                                            const SizedBox(height: 16,),
                                            TextFormField(
                                              // controller: dateController,
                                              textAlignVertical: TextAlignVertical.center,
                                              // readOnly: true,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                filled: true,
                                                fillColor: Colors.white,
                                                hintText: 'Color',
                                                prefixIcon: const Icon(FontAwesomeIcons.heartCircleCheck, size: 16, color: Colors.grey),
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
                                                    color: Color.fromARGB(255, 148, 2, 2), // Border color when focused
                                                    width: 2.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.red, // Border color when there is an error
                                                    width: 2.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                              ),
                                              
                                            ),
                                            
                                          ],
                                        ),
                                      );
                                  }
                                );
                               }
                              );
                        },
                        icon: const Icon(
                          FontAwesomeIcons.circlePlus, 
                          size: 16, 
                          color: Colors.grey
                         )
                        ),
                      border: OutlineInputBorder
                      (
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 65, 19, 73),
                          width: 2.0,
                        ),
                      ),
                       focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 148, 2, 2), // Border color when focused
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red, // Border color when there is an error
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    
                  ),
                 const SizedBox(height: 16,),
                TextFormField(
                  controller: dateController,
                    textAlignVertical: TextAlignVertical.center,
                    readOnly: true,
                    onTap: () async {
                      DateTime? newDate = await  showDatePicker(
                        context: context,
                        initialDate: selectDate,
                        firstDate: DateTime.now(), 
                        lastDate: DateTime.now().add(const Duration(days:365))
                        );

                        if(newDate != null){
                          setState(() {
                              dateController.text = DateFormat('dd/MM/yyyy').format(newDate);
                              selectDate = newDate;
                          });
                        }
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Date',
                      prefixIcon: const Icon(FontAwesomeIcons.clock, size: 16, color: Colors.grey),
                      border: OutlineInputBorder
                      (
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 65, 19, 73),
                          width: 2.0,
                        ),
                      ),
                       focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 148, 2, 2), // Border color when focused
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red, // Border color when there is an error
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    
                  ),
                 const SizedBox(height: 16,),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: kToolbarHeight,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 63, 0, 49),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.save,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            ),
        ),
        ),
    );
    
    
  }
}
