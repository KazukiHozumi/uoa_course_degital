$(function() {
    selectedCoueses = []

    $('#confirm').on('click', function(){
        const query = document.location.search.substring(1);

        let result = getParameterValues(query);
        window.location.href=`detail?studentId=${result[0]}&name=${result[1]}`+
            `&selectedCourses=${selectedCoueses.join(',')}`
    });

    $('.checkbox').on('click', function(){
        if (this.checked) {
            selectedCoueses.push(this.nextElementSibling.value.replace('>', ''))
        }
    });

    function getParameterValues(query){
        let parameters = query.split('&');
        let result = [];
        for (let i = 0; i < parameters.length; i++) {

            // パラメータ名とパラメータ値に分割する
            let element = parameters[i].split('=');

            let paramValue = decodeURIComponent(element[1]);
            result[i] = paramValue
        }
        return result;
    }
});
