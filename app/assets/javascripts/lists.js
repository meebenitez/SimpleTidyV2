$(function () {
    $("#change-name").removeAttr("data-disable-with")
    $("#edit-members").removeAttr("data-disable-with")
    //$("#change-name").click(function(){
        $('.edit_list').submit(function(event) {
            event.preventDefault();
            var action = $(this).attr('action')
            var values = $(this).serialize();
       
            $.ajax({
                type: "PUT",
                url: action,
                data: values
            }).done(function(data){
         
                var listHTML = 
                                `
                                <a href="/lists/${data.id}">${data.name}</a>
                                `
                $(`#list-name`).html(listHTML)
            })
    
        })
    //})
});