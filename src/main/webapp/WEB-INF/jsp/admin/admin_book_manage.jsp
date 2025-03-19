            success: function(response) {
                if (response.status === 'success') {
                    alert(response.message);
                    // 如果有重定向URL，则进行重定向
                    if (response.redirectUrl) {
                        window.location.href = response.redirectUrl;
                    } else {
                        // 如果没有重定向URL，则刷新当前页面
                        window.location.reload();
                    }
                } else {
                    alert(response.message || '添加失败');
                }
            }, 