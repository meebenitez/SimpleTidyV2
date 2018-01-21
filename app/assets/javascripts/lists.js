$(function () {
    $("#change-name").click(function(){
        $('.edit_list').submit(function(event) {
            event.preventDefault();
            var action = $(this).attr('action')
            var values = $(this).serialize();
            $.ajax({
                type: "Post",
                url: action,
                data: values
            }).done(function(data){
                var listHTML = 
                                `
                                <a href="/lists/${data.id}" class="listname_home">${data.name}</a>
                                `
                $(`#list-name`).html(listHTML)
            })
    
        })
    })
});