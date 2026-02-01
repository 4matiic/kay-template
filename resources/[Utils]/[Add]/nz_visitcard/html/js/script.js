var vanilla = false

$(function () {
	$("body").css('display', 'none');

	window.addEventListener('message', function (event) {
		if (event?.data == undefined || event?.data.length == 0 || event?.data == {} || event?.data == null) { return; }
		let data = event.data;
		if (data?.action == 'open') {
			$('.card').css({
				width: (data?.width ? data?.width : 20) + "%",
				height: (data?.height ? data?.height : 50) + "%"
			});

			$('.bgImg').css({
				'background': `url("${data?.image  ? data?.image : 'https://cdn.discordapp.com/attachments/920831965991677963/941007095443111948/missingfile.png'}") center/cover no-repeat`
			});
			$('#name').text(data?.name ? data?.name : '');
			$('#description').text(data?.description ? data?.description : '');
			$('#number').text(data?.number ? data?.number : '');

			$("body").css('display', 'flex');

			if(data?.blur) {
				$('.bgImg').addClass('bgText')
			} else {
				$('.bgImg').removeClass('bgText')
			}

			if(data?.number && data?.number.length > 0) {
				$('#number').addClass('numberFormat')
			} else {
				$('#number').removeClass('numberFormat')
			}

			if(data?.tilt && !vanilla) {
				vanilla = true
				VanillaTilt.init(document.querySelectorAll(".card"), {
					max: 15,
					transition: true,
					speed: 800,
					glare: true,
					"max-glare": 0.20
				});
			} else if(!data?.tilt && vanilla) {
				document.querySelectorAll(".card").vanillaTilt.destroy();

			}
		} else if (data?.action == 'close') {
			$("body").css('display', 'none');
		}
	});
});

$(document).on('keydown', function() {
    switch(event.keyCode) {
    case 8:
    case 27:
      $.post(`https://nz_visitcard/close`);
      break;
  }
});
