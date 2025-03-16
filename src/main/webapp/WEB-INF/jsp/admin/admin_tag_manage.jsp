<!-- 修改form标签，添加id属性 -->
<form id="addTagForm" method="post">
    <div class="form-group">
        <label>标签名称</label>
        <input type="text" class="form-control" name="name" required>
    </div>
    <div class="form-group">
        <label>状态</label>
        <select class="form-control" name="status">
            <option value="0">正常</option>
            <option value="1">停用</option>
        </select>
    </div>
</form>

<!-- 修改JavaScript代码 -->
<script>
function submitAddTag() {
    var formData = $("#addTagForm").serialize();
    
    $.ajax({
        url: "admin_tag_add.html",
        type: "POST",
        data: formData,
        success: function(response) {
            if(response.success) {
                alert("添加成功！");
                $('#addTagModal').modal('hide');
                // 刷新页面
                window.location.reload();
            } else {
                alert("添加失败，请重试！");
            }
        },
        error: function() {
            alert("系统错误，请重试！");
        }
    });
}

// 添加模态框关闭后清空表单
$('#addTagModal').on('hidden.bs.modal', function () {
    $('#addTagForm')[0].reset();
});
</script> 