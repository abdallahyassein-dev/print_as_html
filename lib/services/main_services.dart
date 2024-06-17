// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';

import 'package:printing/printing.dart';
import 'package:flutter/services.dart';
import 'package:print_as_html/models/products_model.dart';

printOrders({List<Product>? products, String? employeeName}) async {
  String createdAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  final logoByteData = await rootBundle.load('assets/images/logo.png');
  final logoBase64 = base64Encode(Uint8List.view(logoByteData.buffer));

  String items = '''
  <style>
    table {
      border-collapse: collapse;
      width: 100%;
    }
    th, td {
      border: 1px solid #ddd;
      padding: 8px;
      text-align: right;
    }
    th {
      background-color: #f2f2f2;
    }
  </style>

  <html dir="rtl">
  
  <div style="display: flex; align-items: center; justify-content: space-between;">
  <h1 class="header">فاتورة المنتجات</h1>
  <img src="data:image/png;base64, $logoBase64" alt="Company Logo" style="max-width:70px; max-height: 70px;"> <!-- Adjust the image URL and size as needed -->
  </div>

  <h3>تاريخ الفاتورة: $createdAt</h2>
  <h2 class="header">اسم الموظف: $employeeName</h2>
  
  
  <h2 class="header">التفاصيل:</h2>
  
  <table>
    <thead>
      <tr>
       <th>رقم المنتج</th>
       <th>اسم المنتج</th>
       <th>السعر</th>
       <th>السعر بعد الخصم</th>
       <th>عدد القطع</th>
       <th>ملحوظة</th>
       <th>التاريخ</th>
       <th>الاجمالي</th>
      </tr>
    </thead>
    <tbody>
  ''';
  double totalPrice = 0.0;
  for (var product in products!) {
    double total = product.priceAfterDiscount! * product.quantity!;
    totalPrice += total;
    items += '<tr>';
    items += '<td>${product.id}</td>';
    items += '<td>${product.name}</td>';
    items += '<td>${product.price} EG</td>';
    items += '<td>${product.priceAfterDiscount} EG</td>';
    items += '<td>${product.quantity} </td>';
    items += '<td>${product.note}</td>';
    items += '<td>${product.createdAt}</td>';
    items += '<td>$total EG</td>';
    items += '</tr>';
  }

  items += '</table>';
  items += '<h3>الاجمالى : $totalPrice EG </h3>';

  await Printing.layoutPdf(
    format: PdfPageFormat.roll80,
    onLayout: (format) async => await Printing.convertHtml(
      format: format,
      html: items,
    ),
  );
}
