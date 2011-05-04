// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function destroyCountdown(div, startTime) {
	document.getElementById(div).value=startTime;
	startTime = startTime-1;
	var t=setTimeOut("destroyCount(div, startTime)", 1000);
}

function startCountdown(post_id, seconds_remaining) {
    $('seconds_remaining_'+post_id).update(seconds_remaining);
	seconds_remaining = seconds_remaining - 1;
	if (seconds_remaining > 0)
		setTimeout(function() { startCountdown(post_id, seconds_remaining); }, 1000);
	else
		hideDestroyButton(post_id);
}

function hideDestroyButton(post_id) {
    Effect.BlindUp('destroy_button_'+post_id);
}