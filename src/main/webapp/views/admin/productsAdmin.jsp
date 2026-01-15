<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Sản Phẩm</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <link rel="stylesheet" href="/assets/css/admin/productAD.css">
</head>
<body class="bg-light">

<jsp:include page="headerAD.jsp" />

<div class="container-fluid">
    <div class="row">

        <jsp:include page="sidebarAD.jsp">
            <jsp:param name="activePage" value="products" />
        </jsp:include>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="h4 mb-0 text-gray-800 border-start border-primary border-3 ps-3">
                    Danh Sách Sản Phẩm
                </h2>
                <button class="btn btn-primary shadow-sm" data-bs-toggle="modal" data-bs-target="#productModal" onclick="resetForm()">
                    <i class="fas fa-plus-circle me-1"></i> Thêm Sản Phẩm
                </button>
            </div>

            <c:if test="${not empty message}">
                <div class="alert alert-info alert-dismissible fade show" role="alert">
                        ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="card shadow mb-4">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover align-middle mb-0">
                            <thead class="table-dark">
                            <tr>
                                <th style="width: 50px;">ID</th>
                                <th style="width: 70px;">Ảnh</th>
                                <th>Tên Sản Phẩm</th>
                                <th style="width: 120px;">Giá</th>
                                <th style="width: 90px;" class="text-center">Số lượng</th>
                                <th style="width: 150px;">Danh mục</th>
                                <th style="width: 100px;" class="text-center">Tác vụ</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${listProducts}" var="p">
                                <tr>
                                    <td class="fw-bold text-secondary">#${p.id}</td>

                                    <td>
                                        <img src="${empty p.image ? 'https://via.placeholder.com/50' : p.image}"
                                             class="rounded border" style="width: 40px; height: 40px; object-fit: cover;">
                                    </td>

                                    <td class="fw-bold text-dark">${p.name}</td>

                                    <td class="text-danger fw-bold">
                                        <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫"/>
                                    </td>

                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${p.stock < 10}">
                                                <span class="badge bg-danger">${p.stock}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-success">${p.stock}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <span class="badge bg-light text-dark border border-secondary border-opacity-25">
                                                ${p.category}
                                        </span>
                                    </td>

                                    <td class="text-center">
                                        <button class="btn btn-sm btn-outline-primary border-0"
                                                title="Sửa"
                                                data-bs-toggle="modal"
                                                data-bs-target="#productModal"
                                                onclick="editProduct('${p.id}', '${p.name}', ${p.price}, '${p.image}', '${p.category}', ${p.stock}, ${p['new']}, ${p.hot})">
                                            <i class="fas fa-pen"></i>
                                        </button>

                                        <button class="btn btn-sm btn-outline-danger border-0 ms-1"
                                                title="Xóa"
                                                data-bs-toggle="modal"
                                                data-bs-target="#deleteModal"
                                                onclick="setDeleteId('${p.id}')">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<div class="modal fade" id="productModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form action="products" method="post">
                <input type="hidden" name="action" id="formAction" value="create">
                <input type="hidden" name="id" id="productId" value="0">

                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title fw-bold" id="modalTitle">Thêm Sản Phẩm</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold">Tên sản phẩm</label>
                            <input type="text" class="form-control" id="name" name="name" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold">Giá bán</label>
                            <input type="number" class="form-control" id="price" name="price" required min="0">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold">Danh mục</label>
                            <input type="text" class="form-control" id="category" name="category">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold">Số lượng</label>
                            <input type="number" class="form-control" id="stock" name="stock" value="0" min="0">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Link ảnh</label>
                        <input type="text" class="form-control" id="image" name="image">
                    </div>

                    <div class="d-flex gap-4 p-3 rounded bg-light border">
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="isNew" name="isNew" value="true">
                            <label class="form-check-label" for="isNew">Hàng mới (New)</label>
                        </div>
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="isHot" name="isHot" value="true">
                            <label class="form-check-label" for="isHot">Bán chạy (Hot)</label>
                        </div>
                    </div>
                </div>

                <div class="modal-footer bg-light">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary px-4">Lưu</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title fw-bold">Xác nhận xóa</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body text-center py-4">
                <p class="fs-5">Bạn có chắc muốn xóa sản phẩm này?</p>
            </div>
            <div class="modal-footer justify-content-center bg-light">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Không</button>
                <form action="products" method="post">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" id="deleteId">
                    <button type="submit" class="btn btn-danger px-4">Xóa</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function resetForm() {
        document.getElementById("modalTitle").innerText = "Thêm Sản Phẩm Mới";
        document.getElementById("formAction").value = "create";
        document.getElementById("productId").value = "0";
        document.getElementById("name").value = "";
        document.getElementById("price").value = "";
        document.getElementById("category").value = "";
        document.getElementById("stock").value = "0";
        document.getElementById("image").value = "";
        document.getElementById("isNew").checked = false;
        document.getElementById("isHot").checked = false;
    }

    function editProduct(id, name, price, image, category, stock, isNew, isHot) {
        document.getElementById("modalTitle").innerText = "Cập Nhật Sản Phẩm";
        document.getElementById("formAction").value = "update";
        document.getElementById("productId").value = id;
        document.getElementById("name").value = name;
        document.getElementById("price").value = price;
        document.getElementById("image").value = image;
        document.getElementById("category").value = category;
        document.getElementById("stock").value = stock;
        document.getElementById("isNew").checked = isNew;
        document.getElementById("isHot").checked = isHot;
    }

    function setDeleteId(id) {
        document.getElementById("deleteId").value = id;
    }
</script>

</body>
</html>