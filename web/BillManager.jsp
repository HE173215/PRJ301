
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bill Manager</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
            }
            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }
            h1 {
                font-weight: 600;
                text-align: center;
                margin-bottom: 30px;
            }
            .filter-section {
                border-bottom: 2px solid #ccc;
                margin-bottom: 20px;
                padding-bottom: 20px;
            }
            .filter-section h5 {
                font-weight: 600;
                margin-bottom: 10px;
            }
            .filter-links a {
                margin-right: 20px;
                text-decoration: none;
                color: #333;
            }
            .filter-links a:hover {
                color: #007bff;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                border: 1px solid #ccc;
            }
            th, td {
                padding: 10px;
                border: 1px solid #ccc;
            }
            th {
                background-color: #f2f2f2;
                font-weight: 600;
            }
            .align-middle {
                vertical-align: middle;
            }
            .text-center {
                text-align: center;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Bill Manager</h1>

            <!-- Filter by status section -->
            <div class="filter-section">
                <h5>Filter by Status</h5>
                <div class="filter-links">
                    <!-- Status All -->
                    <a href="manageBill?service=filterStatus&filter=all">All Status</a>
                    <!-- Status Wait -->
                    <a href="manageBill?service=filterStatus&filter=wait">Wait</a>
                    <!-- Status Process -->
                    <a href="manageBill?service=filterStatus&filter=process">Process</a>
                    <!-- Status Done -->
                    <a href="manageBill?service=filterStatus&filter=done">Done</a>
                </div>
            </div>

            <!-- Bill details table -->
            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Customer Name</th>
                            <th>Created Date</th>
                            <th>Address</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th>Show Detail</th>
                            <th>Wait</th>
                            <th>Process</th>
                            <th>Done</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${billDetailForAdmins}" var="b">
                            <tr>
                                <td class="align-middle">${b.id}</td>
                                <td class="align-middle">${b.customerName}</td>
                                <td class="align-middle">${b.created_date}</td>
                                <td class="align-middle">${b.address}</td>
                                <td class="align-middle">${b.email}</td>
                                <td class="align-middle">${b.phone}</td>
                                <td class="align-middle">$${Math.round(b.total)*1.0}</td>
                                <td class="align-middle">${b.status}</td>
                                <td class="align-middle"><a href="manageBill?service=showDetailBill&billId=${b.id}&status=${b.status}">Show Detail</a></td>
                                <td><a href="manageBill?service=changeStatusToWait&billId=${b.id}">Wait</a></td>
                                <td><a href="manageBill?service=changeStatusToProcess&billId=${b.id}">Process</a></td>
                                <td><a href="manageBill?service=changeStatusToDone&billId=${b.id}">Done</a></td>
                        <td>
                            <a href="manageBill?service=deleteBill&billId=${b.id}&status=${b.status}" class="btn btn-sm btn-danger">
                                <i class="fas fa-trash"></i> Delete
                            </a>
                        </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:if test="${not empty billDetails}">



                <div class="col-lg-12 table-responsive mb-5">
                    <table class="table table-bordered text-center mb-0">
                        <thead class="bg-secondary text-dark">
                            <tr>
                                <th>BillID</th>
                                <th>Customer Name</th>
                                <th>Created Date</th>
                                <th>Product Name</th>
                                <th>Quantity</th>
                                <th>SubTotal</th>
                                <th>Bill Status</th>
                            </tr>
                        </thead>
                        <tbody class="align-middle">
                            <c:set var="total" value="0" />
                            <c:forEach var="billDetail" items="${billDetails}">
                                <c:set var="billId" value="${billDetail.id}"/>
                                <tr>
                                    <td class="align-middle">${billDetail.id}</td>
                                    <td class="align-middle">${billDetail.customerName}</td>
                                    <td class="align-middle">${billDetail.created_date}</td>
                                    <td class="align-middle">
                                        <img src="${billDetail.image_url}" alt="" style="width: 50px" />
                                        ${billDetail.productName}
                                    </td>
                                    <td class="align-middle">${billDetail.productQuantity}</td>
                                    <td class="align-middle">${Math.round(billDetail.subTotal)*1.0}</td>

                                    <td class="align-middle bill-status">
                                        ${status}
                                    </td>
                                </tr>
                                <c:set var="subtotal" value="${billDetail.subTotal}" />
                                <c:set var="total" value="${total + subtotal}" />
                                <c:set var="statusInShowDetail" value="${status}"/>
                            </c:forEach>
                            <tr><td colspan="7">&nbsp;</td></tr>
                            <tr>
                                <td colspan="4" style="text-align: right">Change Status of this Bill To:</td>
                                <td><a href="manageBill?service=changeStatusToWait&billId=${billId}&statusInShowDetail=${statusInShowDetail}">Wait</a></td>
                                <td><a href="manageBill?service=changeStatusToProcess&billId=${billId}&statusInShowDetail=${statusInShowDetail}">Process</a></td>
                                <td><a href="manageBill?service=changeStatusToDone&billId=${billId}&statusInShowDetail=${statusInShowDetail}">Done</a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="card border-secondary mb-5 col-lg-3" style="float: right">
                    <div class="card-footer border-secondary bg-transparent">
                        <div class="d-flex justify-content-between mt-2">
                            <h5 class="font-weight-bold">Total</h5>
                            <h5 class="font-weight-bold">$${Math.round(total)*1.0}</h5>
                        </div>
                    </div>
                </div>
            </c:if>

            <c:if test="${changeStatus ne null}">
                <div class="text-center">
                    <h3>${changeStatus}</h3>
                </div>
            </c:if>
    </body>
</html>
