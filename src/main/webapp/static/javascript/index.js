/**
 * 
 */
    function setQuantity(event, form) {
        event.preventDefault(); // 取消表单的默认提交行为
        var quantityInput = form.querySelector('.number');
        var quantityValue = quantityInput.value;
        form.querySelector('input[name="quantityValue"]').value = quantityValue; // 设置隐藏字段的值
        form.submit(); // 手动提交表单
    }

    function addToCart(event, button) {
        event.preventDefault(); // 取消表单的默认提交行为
        var form = button.closest('form');
        var quantityInput = form.querySelector('.number');
        var quantityValue = quantityInput.value;
        form.querySelector('input[name="quantityValue"]').value = quantityValue; // 设置隐藏字段的值
        form.submit(); // 手动提交表单
    }
