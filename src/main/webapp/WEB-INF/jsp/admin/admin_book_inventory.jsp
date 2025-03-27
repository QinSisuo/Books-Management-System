<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>图书库存管理</title>
    <!-- 引入外部 CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.19/dist/sweetalert2.min.js"></script>
</head>

<body>
    <!-- 引入公共头部 -->
    <%@ include file="../common/header.jsp" %>
    <%@ include file="../common/admin_navbar.jsp" %>
    <%@ include file="../common/footer.jsp" %>

    <!-- 统一面板 -->
    <div class="container">

        <!-- 统一搜索框 -->
        <div class="container" style="margin-top: 20px; margin-bottom: 20px; max-width: 600px; margin-left: -15px;">
            <form action="admin_book_inventory.html" method="get" class="form-inline">
                <div class="form-group">
                    <input type="text" class="form-control" name="searchWord"
                           placeholder="输入图书名称" value="${searchWord}" style="width: 300px;" />
                </div>
                &nbsp;
                <button type="submit" class="btn btn-primary">搜索</button>
            </form>
        </div>

        <!-- 标题和新增按钮 -->
        <div class="panel panel-default">
            <div class="panel-heading bg-white">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h3 class="panel-title mb-0">📚 图书库存管理</h3>
                    </div>
                </div>
            </div>
        </div>

        <!-- 显示列表 -->
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>图书ID</th>
                    <th>图书名称</th>
                    <th>ISBN</th>
                    <th>总库存</th>
                    <th>已借数量</th>
                    <th>可借数量</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${books}" var="book">
                    <tr>
                        <td>${book.bookId}</td>
                        <td>${book.name}</td>
                        <td>${book.isbn}</td>
                        <td>${book.totalCount == null ? 0 : book.totalCount}</td>
                        <td>${book.lentCount == null ? 0 : book.lentCount}</td>
                        <td>${(book.totalCount == null ? 0 : book.totalCount) - (book.lentCount == null ? 0 : book.lentCount)}</td>
                        <td>
                            <button type="button" class="btn btn-success btn-xs"
                                    onclick="openAddStockModal(${book.bookId}, '${book.name}')">
                                <i class="fas fa-plus"></i> 入库
                            </button>
                            <button type="button" class="btn btn-warning btn-xs"
                                    onclick="openReduceStockModal(${book.bookId}, '${book.name}')">
                                <i class="fas fa-minus"></i> 出库
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>


    <!-- 入库模态框 -->
    <div class="modal fade" id="addStockModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">图书入库</h4>
                </div>
                <div class="modal-body">
                    <form id="addStockForm">
                        <input type="hidden" id="addBookId" name="bookId">
                        <div class="form-group">
                            <label>图书名称</label>
                            <input type="text" class="form-control" id="addBookName" readonly>
                        </div>
                        <div class="form-group">
                            <label>入库数量</label>
                            <input type="number" class="form-control" name="count" min="1" required>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="submitAddStock()">确定</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 出库模态框 -->
    <div class="modal fade" id="reduceStockModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">图书出库</h4>
                </div>
                <div class="modal-body">
                    <form id="reduceStockForm">
                        <input type="hidden" id="reduceBookId" name="bookId">
                        <div class="form-group">
                            <label>图书名称</label>
                            <input type="text" class="form-control" id="reduceBookName" readonly>
                        </div>
                        <div class="form-group">
                            <label>出库数量</label>
                            <input type="number" class="form-control" name="count" min="1" required>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="submitReduceStock()">确定</button>
                </div>
            </div>
        </div>
    </div>

    <script>
    function openAddStockModal(bookId, bookName) {
        $('#addBookId').val(bookId);
        $('#addBookName').val(bookName);
        $('#addStockModal').modal('show');
    }

    function openReduceStockModal(bookId, bookName) {
        $('#reduceBookId').val(bookId);
        $('#reduceBookName').val(bookName);
        $('#reduceStockModal').modal('show');
    }

    function submitAddStock() {
        var formData = $("#addStockForm").serialize();
        $.ajax({
            url: "admin_book_stock_add.html",
            type: "POST",
            data: formData,
            dataType: "json",
            success: function(response) {
                if(response.success) {
                    Swal.fire({
                        title: '入库成功！',
                        icon: 'success',
                        showConfirmButton: false,
                        timer: 2000
                    });

                    setTimeout(function () {
                        window.location.href = 'admin_book_inventory.html';
                    }, 2000);

                } else {
                    Swal.fire({
                        title: '错误',
                        text: response.message || '入库失败，请重试！',
                        icon: 'error'
                    });
                }
            },
            error: function(xhr, status, error) {
                Swal.fire({
                    title: '错误',
                    text: '系统错误，请重试！',
                    icon: 'error'
                });
            }
        });
    }

    function submitReduceStock() {
        var formData = $("#reduceStockForm").serialize();
        $.ajax({
            url: "admin_book_stock_reduce.html",
            type: "POST",
            data: formData,
            dataType: "json",
            success: function(response) {
                if(response.success) {
                    Swal.fire({
                        title: '出库成功！',
                        icon: 'success',
                        showConfirmButton: false,
                        timer: 2000
                    });

                    setTimeout(function () {
                        window.location.href = 'admin_book_inventory.html';
                    }, 2000);

                } else {
                    Swal.fire({
                        title: '错误',
                        text: response.message || '出库失败，请重试！',
                        icon: 'error'
                    });
                }
            },
            error: function(xhr, status, error) {
                Swal.fire({
                    title: '错误',
                    text: '系统错误，请重试！',
                    icon: 'error'
                });
            }
        });
    }

    // 模态框关闭时重置表单
    $('#addStockModal, #reduceStockModal').on('hidden.bs.modal', function () {
        $(this).find('form')[0].reset();
    });
    </script>
</body>
</html> 