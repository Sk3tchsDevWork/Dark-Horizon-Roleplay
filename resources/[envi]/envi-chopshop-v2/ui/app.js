$(function() {
    displayUI(false);

    let $element = $('.contract__wrapper');

    window.addEventListener("message", function(e) {
        if (e.data.type === "ui") {
            if (e.data.status) {
                displayUI(true);
                $("#contract-location").html(e.data.shop);
                $(".vehicle__required").html(e.data.vehicle);
                $(".contract__signature--symbol, .contract__signature--name").html(e.data.shopOwner);
                updateTime();
            }
        } else {
            displayUI(false);
        };
    });

    $('.contract__wrapper').on('animationend', function() {
        $(this).removeClass("animate__fadeInDown");
        VanillaTilt.init($element[0], {
            max: 20,
            speed: 400
        });
    });
    

    $(window).on('wheel', function(event) {
        var delta = event.originalEvent.deltaY;
        var scale = $element.data('scale') || 1;
        var scaleFactor = 0.1;

        if (delta > 0) {
            scale -= scaleFactor;
        } else {
            scale += scaleFactor;
        }

        scale = Math.max(1, Math.min(scale, 2));
        $element.css('transform', 'scale(' + scale + ')');
        $element.data('scale', scale);

        if (scale !== 1 && $element[0].vanillaTilt) {
            $element[0].vanillaTilt.destroy();
        } else if (scale === 1 && !$element[0].vanillaTilt) {
            VanillaTilt.init($element[0], {
                max: 20,
                speed: 400
            });
        }
    });

    // Get Your Time Zone: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
    function updateTime() {
        let time = new Date( (new Date()).toLocaleString('en-US',{timeZone : "Europe/London"}));

        $("#contract-date").html(`${time.getDate().toString().padStart(2, "0")}.${(time.getMonth() + 1).toString().padStart(2, "0")}.${time.getFullYear().toString().substring(0,4)}`)

        setTimeout(updateTime, 10000);
    };

    function displayUI(bool) {
        if (bool) {
            $('body').fadeIn("100").find(".contract__wrapper").removeClass("animate__fadeOutUp").addClass("animate__fadeInDown");
        } else {
            $('.contract__wrapper').addClass("animate__fadeOutUp");
            setTimeout(() => {
                $("body").fadeOut("100");
            }, 500);
        }
    };

    $(document).on("keyup", function(e) {
		if (e.which == 27) {
            displayUI(false);
            $.post(`https://${GetParentResourceName()}/closeUI`, JSON.stringify({}));
		};
	});
    
});