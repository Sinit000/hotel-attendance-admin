import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/shared/bloc/indexing/indexing_bloc.dart';

Future<void> dialogExport(BuildContext context) async {
  IndexingBloc dialogIndexBloc = IndexingBloc();
  // ExportBloc exportBloc = ExportBloc();
  // ExpenseListingBloc expenseListingBloc =
  //     ExpenseListingBloc(helper: RepositoryProvider.of<Helper>(context));
  // expenseListingBloc.rowPerPage = 1000000;
  // SaleBloc saleBloc = SaleBloc(
  //     helper: RepositoryProvider.of<Helper>(context),
  //     saleListingRepostory: SaleListingByNormalRepository(rowPerPage: 1000000));
  // CustomerBloc customerBloc = CustomerBloc(rowPerPage: 1000000);
  _mainDialog() {
    return SimpleDialog(
      title: Text("Choose Export"
        // AppLocalizations.of(context)!.translate("chooseExport")!
        ),
      children: <Widget>[
        SimpleDialogOption(
          padding: EdgeInsets.only(top: 13, bottom: 13, left: 25, right: 25),
          child: Text(
            "Employee",
            // AppLocalizations.of(context)!.translate("product")!,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          onPressed: () {
            // dialogIndexBloc.add(SetIndex(index: 1));
          },
        ),
        SimpleDialogOption(
          padding: EdgeInsets.only(top: 13, bottom: 13, left: 25, right: 25),
          child: Text(
            "Checkin/out",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          onPressed: () {
            // customerBloc.add(FetchCustomer());
          },
        ),
        SimpleDialogOption(
          padding: EdgeInsets.only(top: 13, bottom: 13, left: 25, right: 25),
          child: Text("Leave",
            // AppLocalizations.of(context)!.translate("sale")!,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          onPressed: () {
            
            // dialogIndexBloc.add(SetIndex(index: 2));
          },
        ),
        SimpleDialogOption(
          padding: EdgeInsets.only(top: 13, bottom: 13, left: 25, right: 25),
          child: Text("Overtime",
            // AppLocalizations.of(context)!.translate("expense")!,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          onPressed: () {
            // dialogIndexBloc.add(SetIndex(index: 3));
          },
        ),
        
      ],
    );
  }

  // _productDialog() {
  //   BlocProvider.of<CategoryBloc>(context).add(FetchCategory());
  //   return SimpleDialog(
  //     title: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         IconButton(
  //           onPressed: () {
  //             dialogIndexBloc.add(SetIndex(index: 0));
  //           },
  //           icon: Icon(Icons.arrow_back_outlined),
  //         ),
  //         SizedBox(width: 10),
  //         Expanded(
  //           child: Text(
  //             AppLocalizations.of(context)!.translate("chooseCategory")!,
  //             maxLines: 3,
  //           ),
  //         ),
  //       ],
  //     ),
  //     children: <Widget>[
  //       BlocBuilder<CategoryBloc, CategoryState>(
  //         builder: (c, state) {
  //           if (state is ErrorFetchingCategory) {
  //             return Center(
  //               child: TextButton(
  //                 onPressed: () {
  //                   BlocProvider.of<CategoryBloc>(context).add(FetchCategory());
  //                 },
  //                 child: Text("Retry"),
  //               ),
  //             );
  //           } else if (state is FetchedCategory) {
  //             return SingleChildScrollView(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   SimpleDialogOption(
  //                     child: Text(
  //                       "All",
  //                       style: Theme.of(context).textTheme.subtitle1,
  //                     ),
  //                     onPressed: () {
  //                       BlocProvider.of<ProductBloc>(context)
  //                               .productRepository =
  //                           ProductList(rowPerPage: 1000000);
  //                       BlocProvider.of<ProductBloc>(context).pageIndex = 1;
  //                       BlocProvider.of<ProductBloc>(context).hasMore = true;
  //                       BlocProvider.of<ProductBloc>(context).products = [];
  //                       BlocProvider.of<ProductBloc>(context)
  //                           .add(GetMoreProducts());
  //                     },
  //                   ),
  //                   ...BlocProvider.of<CategoryBloc>(context).category!.map(
  //                         (data) => SimpleDialogOption(
  //                           padding: EdgeInsets.only(
  //                               top: 13, bottom: 13, left: 25, right: 25),
  //                           child: Text(
  //                             data.name!,
  //                             style: Theme.of(context).textTheme.subtitle1,
  //                           ),
  //                           onPressed: () {
  //                             BlocProvider.of<ProductBloc>(context)
  //                                     .productRepository =
  //                                 ProductListByCategory(
  //                                     rowPerPage: 1000000, category: data);
  //                             BlocProvider.of<ProductBloc>(context).pageIndex =
  //                                 1;
  //                             BlocProvider.of<ProductBloc>(context).hasMore =
  //                                 true;
  //                             BlocProvider.of<ProductBloc>(context).products =
  //                                 [];
  //                             BlocProvider.of<ProductBloc>(context)
  //                                 .add(GetMoreProducts());
  //                           },
  //                         ),
  //                       )
  //                 ],
  //               ),
  //             );
  //           } else {
  //             return Center(
  //               child: CircularProgressIndicator(),
  //             );
  //           }
  //         },
  //       ),
  //     ],
  //   );
  // }

  // _saleDialog() {
  //   return SimpleDialog(
  //     title: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         IconButton(
  //           onPressed: () {
  //             dialogIndexBloc.add(SetIndex(index: 0));
  //           },
  //           icon: Icon(Icons.arrow_back_outlined),
  //         ),
  //         SizedBox(width: 10),
  //         Expanded(
  //           child: Text(
  //             AppLocalizations.of(context)!.translate("chooseDate")!,
  //             maxLines: 3,
  //           ),
  //         ),
  //       ],
  //     ),
  //     children: <Widget>[
  //       Center(
  //         child: DropdownButton<String>(
  //           hint: Text(
  //             "Choose here",
  //             textScaleFactor: 1,
  //           ),
  //           items: ['Today', 'This week', 'This month', 'This year', "Custom"]
  //               .map((String value) {
  //             return DropdownMenuItem<String>(
  //               value: value,
  //               child: Text(
  //                 AppLocalizations.of(context)!.translate(value)!,
  //               ),
  //             );
  //           }).toList(),
  //           onChanged: (value) {
  //             if (value == "Custom") {
  //               RepositoryProvider.of<Helper>(context).showPickerDateRange(
  //                   context, onConfirmed: (startDate, endDate) {
  //                 saleBloc.add(InitializeSaleReport(
  //                     dateRange: '$startDate/$endDate', getSummary: false));
  //               });
  //             } else {
  //               saleBloc.add(
  //                   InitializeSaleReport(dateRange: value!, getSummary: false));
  //             }
  //             // BlocProvider.of<ReportBloc>(context)
  //             //     .add(FetchReportStarted(dateRange: value));
  //           },
  //         ),
  //       )
  //     ],
  //   );
  // }

  // _expenseDialog() {
  //   return SimpleDialog(
  //     title: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         IconButton(
  //           onPressed: () {
  //             dialogIndexBloc.add(SetIndex(index: 0));
  //           },
  //           icon: Icon(Icons.arrow_back_outlined),
  //         ),
  //         SizedBox(width: 10),
  //         Expanded(
  //           child: Text(
  //             AppLocalizations.of(context)!.translate("chooseDate")!,
  //             maxLines: 3,
  //           ),
  //         ),
  //       ],
  //     ),
  //     children: <Widget>[
  //       Center(
  //         child: DropdownButton<String>(
  //           hint: Text(
  //             "Choose here",
  //             textScaleFactor: 1,
  //           ),
  //           items: ['Today', 'This week', 'This month', 'This year', "Custom"]
  //               .map((String value) {
  //             return DropdownMenuItem<String>(
  //               value: value,
  //               child: Text(
  //                 AppLocalizations.of(context)!.translate(value)!,
  //               ),
  //             );
  //           }).toList(),
  //           onChanged: (value) {
  //             if (value == "Custom") {
  //               RepositoryProvider.of<Helper>(context).showPickerDateRange(
  //                   context, onConfirmed: (startDate, endDate) {
  //                 expenseListingBloc.add(
  //                     InitializeExpenseList(dateRange: '$startDate/$endDate'));
  //               });
  //             } else {
  //               expenseListingBloc
  //                   .add(InitializeExpenseList(dateRange: value!));
  //             }
  //             // BlocProvider.of<ReportBloc>(context)
  //             //     .add(FetchReportStarted(dateRange: value));
  //           },
  //         ),
  //       )
  //     ],
  //   );
  // }

  List<SimpleDialog> dialogList = [
    _mainDialog(),
    // _productDialog(),
    // _saleDialog(),
    // _expenseDialog()
  ];
  return await showDialog(
    context: context, builder: (BuildContext context){
      return dialogList[0];
  });

  // return await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return BlocListener<ProductBloc, ProductState>(
  //         listener: (c, state) async {
  //           if (state is FetchingProducts) {
  //             loadingDialogs(context);
  //           }
  //           if (state is ErrorFetching) {
  //             Navigator.of(context).pop();
  //             errorSnackBar(text: state.error.toString(), context: context);
  //           } else if (state is FetchedProducts) {
  //             Navigator.of(context).pop();
  //             ProductRepository p =
  //                 BlocProvider.of<ProductBloc>(context).productRepository;
  //             String _fileName = "";
  //             log(p.runtimeType.toString());
  //             if (p is ProductListByCategory) {
  //               _fileName = "Product (${p.category.name})";
  //             } else {
  //               _fileName = "Product";
  //             }
  //             exportBloc.add(ExportProduct(
  //                 productList: BlocProvider.of<ProductBloc>(context).products,
  //                 fileName: _fileName));
  //           }
  //         },
  //         child: BlocListener(
  //           bloc: saleBloc,
  //           listener: (c, state) {
  //             log(state.toString());
  //             if (state is InitializingSaleReport) {
  //               loadingDialogs(c);
  //             }
  //             if (state is ErrorInitializingSaleReport) {
  //               Navigator.of(c).pop();
  //               errorSnackBar(text: state.error.toString(), context: c);
  //             }
  //             if (state is InitializedSaleReport) {
  //               Navigator.of(c).pop();
  //               // Navigator.of(c).pop();
  //               // Navigator.of(c).pop();
  //               exportBloc.add(ExportSale(
  //                   saleList: saleBloc.saleReport,
  //                   fileName:
  //                       "Sale (${saleBloc.startDate} to ${saleBloc.endDate.split(' ').first})"));
  //             }
  //           },
  //           child: BlocListener(
  //             bloc: expenseListingBloc,
  //             listener: (c, state) {
  //               log(state.toString());
  //               if (state is InitializingExpenseList) {
  //                 loadingDialogs(c);
  //               }
  //               if (state is ErrorInitializingExpenseList) {
  //                 Navigator.of(c).pop();
  //                 errorSnackBar(text: state.error.toString(), context: c);
  //               }
  //               if (state is InitializedExpenseList) {
  //                 Navigator.of(c).pop();
  //                 // Navigator.of(c).pop();
  //                 // Navigator.of(c).pop();
  //                 exportBloc.add(ExportExpense(
  //                     expenseList: expenseListingBloc.expenseList,
  //                     fileName:
  //                         "Expense (${expenseListingBloc.startDate} to ${expenseListingBloc.endDate!.split(' ').first})"));
  //               }
  //             },
  //             child: BlocListener(
  //               bloc: customerBloc,
  //               listener: (c, state) {
  //                 if (state is FetchingCustomer) {
  //                   loadingDialogs(context);
  //                 }
  //                 if (state is ErrorFetchingCustomer) {
  //                   Navigator.of(c).pop();
  //                   errorSnackBar(text: state.error.toString(), context: c);
  //                 }
  //                 if (state is FetchedCustomer) {
  //                   Navigator.of(c).pop();

  //                   exportBloc.add(ExportExpense(
  //                       expenseList: expenseListingBloc.expenseList,
  //                       fileName: "Customer"));
  //                 }
  //               },
  //               child: BlocListener(
  //                 bloc: exportBloc,
  //                 listener: (c, state) {
  //                   if (state is Exporting) {
  //                     loadingDialogs(context);
  //                   }
  //                   if (state is Exported) {
  //                     Navigator.of(context).pop();
  //                   }
  //                   if (state is ErrorExporting) {
  //                     Navigator.of(context).pop();
  //                     errorSnackBar(
  //                         text: state.error.toString(), context: context);
  //                   }
  //                 },
  //                 child: BlocBuilder(
  //                     bloc: dialogIndexBloc,
  //                     builder: (c, int state) {
  //                       return dialogList[state];
  //                     }),
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     }).then((value) {
  //   // dialogIndexBloc.close();
  //   // exportBloc.close();
  //   // expenseListingBloc.close();
  //   // saleBloc.close();
  //   // customerBloc.close();
  // });
}
