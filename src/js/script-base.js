let ajaxJT = function (url, data, succCallback, failCallBack) {
	if(typeof url === 'undefined') {
		return;
	}

	$.ajax({
		type: 'POST',
		contentType: "application/json",
		url: url,
		dataType: 'text',
		data: JSON.stringify(data),
		success: function (ret) {
			succCallback(ret);
		},
		error: function (err) {
			failCallBack(err.text());
		}
	});
};

let ajaxJJ = function (url, data, succCallback, failCallBack) {
	if(typeof url === 'undefined') {
		return;
	}

	$.ajax({
		type: 'POST',
		contentType: "application/json",
		url:url,
		dataType: 'json',
		data: JSON.stringify(data),
		success: function (result) {
			succCallback(result);
		},
		error: function (err) {
			failCallBack();
		}
	});
};

// 동기식 Ajax 사용
$.ajaxSync = function(url, reqData){
	if(typeof url === 'undefined') {
		return;
	}

	var result = {};

	$.ajax({
		url: url,
		type: 'post',
		contentType: "application/json; charset=UTF-8",
		dataType: 'json',
		data: JSON.stringify(reqData),
		async: false,
		success: function (data) {
			result = data;
		}
	});

	alert('result = ' + JSON.stringify(result));
	return result;
};

// 비동기식 Ajax 사용
$.ajaxASync = function(url, reqData, succCallback){
	if(typeof data === 'undefined') {
		return;
	}

	$.ajax({
		url: url,
		type: 'post',
		contentType: "application/json; charset=UTF-8",
		dataType: 'json',
		data: JSON.stringify(reqData),
		// async: false,            // 기본값은 true 임
		success: function (data) {
			succCallback(data);
		}
	});

};

// 디버그 로그
let log = console.log;

window.addEventListener('DOMContentLoaded', function (){

});