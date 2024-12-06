
window.addEventListener('message', function(event) {
    if (event.data.type == "showUi") {
						
		data = event.data.data
        lvlstrength = event.data.lvlstrength
        lvlrun = event.data.lvlrun
        lvlswim = event.data.lvlswim
        lvlcardio = event.data.lvlcardio

		$("body").css("display","flex")
		
        loaddatas()
    }

    if (event.data.type == "majDatas") {
						
		data = event.data.data
		
        loaddatas()
    }

	if (event.data.type == "hideUi") {
		
		hideUi()
    }
})

function loaddatas(){
    // ---------------------------
    // strength
    // ---------------------------
    if (data.strength >= 0) {
        if (data.strength <= lvlstrength.lvl1) {
            htmlLabel = `Lvl 1`
            widthvalue = ((data.strength / lvlstrength.lvl1) * 100)
        } else {
            if (data.strength <= lvlstrength.lvl2) {
                htmlLabel = `Lvl 2`
                widthvalue = (((data.strength - lvlstrength.lvl1)  / (lvlstrength.lvl2 - lvlstrength.lvl1)) * 100)
            } else {
                if (data.strength <= lvlstrength.lvl3) {
                    htmlLabel = `Lvl 3`
                    widthvalue = (((data.strength - lvlstrength.lvl2)  / (lvlstrength.lvl3 - lvlstrength.lvl2)) * 100)
                } else {
                    if (data.strength <= lvlstrength.lvl4) {
                        htmlLabel = `Lvl 4`
                        widthvalue = (((data.strength - lvlstrength.lvl3)  / (lvlstrength.lvl4 - lvlstrength.lvl3)) * 100)
                    } else {
                        if (data.strength <= lvlstrength.lvl5) {
                            htmlLabel = `Lvl 5`
                            widthvalue = (((data.strength - lvlstrength.lvl4)  / (lvlstrength.lvl5 - lvlstrength.lvl4)) * 100)
                        }
                    }
                }
            }
        } 
        $("body .content .boxstrength .valuebox .lvl").html(htmlLabel)
        $("body .content .boxstrength .valuebox .barre .inbarre").css("width",widthvalue+"%")
    }

    // ---------------------------
    // run
    // ---------------------------
    if (data.run >= 0) {
        if (data.run <= lvlrun.lvl1) {
            htmlLabel = `Lvl 1`
            widthvalue = ((data.run / lvlrun.lvl1) * 100)
        } else {
            if (data.run <= lvlrun.lvl2) {
                htmlLabel = `Lvl 2`
                widthvalue = (((data.run - lvlrun.lvl1)  / (lvlrun.lvl2 - lvlrun.lvl1)) * 100)
            } else {
                if (data.run <= lvlrun.lvl3) {
                    htmlLabel = `Lvl 3`
                    widthvalue = (((data.run - lvlrun.lvl2)  / (lvlrun.lvl3 - lvlrun.lvl2)) * 100)
                } else {
                    if (data.run <= lvlrun.lvl4) {
                        htmlLabel = `Lvl 4`
                        widthvalue = (((data.run - lvlrun.lvl3)  / (lvlrun.lvl4 - lvlrun.lvl3)) * 100)
                    } else {
                        if (data.run <= lvlrun.lvl5) {
                            htmlLabel = `Lvl 5`
                            widthvalue = (((data.run - lvlrun.lvl4)  / (lvlrun.lvl5 - lvlrun.lvl4)) * 100)
                        }
                    }
                }
            }
        } 
        $("body .content .boxrun .valuebox .lvl").html(htmlLabel)
        $("body .content .boxrun .valuebox .barre .inbarre").css("width",widthvalue+"%")
    }

    // ---------------------------
    // swim
    // ---------------------------
    if (data.swim >= 0) {
        if (data.swim <= lvlswim.lvl1) {
            htmlLabel = `Lvl 1`
            widthvalue = ((data.swim / lvlswim.lvl1) * 100)
        } else {
            if (data.swim <= lvlswim.lvl2) {
                htmlLabel = `Lvl 2`
                widthvalue = (((data.swim - lvlswim.lvl1)  / (lvlswim.lvl2 - lvlswim.lvl1)) * 100)
            } else {
                if (data.swim <= lvlswim.lvl3) {
                    htmlLabel = `Lvl 3`
                    widthvalue = (((data.swim - lvlswim.lvl2)  / (lvlswim.lvl3 - lvlswim.lvl2)) * 100)
                } else {
                    if (data.swim <= lvlswim.lvl4) {
                        htmlLabel = `Lvl 4`
                        widthvalue = (((data.swim - lvlswim.lvl3)  / (lvlswim.lvl4 - lvlswim.lvl3)) * 100)
                    } else {
                        if (data.swim <= lvlswim.lvl5) {
                            htmlLabel = `Lvl 5`
                            widthvalue = (((data.swim - lvlswim.lvl4)  / (lvlswim.lvl5 - lvlswim.lvl4)) * 100)
                        }
                    }
                }
            }
        } 
        $("body .content .boxswim .valuebox .lvl").html(htmlLabel)
        $("body .content .boxswim .valuebox .barre .inbarre").css("width",widthvalue+"%")
    }

    // ---------------------------
    // cardio
    // ---------------------------
    if (data.cardio >= 0) {
        if (data.cardio <= lvlcardio.lvl1) {
            htmlLabel = `Lvl 1`
            widthvalue = ((data.cardio / lvlcardio.lvl1) * 100)
        } else {
            if (data.cardio <= lvlcardio.lvl2) {
                htmlLabel = `Lvl 2`
                widthvalue = (((data.cardio - lvlswim.lvl1)  / (lvlswim.lvl2 - lvlswim.lvl1)) * 100)
            } else {
                if (data.cardio <= lvlcardio.lvl3) {
                    htmlLabel = `Lvl 3`
                    widthvalue = (((data.cardio - lvlswim.lvl2)  / (lvlswim.lvl3 - lvlswim.lvl2)) * 100)
                } else {
                    if (data.cardio <= lvlcardio.lvl4) {
                        htmlLabel = `Lvl 4`
                        widthvalue = (((data.cardio - lvlswim.lvl3)  / (lvlswim.lvl4 - lvlswim.lvl3)) * 100)
                    } else {
                        if (data.cardio <= lvlcardio.lvl5) {
                            htmlLabel = `Lvl 5`
                            widthvalue = (((data.cardio - lvlswim.lvl4)  / (lvlswim.lvl5 - lvlswim.lvl4)) * 100)
                        }
                    }
                }
            }
        } 
        $("body .content .boxcardio .valuebox .lvl").html(htmlLabel)
        $("body .content .boxcardio .valuebox .barre .inbarre").css("width",widthvalue+"%")
    }
}


// functions base

function hideUi() {    
    $("body").css("display", "none")
}