$(document).ready(function () {
    // Hide/show UI function
    function display(bool) {
        if (bool) {
            $("#overlay").show();
        } else {
            $("#overlay").hide();
        }
    }

    display(false);

    window.addEventListener("message", function (event) {
        // Open UI based on message
        var item = event.data;
        if (item.type === "open") {
            display(item.status);
        }
    });

    // Click handlers for animations

    // Listener pour les nouvelles animations
    $("#DefaultAim").click(function () {
        $.post('https://kay_weapon-animation/1', JSON.stringify({}));
        return;
    });
    
    $("#GangsterAim").click(function () {
        $.post('https://kay_weapon-animation/2', JSON.stringify({}));
        return;
    });
    
    $("#HillBillyAim").click(function () {
        $.post('https://kay_weapon-animation/3', JSON.stringify({}));
        return;
    });

    $("#DefaultHolster").click(function () {
        $.post("https://kay_weapon-animation/4", JSON.stringify({}));
    });

    $("#BackHolster").click(function () {
        $.post("https://kay_weapon-animation/5", JSON.stringify({}));
    });

    $("#CopHolster").click(function () {
        $.post("https://kay_weapon-animation/6", JSON.stringify({}));
    });

    $("#FrontHolster").click(function () {
        $.post("https://kay_weapon-animation/7", JSON.stringify({}));
    });

    $("#FrontAgressiveHolster").click(function () {
        $.post("https://kay_weapon-animation/8", JSON.stringify({}));
    });

    $("#LegHolster").click(function () {
        $.post("https://kay_weapon-animation/9", JSON.stringify({}));
    });

    // Listener pour les animations radio
    $("#RadioDefault").click(function () {
        $.post('https://kay_weapon-animation/10', JSON.stringify({}));
        return;
    });
    
    $("#RadioPolice").click(function () {
        $.post('https://kay_weapon-animation/11', JSON.stringify({}));
        return;
    });

    $("#RadioBras").click(function () {
        $.post('https://kay_weapon-animation/12', JSON.stringify({}));
        return;
    });


    // Close UI when ESC is pressed
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post("https://kay_weapon-animation/close", JSON.stringify({}));
        }
    };
});
