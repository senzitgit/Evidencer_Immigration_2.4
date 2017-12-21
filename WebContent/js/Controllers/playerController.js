
var video1 ='';


		function getSittings(index){
			
			var advancedSearch = sessionStorage.getItem("advancedSearch");
			 obj = JSON.parse(advancedSearch);
			 var cur = obj.response.AdvancedResult.CaseList[index];
	   		
			
			
			var caseNoSimple = cur.caseNo;
			sessionStorage.setItem("caseNoSimple", caseNoSimple);
			
			$.ajax({
		      	url: webServerUrl,
		      	data: 'request=simpleSearch&caseNo='+caseNoSimple,
		      	type: 'post',
					success: function(msg){
						
					
				var ServerResp = msg.trim();
					
		   		 obj = JSON.parse(ServerResp);
		   		 var resultCode  = obj.response.resultcode;
		   		 var message  = obj.response.message;
		   		 

		   		if(resultCode== 1)
					{	
		   			   var arrayLength  = obj.response.SittingList.length;
		   			   var caseProgress = document.getElementById("caseProgress");
		   			   caseProgress.innerHTML ='<i>Search Details for </i><b>'+caseNoSimple+'</b><br><br>';
		   			   var dynamicFileld = document.getElementById("dynamicFileld");
		   			   var searchHeader = document.getElementById("searchHeader");
		   			   searchHeader.innerHTML = '<a href="#" class="font-bold">Search Cases</a><span class="label bg-danger pull-right m-t-xs" Style="background-color: #a00a0a;"><a href="video_on_demand.html"><b> <div class="fa fa-search"></div>&nbsp;&nbsp;Search Again </b></a></span>';
		   			   dynamicFileld.innerHTML = '';
		   			   if(arrayLength>0) {
				   		
					   	 for (var i = 0; i < arrayLength; i++) {
				   		       var cur = obj.response.SittingList[i];
				   		       console.log(cur);
				   		       dynamicFileld.innerHTML=  dynamicFileld.innerHTML +'<p><a href="#" onclick="getSessions('+cur+')" class="btn btn-default btn-block"><i class="fa fa-bars pull-left"></i> &nbsp;&nbsp;Sitting '+cur+' </a></p>';    
				   		    
				   		    }
				}else {
				}
		   			   
		   			   
					}
			
					else
					{
						 var dynamicFileld = document.getElementById("dynamicFileld");
			   		     dynamicFileld.innerHTML= '<center><br><br><br><div style="font-size:30px;color:#c6aa5d" class="fa fa-warning"></div><br><P style="color:#c6aa5d">'+message+' Try Again!!!</P><br><br><br><center>';    

					}
				}
			
			});
			
			
		}





		function popAttachment(index){
    	
    	     
    	     var ServerResp = sessionStorage.getItem("loadAttachment");
    	     obj = JSON.parse(ServerResp);
	   		 var cur = obj.response.AttachmentList[index];
	   		 
    	
    	
    	 $.fancybox([
    	             {href:cur.fileLink},
    	             
    	             ],{
    	             //			href: this.href,
    	             			helpers: {
    	             				overlay: {
    	             				opacity: 0.3
    	             				} // overlay
    	             				//, buttons: {}
    	             			} // helpers
    	             		}); // fancybox
    	
    	
    }

    function getSessions(sittingNumber){
		
    
		var sittingNumberSimple = sittingNumber;
		sessionStorage.setItem("sittingNumberSimple", sittingNumberSimple);
		var caseNo = sessionStorage.getItem("caseNoSimple");
		
		$.ajax({
	      	url: webServerUrl,
	      	data: 'request=sessionSearch&sittingNo='+sittingNumberSimple+'&caseNo='+caseNo,
	      	type: 'post',
				success: function(msg){
					
				
			var ServerResp = msg.trim();
				
	   		 obj = JSON.parse(ServerResp);
	   		 var resultCode  = obj.response.resultcode;
	   		 var message  = obj.response.message;
	   		 

	   		if(resultCode== 1)
				{	
	   			   
	   			   var caseProgress = document.getElementById("caseProgress");
	   			   caseProgress.innerHTML ='<i>Search Details for </i><b>'+caseNo+' >> Sitting '+sittingNumberSimple+' </b><br><br>';
	   			   var arrayLength  = obj.response.SessionList.length;
	   			   var dynamicFileld = document.getElementById("dynamicFileld");
	   			   var searchHeader = document.getElementById("searchHeader");
	   			   searchHeader.innerHTML = '<a href="#" class="font-bold">Search Cases</a><span class="label bg-danger pull-right m-t-xs" Style="background-color: #a00a0a;"><a href="video_on_demand.html"><b> <div class="fa fa-search"></div>&nbsp;&nbsp;Search Again </b></a></span>';
	   			   dynamicFileld.innerHTML = '';
	   			   if(arrayLength>0) {
			   		
				   	 for (var i = 0; i < arrayLength; i++) {
			   		       var cur = obj.response.SessionList[i];
			   		       console.log(cur);
			   		       dynamicFileld.innerHTML=  dynamicFileld.innerHTML +'<p><a href="#" onclick="getPlayerInfo('+cur+')" class="btn btn-default btn-block"><i class="fa fa-bars pull-left"></i> &nbsp;&nbsp;Session '+cur+' </a></p>';    
			   		    
			   		    }
			}else {
			}
	   			   
	   			   
				}
		
				else
				{
					 var dynamicFileld = document.getElementById("dynamicFileld");
		   		       dynamicFileld.innerHTML= '<center><br><br><br><div style="font-size:30px;color:#c6aa5d" class="fa fa-warning"></div><br><P style="color:#c6aa5d">'+message+' Try Again!!!</P><br><br><br><center>';    

				}
			}
		
		});
		
		return false;
		
   }	
	




    function getPlayerInfo(sessionNumber){
		
		var sessionNumberSimple = sessionNumber;
		sessionStorage.setItem("sessionNumberSimple", sessionNumberSimple);
		var caseNo = sessionStorage.getItem("caseNoSimple");
		var sittingNo = sessionStorage.getItem("sittingNumberSimple");
		
		$.ajax({
	      	url: webServerUrl,
	      	data: 'request=getPlayerInfo&sittingNo='+sittingNo+'&caseNo='+caseNo+'&sessionNo='+sessionNumberSimple,
	      	type: 'post',
				success: function(msg){
					
				console.log(msg)
					
					
					
			var ServerResp = msg.trim();
				
	   		 obj = JSON.parse(ServerResp);
	   		 var resultCode  = obj.response.resultcode;
	   		 var message  = obj.response.message;
	   		 

	   		if(resultCode== 1)
				{
	   			
	   			var caseNo = sessionStorage.getItem("caseNoSimple");
				var sittingNo = sessionStorage.getItem("sittingNumberSimple");
				var sessionNo = sessionNumberSimple;
	   			var caseTitle = obj.response.PlayerInfoResult.caseDetails.caseTitle;
	   			var caseDesc = obj.response.PlayerInfoResult.caseDetails.caseDesc;
	   			var attachmentFlag = obj.response.PlayerInfoResult.caseDetails.attachmentFlag;
	   			var privateNoteFlag = obj.response.PlayerInfoResult.caseDetails.privateNoteFlag;
	   			var eventDate = obj.response.PlayerInfoResult.caseDetails.eventDate;
	   			caseEventId = obj.response.PlayerInfoResult.caseDetails.caseEventId;
	   		  sentimentalAnalyze = obj.response.PlayerInfoResult.caseDetails.sentimentalAnalyze;
              toneAnalyze = obj.response.PlayerInfoResult.caseDetails.toneAnalyze;
              var endTime = obj.response.PlayerInfoResult.caseDetails.endTime;
              
	   			

	   		 document.getElementById('reportGenSenti').innerHTML= "Report generated at "+endTime;
             document.getElementById('reportGenTone').innerHTML= "Report generated at "+endTime;
	   			
	   			
	   			
	   		 
	             var thisCaseDetails = document.getElementById("thisCaseDetails");
	             thisCaseDetails.innerHTML = 'Case Number : <span class="badge bg-success" style="background-color:#000">' + caseNo + '</span> | Case Title :  <span class="badge bg-success" style="background-color:#000">' + caseTitle + '</span> Sitting Number: <span class="badge bg-success" style="background-color:#000">' + sittingNo + '</span> | Session Number: <span class="badge bg-success" style="background-color:#000">' + sessionNo + '</span> | Event Date : <span class="badge bg-success" style="background-color:#000">' + eventDate + '</span>';

	   			
	   			
	   			
	   			logNotes = obj.response.PlayerInfoResult.caseDetails.logNotes;
	   			
	   			
	   			
	   			sessionStorage.setItem("logNotes", logNotes);
	   			
	   			sessionStorage.setItem("pcaseNo", caseNo);
	   			sessionStorage.setItem("pcaseTitle", caseTitle);
	   			sessionStorage.setItem("pcaseDesc", caseDesc);
	   			sessionStorage.setItem("psittingNo", sittingNo);
	   			sessionStorage.setItem("psessionNo", sessionNo);
	   			
	   			logs = JSON.parse(logNotes);
	   			
	   			
	   			
	   			var loadLogs = document.getElementById("loadLogs");	
	   		    var arrayLength  = logs.length;
   			    if(arrayLength>0) {
		   		
			   	 for (var i = 0; i < arrayLength; i++) {
		   		       var cur = logs[i];
		   		
		   		       var divId = 's'+cur.duration;
		   		       finalDuration= cur.duration;
		   		       loadLogs.innerHTML=  loadLogs.innerHTML + '<section id="'+divId+'" class="content" onclick="seekFeeds('+cur.duration+')"><div class="list-group-item text-ellipsis"><span class="badge bg-success" Style="float:left;background-color:#a00a0a;">'+cur.speaker+'</span> &nbsp;&nbsp;<i>said</i><b>&nbsp;&nbsp; '+cur.notes+'</b><br><i>on</i>&nbsp;&nbsp; '+cur.timestamp+'</section>';
	   		    
		   		    } 
	   			
	   		  }
   			    
   			    
   			    
   			    
   		       toneAnalyzedata = JSON.parse(toneAnalyze);
               var document_level_list = document.getElementById('document_level_list');
               
               if(toneAnalyze !="null"){
            	   var tones  =toneAnalyzedata.document_tone.tones;
                   
                   if(tones.length>0){
    		   			
    		   			
    		   			for (var i = 0; i < tones.length; i++) {
    		 	 	       var cur = tones[i];
    		 	 	       var scoredata= cur.score*100;
    	                     
    		 	 	     if(cur.tone_id =='sadness'){
    		 	 	    	 
    		 	 	    	 document_level_list.innerHTML = document_level_list.innerHTML+'<b>'+cur.tone_name+' - '+cur.score+'</b> LIKELY<div class="progress progress-sm m-t-sm progress-striped active">'+
    	            '<div class="progress-bar bg-primary" data-toggle="tooltip" data-original-title="'+scoredata+'%" style="width: '+scoredata+'%;background-color:#000;"></div>'+
    	         '</div>';	 
    		 	 	    	 
    		 	 	    	 
    		 	 	    	 
    		 	 	    	 
    		 	 	    	 
    		 	 	    	 
    		 	 	    	 
    		 	 	    	 
    		 	 	    	 
    		 	 	    	 
    		 	 	    	 
    		 	 	     }
    		 	 	     
    		 	 	     
    		 	 	     else  if(cur.tone_id =='fear'){
    		 	 	    	 
    		 	 	    	document_level_list.innerHTML = document_level_list.innerHTML+'<b>'+cur.tone_name+' - '+cur.score+'</b> LIKELY<div class="progress progress-sm m-t-sm progress-striped active">'+
    		 	            '<div class="progress-bar bg-primary" data-toggle="tooltip" data-original-title="'+scoredata+'%" style="width: '+scoredata+'%;background-color:#325E2B;"></div>'+
    		 	         '</div>';	
    		 	 	    	
    		 	 	    	
    		 	 	    	
    		 	 	    	
    		 	 	    	
    		 	 	    	 
    		 	 	     }
    		 	 	     
    		 	 	   else  if(cur.tone_id =='anger'){
    		 	 	    	 
    		 	 		 document_level_list.innerHTML = document_level_list.innerHTML+'<b>'+cur.tone_name+' - '+cur.score+'</b> LIKELY<div class="progress progress-sm m-t-sm progress-striped active">'+
    		 	            '<div class="progress-bar bg-primary" data-toggle="tooltip" data-original-title="'+scoredata+'%" style="width: '+scoredata+'%;background-color:#E80521;"></div>'+
    		 	         '</div>';
    		 	 		 
    		 	 	    	 
    		 	 	     }
    		 	 	     
    		 	 	     
    		 	 	 else  if(cur.tone_id =='confident'){
    	 	 	    	 
    		 	 		 document_level_list.innerHTML = document_level_list.innerHTML+'<b>'+cur.tone_name+' - '+cur.score+'</b> LIKELY<div class="progress progress-sm m-t-sm progress-striped active">'+
    		 	            '<div class="progress-bar bg-primary" data-toggle="tooltip" data-original-title="'+scoredata+'%" style="width: '+scoredata+'%;background-color:#592684;"></div>'+
    		 	         '</div>';
    		 	 		 
    		 	 		 
    		 	 		 
    		 	 		 
    		 	 		 
    	 	 	    	 
    	 	 	     }
    		 	 	     
    		 	 	else  if(cur.tone_id =='joy'){
    		 	    	 
    		 	 		document_level_list.innerHTML = document_level_list.innerHTML+'<b>'+cur.tone_name+' - '+cur.score+'</b> LIKELY<div class="progress progress-sm m-t-sm progress-striped active">'+
    	 	            '<div class="progress-bar bg-primary" data-toggle="tooltip" data-original-title="'+scoredata+'%" style="width: '+scoredata+'%;background-color:#FFD629;"></div>'+
    	 	         '</div>';
    		 	 		
    		 	 		
    		 	 		
    		 	    	 
    		 	     }
    		 	 	     
    		 	 	else  if(cur.tone_id =='tentative'){
    		 	    	 
    		 	 		document_level_list.innerHTML = document_level_list.innerHTML+'<b>'+cur.tone_name+' - '+cur.score+'</b> LIKELY<div class="progress progress-sm m-t-sm progress-striped active">'+
    	 	            '<div class="progress-bar bg-primary" data-toggle="tooltip" data-original-title="'+scoredata+'%" style="width: '+scoredata+'%;background-color:#ff66fc;"></div>'+
    	 	         '</div>';
    		 	 		
    		 	 		
    		 	 		
    		 	    	 
    		 	     }
    		 	 	     
    		 	 	
    		 	 	     
    		 	 	else  if(cur.tone_id =='analytical'){
    		 	    	 
    		 	 		document_level_list.innerHTML = document_level_list.innerHTML+'<b>'+cur.tone_name+' - '+cur.score+'</b> LIKELY<div class="progress progress-sm m-t-sm progress-striped active">'+
    	 	            '<div class="progress-bar bg-primary" data-toggle="tooltip" data-original-title="'+scoredata+'%" style="width: '+scoredata+'%;background-color:#f4b942;"></div>'+
    	 	         '</div>';
    		 	 		
    		 	 		
    		 	 		
    		 	    	 
    		 	     }
    		 	 	     
    		 	 	    
    		 	 	       
    		 	 	    } 
    		   			
    		   			
    		   			
    		   		}else{
    		   			
    		   			document_level_list.innerHTML = "No results captured.. "
    		   		}
               }
               
            
               
               
   			    
   			    
   			    
   			    
   			    
               sentimentalAnalyzeData = JSON.parse(sentimentalAnalyze);
               
               
               if(sentimentalAnalyze!="null"){
            	   
            	   var keywords  =sentimentalAnalyzeData.keywords;
                   
                   var sentiana_level = document.getElementById('sentiana_level');
    		   		var overall_senti = document.getElementById('overall_senti');
    		   		var sentimentalDataTable = document.getElementById('sentimentalDataTable');
                   
                   
                   
                   
                   
    		   		overall_senti.innerHTML='<section class="panel panel-info">'+ 
    			   	  '<div class="panel-body"> '+
    			      '<div class="clear"> <a href="#" class="text-info" style="font-size:16px;">Overall Sentiment <i class="icon-twitter"></i></a>'+ 
    			      '<small class="block text-muted" style="font-size:15px;">Value : <b>'+sentimentalAnalyzeData.sentiment.document.score+'</b></small>'+ 
    			      '<a href="#" class="btn btn-xs btn-success m-t-xs">'+sentimentalAnalyzeData.sentiment.document.label+'</a> </div> </div> </section>';
    			 	 	   
    			 	 	  
    			    
    			 	 	 if(keywords.length>0){
    			 	 		 
    			 	 		 
    			   			for (var i = 0; i < keywords.length; i++) {
    				 	 	       var cur = keywords[i];
    				 	 	     
    				 	 	     var scoredata= cur.relevance*100;
    			                  
    				 	 	    
    				 	 	     sentimentalDataTable.innerHTML = sentimentalDataTable.innerHTML + ' <tr><td>'+cur.text+'</td>'+
    				 	 	   ' <td>'+cur.relevance+'</td>'+
    				 	 	   ' <td><div class="progress progress-sm progress-striped active m-t-xs m-b-none">'+
    				 	 	   ' <div class="progress-bar bg-success" data-toggle="tooltip" data-original-title="'+scoredata+'%" style="width: '+scoredata+'%;background-color:#E80521;"></div>'+
    				 	 	   ' </div> </td></tr>';
    				 	 	    
    				 	 	       
    				 	 	       
    				 	 	       
    				 	 	       
    				 	 	    } 
    			 	 		 
    			 	 		 
    			 	 		 
    			 	 		 
    			 	 	 }
               }
               
            
               
               
               
               
               
               
               
			 	 	$("#watsonReports").show();
			
   			    
   			    
			 	 	
   			    
   			    
   			    
   			    
   			    
	   			
   		 
	   			
   		       console.log(finalDuration);
   		       console.log(caseEventId);
   		       
	   			var CAM1  = "http://www.rebbon.com/samples/immigration.mp4";
		   		var CAM2  = obj.response.PlayerInfoResult.avLinks.videoFeed2;
		   		 		
		   		var AUD1  = obj.response.PlayerInfoResult.avLinks.audioFeed1;
		   		var AUD2  = obj.response.PlayerInfoResult.avLinks.audioFeed2;
		   			
		  
		   		
		   		var feed1 = document.getElementById("feed1");
		   		
		   
		   		feed1.innerHTML = '<video  id="video1" width="98%" Style="max-height:200px"><source src="'+CAM1+'" type="video/mp4">Your browser does not support HTML5 video.</video><audio id="audio1" src="'+AUD1+'" ></audio>';


		   				
    			var searchHeader = document.getElementById("searchHeader");
	   			searchHeader.innerHTML = '<a href="#" class="font-bold"><div class="fa fa-legal"></div>&nbsp;&nbsp;Case Details</a><span class="label bg-danger pull-right m-t-xs" Style="background-color: #a00a0a;"><a href="video_on_demand.html"><b> <div class="fa fa-search"></div>&nbsp;&nbsp;Search Again </b></a></span>';
	   			document.getElementById("simpleSForm").style.display="none"; 
	   			document.getElementById("caseProgress").style.display="none"; 
	   			//document.getElementById("playerControllers").style.display="block"; 
	   					document.getElementById("caseDetailsPanel").style.display="block"; 
	   					document.getElementById("dynamicFileld").style.display="none";
	   					document.getElementById("searchHeader").style.display="none"; 
	   					document.getElementById("caseWrapDetails").style.display="none"; 
	   					
				var playpausebtn = document.getElementById("playpausebtn");
				playpausebtn.innerHTML ='<div class="fa fa-pause"  style="font-size:25px;"></div>';
				
	   			
	   			if(attachmentFlag==true){
	   				
	   				$.ajax({
	   			      	url: webServerUrl,
	   			      	data: 'request=getAttachment&caseEventId='+caseEventId,
	   			      	type: 'post',
	   						success: function(msg){
	   							
	   						
	   					var ServerResp = msg.trim();
	   						
	   					obj = JSON.parse(ServerResp);
	   			   		 var resultCode  = obj.response.resultcode;
	   			   		 var message  = obj.response.message;
	   			   		 
		   			   	sessionStorage.setItem("loadAttachment", ServerResp);
		   				
	   			   		 

	   			   		if(resultCode== 1)
	   						{	
	   			   			
	   			   		        var loadAttachment = document.getElementById("loadAttachment");	
	   			   		        
	   			   		        var arrayLength  = obj.response.AttachmentList.length;
	   			   			     if(arrayLength>0) {
	   					   		
	   						   	 for (var i = 0; i < arrayLength; i++) {
	   					   		       var cur = obj.response.AttachmentList[i];
	   					   		     
	   					   		       loadAttachment.innerHTML = loadAttachment.innerHTML +'<div class="list-group-item text-ellipsis"> <span class="badge bg-success"><a href="#" onclick="popAttachment('+i+')"><div class="fa fa-eye"></div></a></span><span class="badge bg-success"><a href="'+cur.fileLink+'" download><div class="fa fa-download"></div></a></span>'+cur.attachmentName+'</div>';
		   			   			  
		   			   		       		   					   		    
	   					   		    }
	   					}else {
	   					}
	   			   			 
	   			   			   
	   						}
	   				
	   						else
	   						{
	   					

	   						}
	   					}
	   				
	   				});
	   			}else {
	   				
	   			// var loadAttachment = document.getElementById("loadAttachment");		
	   			 //loadAttachment.innerHTML ='<center><br><i>No Attachments Are Found In This Session!!</i></center>';
	   			}
	   			
	   	
	   			
	   			
		
	   			
	   			intializePlayer();
	   			doTimer();
				}
		
				else
				{
					 var dynamicFileld = document.getElementById("dynamicFileld");
  		   		         dynamicFileld.innerHTML= '<center><br><br><br><div style="font-size:30px;color:#c6aa5d" class="fa fa-warning"></div><br><P style="color:#c6aa5d">'+message+' Try Again!!!</P><br><br><br><center>'+dynamicFileld.innerHTML;    


				}
			}
		
		});
		
		return false;
		
   }
		 


