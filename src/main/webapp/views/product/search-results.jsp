<div class="row">
    <c:forEach items="${listP}" var="p">
        <div class="col-md-3">
            <div class="product-card">
                <img src="${p.image}" alt="${p.name}">
                <h5>${p.name}</h5>
                <p>${p.price}</p>

                <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}"
                   class="btn btn-primary">Xem chi tiết</a>
            </div>
        </div>
    </c:forEach>
</div>