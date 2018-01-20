//////////////////////////CHORE COMPLETION
$(function () {
    $(document).on('click', ".select-button", function(e) {
        var ids = $(this).data("id");
      var url = `/lists/${ids[1]}/chores/${ids[0]}/complete`
      $.ajax ({
          method: "GET",
          url: url,
          chore_id: ids[0],
          list_id: ids[1]
      }).done(function(){
          if ($(".select-button").length === 1){
              $(`#${this.chore_id}`).remove();
              $("#list-container").html("<br><br><center>Woohoo!  All done! Great work!</center><br>");
          } else {
              $(`#${this.chore_id}`).remove();
              $("#list-container").load(location.href+" #list-container>*","");
          }
          $.get("/lists/" + this.list_id + "/chores/" + this.chore_id + ".json", function(data) {
              let completedChore = new CompletedChore(data)
              let completedChoreHTML = completedChore.formatButton()
              $(".completed-items").append(completedChoreHTML);
          })

      })
      e.preventDefault
    });
    $('.completed-chores').hide();
    $(document).on('click','.show-completed', function(e){
      e.preventDefault();
      $(this).next('.completed-chores').toggle();
  });


  });

  function CompletedChore(chore){
      this.id = chore.id
      this.name = formatName(chore)
      this.time_of_day = chore.time_of_day
      this.frequency = chore.frequency
  }

  function formatName(chore){
      if (chore.time_of_day === "morning"){
          return `☀ ${chore.name}`
      } else if (chore.time_of_day === "evening"){
          return `☾ ${chore.name}`
      } else {
          return `${chore.name}`
      }
  }

  CompletedChore.prototype.formatButton = function() {
      return `
              <div class="completed-item">
                  <button class="chore completed" id="${this.id}">
                      ${this.name}
                  </button>
              </div>

              `
  }
//////////////////////////CHORE CREATION


$(function () {
    $(".create-chore").click(function(){
        $('#new_chore').submit(function(event) {
            event.preventDefault();
            var action = $(this).attr('action')
            var values = $(this).serialize();
            var posting = $.post(action, values);
            posting.done(function(data) {
              let newChore = new NewChore(data)
              let newChoreHTML = newChore.formatCell()
              if (data.frequency === "daily") {
                $("#daily").append(newChoreHTML);
              } else if (data.frequency === "weekly") {
                $("#weekly").append(newChoreHTML);
              } else {
                $("#monthly").append(newChoreHTML);
              }
            });
    })
  
});

  function NewChore(chore){
          this.id = chore.id
          this.list_id = chore.list.id
          this.name = formatName(chore)
          this.time_of_day = chore.time_of_day
          this.frequency = chore.frequency
      }

      function formatName(chore){
          if (chore.time_of_day === "morning"){
              return `☀ ${chore.name}`
          } else if (chore.time_of_day === "evening"){
              return `☾ ${chore.name}`
          } else {
              return `${chore.name}`
          }
      }

      NewChore.prototype.formatCell = function() {
          //debugger;  
        return `
                  <div class="item ${this.frequency}">
                      <center>${this.name} <br><a href="#" class="delete-chore" data-id='[${this.id}, ${this.list_id}]'>✖</a><a href="/lists/${this.list_id}/chores/${this.id}">✎</a> </center>
                  </div>
  
                  `
      }
});

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


//////////////////////////CHORE DELETION

$(function () {
    $(document).on('click','.delete-chore', function(event) {
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
            //$(`#${data.id}`).remove(); // don't need this if I'm reloading the divs
            $(`#${data.frequency}`).load(location.href+` #${data.frequency}>*`,"");
            }
        })
        event.preventDefault();
    })
})