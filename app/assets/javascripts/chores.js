////////////////// OBJECT CREATION, PROTOTYPE, AND TEMPLATE

function Chore(chore){
    this.id = chore.id
    this.listID = chore.list.id
    this.name = formatName(chore)
    this.timeOfDay = chore.time_of_day
    this.frequency = chore.frequency
}

function formatName(chore){
    if (chore.timeOfDay === "morning"){
        return `☀ ${chore.name}`
    } else if (chore.timeOfDay === "evening"){
        return `☾ ${chore.name}`
    } else {
        return `${chore.name}`
    }
}

Chore.prototype.formatCompletedButton = function() {
    return `
            <div class="completed-item">
                <button class="chore completed" id="${this.id}">
                    ${this.name}
                </button>
            </div>

            `
}
/////////////////////////HELPER FUNCITONS

function sortChoresABC(chores, data){
    var sorted = chores.sort((a,b) => {
        if (a.name.toLowerCase() < b.name.toLowerCase()){
            return -1
        }
        if (a.name.toLowerCase() > b.name.toLowerCase()){
            return 1
        }
        return 0
    })
    $(`#${data.frequency} > li`).remove()
    sorted.forEach(function(chore){
        var choreHTML = formatEditListing(chore, data.list.id)
            $(`#${chore.frequency}`).append(choreHTML);
    })
}

function formatEditListing (chore, listID) {
  return `
            <li class="${chore.frequency}" id="<%= chore.id%>">${chore.name} <a href="#" class="delete-chore" data-id='[${chore.id}, ${listID}]'>✖</a><a href="/lists/${listID}/chores/${chore.id}">✎</a></li>

            `
} 
//////////////////////////CHORE CREATION

$(function () {
    $(".create-chore").removeAttr("data-disable-with")
        $('#new_chore').submit(function(event) {
            event.preventDefault();
            var action = $(this).attr('action')
            var values = $(this).serialize();
            var posting = $.post(action, values);      
            posting.done(function(data) {
              $.get(`/lists/${data.list.id}`, function(response){
                  //grab all chores with the same frequency as the newly created chore
                var chores = response.chores.filter(chore => chore.frequency === data.frequency)
                if (chores.length > 1) {
                    sortChoresABC(chores, data)
                } else {
                    $(`#${data.frequency}`).empty()
                    var choreHTML = formatEditListing(data, data.list.id)
                        $(`#${data.frequency}`).append(choreHTML);
                }
              }) 
            });
    });
});

//////////////////////////CHORE DELETION

$(function () {
    $(document).on('click','.delete-chore', function(event) {
        //debugger;
        var ids = $(this).data("id");
        var url = `/lists/${ids[1]}/chores/${ids[0]}`
        $.ajax ({
            method: 'DELETE',
            url: url,
            headers: {
        'X-Transaction': 'POST Example',
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        }, 
        }).done(function(data){
            if ($(`.${data.frequency}`).length === 1) {
            $(`#${data.id}`).remove();
            $(`#${data.frequency}`).html(`<br><br><center>You need to create some ${data.frequency} chores.</center><br>`)
            } else {
                $.get(`/lists/${data.list.id}`, function(response){
                    var chores = response.chores.filter(chore => chore.frequency === data.frequency)
                    sortChoresABC(chores, data)
                })
            }
        })
        event.preventDefault();
    })
})
  

////setup radio buttons
function resetradio () {
    var radio = document.getElementsByName('chore[frequency]')[0];
    var buttons = document.querySelector('.buttons');
    var radios = document.getElementsByName('chore[time_of_day]');
    radios[2].checked = true;
    if (radio.checked == true) {
        buttons.style.display = 'block';
    }
    else {
        buttons.style.display = 'none';
        radios.forEach(function(radio){
          radio.checked = false;
        })
    }
}
function setradio () {
    var radio = document.getElementsByName('chore[frequency]')[0];
    if (radio.checked == false) {
        radio.checked = true;
    }
}


//////////////////////////CHORE COMPLETION
$(function () {
    $(document).on('click', ".select-button", function(e) {
        var ids = $(this).data("id");
      var url = `/lists/${ids[1]}/chores/${ids[0]}/complete`
      $.ajax ({
          method: "GET",
          url: url
      }).done(function(data){
          if ($(".select-button").length === 1){
              $(`#${data.id}`).remove();
              $("#list-container").html("<br><br><center>Woohoo!  All done! Great work!</center><br>");
          } else {
              $(`#${data.id}`).remove();
              $("#list-container").load(location.href+" #list-container>*","");
          }
            var chore = new Chore(data)
            var choreHTML = chore.formatCompletedButton()
            $(".completed-items").append(choreHTML);
            $("#completed-list-container").load(location.href+" #completed-list-container>*","");

      })
      e.preventDefault
    });
    $('.completed-chores').hide();
    $(document).on('click','.show-completed', function(e){
      e.preventDefault();
      $(this).next('.completed-chores').toggle();
  });


});
