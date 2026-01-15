<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý người dùng</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <link rel="stylesheet" href="/assets/css/admin/usersAD.css">
</head>
<body>

<jsp:include page="headerAD.jsp"/>

<div class="container-fluid">
    <div class="row">
        <jsp:include page="sidebarAD.jsp">
            <jsp:param name="activePage" value="users"/>
        </jsp:include>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">

            <h2 class="h4 mb-0 text-gray-800 border-start border-primary border-3 ps-3">
                Quản Lý Khách Hàng
            </h2>

            <div class="card shadow-sm mb-4">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover table-bordered align-middle">
                            <thead class="table-head-custom">
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Họ và Tên</th>
                                <th scope="col">Email</th>
                                <th scope="col">Số điện thoại</th>
                                <th scope="col">Địa chỉ</th>
                                <th scope="col" class="text-center">Vai trò</th>
                                <th scope="col" class="text-center">Hành động</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${listUsers}" var="u">
                                <tr>
                                    <td><strong>#${u.id}</strong></td>
                                    <td class="fw-bold text-primary">${u.fullName}</td>
                                    <td>${u.email}</td>
                                    <td>${u.phone != "" ? u.phone : "<span class='text-muted'>---</span>"}</td>
                                    <td style="max-width: 200px;" class="text-truncate" title="${u.address}">
                                            ${u.address != "" ? u.address : "<span class='text-muted'>---</span>"}
                                    </td>
                                    <td class="text-center">
                                        <c:if test="${u.role == 1}">
                                            <span class="badge bg-danger rounded-pill">Admin</span>
                                        </c:if>
                                        <c:if test="${u.role == 0}">
                                            <span class="badge bg-success rounded-pill">Khách hàng</span>
                                        </c:if>
                                    </td>
                                    <td class="text-center">
                                        <form action="${pageContext.request.contextPath}/admin/users" method="post"
                                              onsubmit="return confirm('Bạn có chắc chắn muốn xóa user ${u.fullName}?');"
                                              style="display: inline-block;">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${u.id}">
                                            <button type="submit" class="btn btn-outline-danger btn-sm" title="Xóa">
                                                <i class="fa-solid fa-trash"></i>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>

                        <c:if test="${empty listUsers}">
                            <div class="alert alert-warning text-center mt-3" role="alert">
                                Chưa có dữ liệu người dùng nào trong hệ thống.
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>