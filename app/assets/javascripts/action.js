$(function() {
    $('#login').on('click', function () {
        let studentId = $('#studentId').val();
        let name = $('#name').val();

        window.location.href=`list?studentId=${studentId}&name=${name}`
    });

    $('#confirm').on('click', function(){
        const query = document.location.search.substring(1);
        let parameters = query.split('&');

        let result = [];
        for (let i = 0; i < parameters.length; i++) {
            // パラメータ名とパラメータ値に分割する
            let element = parameters[i].split('=');

            let paramValue = decodeURIComponent(element[1]);

            result[i] = paramValue
        }

        selectedCoueses = []
        $('ul.list-group').children.each(function(index, ele){
            if ($(ele).find('input.checkbox')[0].checked){
                selectedCoueses.push($(ele).find('.courseTeacherId').val());
            }
        });
        window.location.href=`detail?studentId=${result[0]}&name=${result[1]}`+
            `&selectedCourses[]=${selectedCoueses}`
    });
});