// run once the HTML has finished loading
window.onload = function(){
    // select the file input element
	var upload = document.getElementById("fileSelect");
	var responseMsg = document.getElementsByClassName("responseMsg")[0];
	var errorMsg = document.getElementById("errorMsg");
	var uploadMsg = document.getElementById("uploadtext");
    // ensure that there are no files already waiting to be uploaded
	upload.value="";
    // listen for files to be selected
	upload.addEventListener("change",function(event){
        // get a handle on the file that is meant to be uploaded
		var file = this.files[0];
		responseMsg.style = "display:none;";
        // check if the file is a PNG using MIME data to continue
		if (file.type != "image/png"){
			upload.value = "";
			uploadMsg.style = "display:none;";
			error();
		} else{
			uploadMsg.innerHTML = "Chosen File: " + upload.value.split(/(\\|\/)/g).pop();
			responseMsg.style="display:none;";
			errorMsg.style="display:none;";
			success();
		}
	});
};
