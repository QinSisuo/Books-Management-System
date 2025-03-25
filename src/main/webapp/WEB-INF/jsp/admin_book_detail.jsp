                    <div class="form-group">
                        <label>图书分类：</label>
                        <span>${book.categoryName}</span>
                    </div>
                    <div class="form-group">
                        <label>图书标签：</label>
                        <div class="tag-group">
                            <c:forEach items="${tags}" var="tag">
                                <span class="tag">${tag.name}</span>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>图书简介：</label>
                        <span>${book.description}</span>
                    </div>

<style>
.tag-group {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
    margin-top: 5px;
}

.tag {
    background-color: #e9ecef;
    color: #495057;
    padding: 4px 8px;
    border-radius: 4px;
    font-size: 14px;
    display: inline-block;
}
</style> 