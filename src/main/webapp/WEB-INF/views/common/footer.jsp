<%-- src/main/webapp/WEB-INF/views/common/footer.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

    <a id="back-to-top" class="backtop" href="#"><i class="fa fa-angle-up"></i></a>

    <footer>
        <div class="copyright">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12 fot_copyright">
                        <span>&copy; 2025 Bản quyền thuộc về <b>LT Web Team</b></span>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <%-- LIÊN KẾT JS ĐÃ THU THẬP --%>
    <script src="${contextPath}/assets/js/libs/jquery.min.js"></script>
    <script src="${contextPath}/assets/js/libs/swiper.min.js"></script>
    <script src="${contextPath}/assets/js/libs/lazyload.min.js"></script>
    <script src="${contextPath}/assets/js/libs/notify.js"></script>
    <script src="${contextPath}/assets/js/libs/js.cookie.js"></script>

    <script src="${contextPath}/assets/js/main.js"></script>

</body>
</html>