$(document).ready(function(){
	
	
	$.ajax({
      	url: webServerUrl,
      	data: 'request=getCaseTypes',
      	type: 'post',
			success: function(msg){
				
			
		var ServerResp = msg.trim();
			
   		 obj = JSON.parse(ServerResp);
   		 var resultCode  = obj.response.resultcode;
   		 var message  = obj.response.message;
   		 

   		if(resultCode== 1)
			{	
   			   var arrayLength  = obj.response.caseTypeList.length;
   	   		   var caseType = document.getElementById("caseType");
   			   if(arrayLength>0) {
		   		
			   	 for (var i = 0; i < arrayLength; i++) {
		   		       var cur = obj.response.caseTypeList[i];
		   		       caseType.innerHTML=  caseType.innerHTML +'<option value="'+cur.caseType+'">'+cur.caseType+'</option>';    
		   		    
		   		    }
		}else {
		}
   			   
   			   
			}
	
			else
			{
				 var dynamicFileld = document.getElementById("dynamicFileld");
	   		       dynamicFileld.innerHTML= '<center><br><br><br><div style="font-size:30px;color:#c6aa5d" class="fa fa-warning"></div><br><P style="color:#c6aa5d">'+message+' Try Again!!!</P><br><br><br><center>';    


			}
		}
	
	});
	
   
	$("#simple_frm").submit(function(){
		
		var caseNoSimple = $("#caseNoSimple").val();
		sessionStorage.setItem("caseNoSimple", caseNoSimple);
		
		
		var form = $(this);
	    form.parsley().validate();
		if (form.parsley().isValid()){
		
		$.ajax({
	      	url: webServerUrl,
	      	data: 'request=simpleSearch&caseNo='+caseNoSimple,
	      	type: 'post',
				success: function(msg){
					
				
			var ServerResp = msg.trim();
				
	   		 obj = JSON.parse(ServerResp);
	   		 var resultCode  = obj.response.resultcode;
	   		 var message  = obj.response.message;
	   		 

	   		if(resultCode== 1)
				{	
	   			   var arrayLength  = obj.response.SittingList.length;
	   			   var caseProgress = document.getElementById("caseProgress");
	   			   caseProgress.innerHTML ='<i>Search Details for </i><b>'+caseNoSimple+'</b><br><br>';
	   			   var dynamicFileld = document.getElementById("dynamicFileld");
	   			   var searchHeader = document.getElementById("searchHeader");
	   			   searchHeader.innerHTML = '<a href="#" class="font-bold">Search Cases</a><span class="label bg-danger pull-right m-t-xs" Style="background-color: #a00a0a;"><a href="video_on_demand.html"><b> <div class="fa fa-search"></div>&nbsp;&nbsp;Search Again </b></a></span>';
	   			   dynamicFileld.innerHTML = '';
	   			   if(arrayLength>0) {
			   		
				   	 for (var i = 0; i < arrayLength; i++) {
			   		       var cur = obj.response.SittingList[i];
			   		       console.log(cur);
			   		       dynamicFileld.innerHTML=  dynamicFileld.innerHTML +'<p><a href="#" onclick="getSessions('+cur+')" class="btn btn-default btn-block"><i class="fa fa-bars pull-left"></i> &nbsp;&nbsp;Sitting '+cur+' </a></p>';    
			   		    
			   		    }
			}else {
			}
	   			   
	   			   
				}
		
				else
				{
					 var dynamicFileld = document.getElementById("dynamicFileld");
		   		       dynamicFileld.innerHTML= '<center><br><br><br><div style="font-size:30px;color:#c6aa5d" class="fa fa-warning"></div><br><P style="color:#c6aa5d">'+message+' Try Again!!!</P><br><br><br><center>';    


				}
			}
		
		});
		}
		
		return false;
		
	});	
	
	
	
	$("#adv_frm").submit(function(){
		
		var caseNo = $("#caseNo").val();
		var caseTitle = $("#caseTitle").val();
		var caseDate = $("#caseDate").val();
		var caseType = $("#caseType").val();
		
		sessionStorage.setItem("caseNoSimple", caseNo);
		
		
		var form = $(this);
	    form.parsley().validate();
		if (form.parsley().isValid()){
		
		$.ajax({
	      	url: webServerUrl,
	      	data: 'request=advancedSearch&caseNo='+caseNo+'&caseTitle='+caseTitle+'&caseDate='+caseDate+'&caseType='+caseType,
	      	type: 'post',
				success: function(msg){
			
					
			
				
			  var ServerResp = msg.trim();
			  sessionStorage.setItem("advancedSearch", ServerResp);
	   		 obj = JSON.parse(ServerResp);
	   		 var resultCode  = obj.response.resultcode;
	   		 var message  = obj.response.message;
	   		 

	   		if(resultCode== 1)
				{	
	   			   var arrayLength  = obj.response.AdvancedResult.CaseList.length;
	   			   var SittingListarrayLength  = obj.response.AdvancedResult.SittingList.length;
	   			   var caseProgress = document.getElementById("caseProgress");
	   			   caseProgress.innerHTML ='<i>Search Results</i><br><br>';
	   			   var dynamicFileld = document.getElementById("dynamicFileld");
	   			   var searchHeader = document.getElementById("searchHeader");
	   			   searchHeader.innerHTML = '<a href="#" class="font-bold">Search Cases</a><span class="label bg-danger pull-right m-t-xs" Style="background-color: #a00a0a;"><a href="video_on_demand.html"><b> <div class="fa fa-search"></div>&nbsp;&nbsp;Search Again </b></a></span>';
	   			   dynamicFileld.innerHTML = '';
	   			   if(arrayLength>0) {
			   		
				   	 for (var i = 0; i < arrayLength; i++) {
			   		       var cur = obj.response.AdvancedResult.CaseList[i];
			
			   		       dynamicFileld.innerHTML=  dynamicFileld.innerHTML +'<b><a href="#" onclick="getSittings('+i+')">'+cur.caseNo+' - '+cur.caseTitle+'</b><br><i>'+cur.caseDescription+'</i><br><br><br>';    
			   		    
			   		    }
			}else if(SittingListarrayLength>0) {
				
				  var caseProgress = document.getElementById("caseProgress");
	   			   caseProgress.innerHTML ='<i>Search Results For </i><b>'+caseNo+'</b><br><br>';
				
				 for (var i = 0; i < SittingListarrayLength; i++) {
		   		       var cur = obj.response.AdvancedResult.SittingList[i];
		   		       console.log(cur);
		   		       dynamicFileld.innerHTML=  dynamicFileld.innerHTML +'<p><a href="#" onclick="getSessions('+cur+')" class="btn btn-default btn-block"><i class="fa fa-bars pull-left"></i> &nbsp;&nbsp;Sitting '+cur+' </a></p>';    
		   		    
		   		    }
				
				
				
				
				
				
				
			}
	   			    
	   			   
				}
		
				else
				{
					var dynamicFileld = document.getElementById("dynamicFileld");
		   		       dynamicFileld.innerHTML= '<center><br><br><br><div style="font-size:30px;color:#c6aa5d" class="fa fa-warning"></div><br><P style="color:#c6aa5d">'+message+' Try Again!!!</P><br><br><br><center>';    

				}
			}
		
		});
		
		return false;
		
		
		}
		
		
	});	
	
	
	
	$("#login_frm").submit(function(){
		
		var login_id = $("#login_id").val();
		var password = $("#password").val();
		
		var form = $(this);
	    form.parsley().validate();
		if (form.parsley().isValid()){

		 $("#msgbox").removeClass().addClass('myinfo').text('Validating Your Login ').fadeIn(1000);

		
		this.timer = setTimeout(function () {
			
			$.ajax({
	          	url: webServerUrl,
	          	data: 'request=privateNoteAuth&un='+ $('#login_id').val() +'&pw=' + $('#password').val(),
	          	type: 'post',
	   			success: function(msg){
	   			 
	   				var loginJson = msg.trim();	
	   			 obj = JSON.parse(loginJson);
		   		 var resultCode  = obj.response.resultcode;
		   		 var message  = obj.response.message;
	   				
					if(resultCode==1) 
					{	
	   			
	   			
						$("#msgbox").html('Login Verified, Logging in.....').addClass('myinfo').fadeTo(900,1,
		                  function()
		                  {
							document.getElementById("login_box").style.display="none"; 
							document.getElementById("note_box").style.display="block"; 
							
							
		                  });

					}
					else
					{
						$("#msgbox").fadeTo(200,0.1,function() //start fading the messagebox
	                	{
		                  //add message and change the class of the box and start fading
		                  $(this).html(message).removeClass().addClass('myerror').fadeTo(900,1);
		                });

					}
				}
			
			});
		}, 200);
	
		
		}
		return false;
	});	
	
	
	
	
});
