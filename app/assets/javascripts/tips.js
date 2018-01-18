function generateTip(){
    $.get("/tips/", function(data) {
        var tip = data[Math.floor(Math.random() * data.length )];
        tipHTML =   `
                    <span style="font-size: 18px;">${tip.title}</span>
                    <p>${tip.tip} - <a href="${tip.source_url}">${tip.source_name}</a>
                    ` 

        $(".tip").html(tipHTML);
    })
    }

    generateTip();
        
    
    $(function(){
        $(".random-tip").on("click", function(e) {
            generateTip()
            e.preventDefault();
        })
    })
  