"use strict";!function(a){"function"==typeof define&&define.amd?define(["parsley"],a):a()}(function(){$(function(){var a=$("form[name=form-login]");a.on("click","button[type=submit]",function(b){var c=$(this);a.parsley().validate()?(c.prop("disabled",!0),NProgress.start(),setTimeout(function(){NProgress.done(),location.href="index.html"},500)):a.removeClass("animation animating shake").addClass("animation animating shake").one("webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend",function(){$(this).removeClass("animation animating shake")}),b.preventDefault()})})});