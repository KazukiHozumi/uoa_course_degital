$(function() {
    $('#login').on('click', function () {
        let studentId = $('#studentId').val();
        let name = $('#name').val();

        window.location.href=`list?studentId=${studentId}&name=${name}`
    });
});