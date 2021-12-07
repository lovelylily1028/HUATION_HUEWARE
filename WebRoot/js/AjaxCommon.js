var AJAX = {
     XmlHttp: null,
     create: function () {
           try {
                if (window.XMLHttpRequest) {
                     AJAX.XmlHttp = new XMLHttpRequest();
                     if (this.XmlHttp.readyState == null) {
                           this.XmlHttp.readyState = 1;
                           this.XmlHttp.addEventListener("load", function () {
                                this.XmlHttp.readyState = 4;
                                if (typeof this.XmlHttp.onreadystatechange == "function")
                                     XmlHtp.onreadystatechange();
                           }, false);
                     }
                } else {
                    try {
						AJAX.XmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
					} catch (e) {
						try {
							AJAX.XmlHttp =  new ActiveXObject("Microsoft.XMLHTTP");
						} catch (e1) {               
							AJAX.XmlHttp =  null;
						}
					}
                }
           }
           catch (e) {
                alert("not support XmlHttp objects");
           }
     }
}

AJAX.openXML = function (method, url, async) {
     if (AJAX.XmlHttp != null) {
           AJAX.XmlHttp.open(method, url, async);

           AJAX.XmlHttp.onreadystatechange = function () {
                if (AJAX.XmlHttp.readyState == 4) {
                     if (AJAX.XmlHttp.status == 200) { // 200 은 HTTP에서 성공
                           AJAX.statusSuccessHandler(AJAX.XmlHttp.responseXML);
                     } else {
                           AJAX.statusErrorHandler();
                           alert('Error while loading!');
                     }
                }
           }
     } else {
           alert ("need to create xmlhttp object");
     }
}

AJAX.openText = function (method, url, async) {
     if (AJAX.XmlHttp != null) {
		   AJAX.XmlHttp.open(method, url, async);

           AJAX.XmlHttp.onreadystatechange = function () {
                if (AJAX.XmlHttp.readyState == 4) {
                     if (AJAX.XmlHttp.status == 200) { // 200 은 HTTP에서 성공 i.e) 404 : not found
                           AJAX.statusSuccessHandler(AJAX.XmlHttp.responseText);
                     } else {
                           AJAX.statusErrorHandler();
                           alert('Error while loading!');
                     }
                }
           }
     } else {
           alert ("need to create xmlhttp object");
     }
}

AJAX.send = function (content) {
   if (content == undefined)
		AJAX.XmlHttp.send(null);
   else
		AJAX.XmlHttp.send(content);
}

AJAX.setOnReadyStateChange = function (funcname) {
   if (AJAX.XmlHttp) {
		AJAX.XmlHttp.onreadystatechange = funcname;
   } else {
		alert ("need to create xmlhttp object");
   }
}

AJAX.statusSuccessHandler = function (data) {
           alert(data);
}

AJAX.setStatusSuccessHandler = function (funcname) {
           AJAX.statusSuccessHandler = funcname;
}

AJAX.setRequestHeader = function (label, value)
{
     AJAX.XmlHttp.setRequestHeader(label, value);
}


function formData2QueryString(docForm) {

	var strSubmit       = '';
	var formElem;
	var strLastElemName = '';
	
	for (i = 0; i < docForm.elements.length; i++) {
		formElem = docForm.elements[i];
		switch (formElem.type) {
			// Text, select, hidden, password, textarea elements
			case 'text':
			case 'select-one':
			case 'hidden':
			case 'password':
			case 'textarea':
				strSubmit += formElem.name + 
				'=' + escape(formElem.value) + '&'
			break;
		}
	}
}

// 사용법
//     AJAX.create();
//     AJAX.openText('GET','jsontest.php', true);
//     AJAX.setStatusSuccessHandler(proc);
//     AJAX.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
//     AJAX.send("test=테스트");
//
//     function proc(abc)
//     {
//           document.getElementById('test').innerHTML = abc;
//     } 