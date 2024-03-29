<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*, java.io.*, java.util.*,org.json.*,
					org.apache.commons.httpclient.HttpClient,
					org.apache.commons.httpclient.methods.PostMethod,org.apache.commons.httpclient.MultiThreadedHttpConnectionManager,
					org.apache.commons.httpclient.HttpStatus" %>  
					
<%session.setMaxInactiveInterval(-1);%>




<%!	String requestToAppServer(String link,List<String> postData,HttpClient client){
	
	PostMethod method = new PostMethod("https://evidencer.mybluemix.net/evidencer/"+link);  
 /* 	PostMethod method = new PostMethod("http://127.0.0.1:8080/Evidencer/evidencer/"+link);   */
	if(postData!=null)
		for(int i=0;i<postData.size();i+=2){
			
			method.addParameter(postData.get(i), postData.get(i+1));
		}
	
	BufferedReader br = null;
	StringBuilder responseSB = new StringBuilder();
	try{
		
		int returnCode = client.executeMethod(method);

	      if(returnCode == HttpStatus.SC_NOT_IMPLEMENTED) {
	    	  
	        System.err.println("The Post method is not implemented by this URI");
	        // still consume the response body
	        method.getResponseBodyAsString();
	        
	      } 
	      else {
	    	  
	    	  br = new BufferedReader(new InputStreamReader(method.getResponseBodyAsStream()));
	    	  String readLine;
	    	  while(((readLine = br.readLine()) != null)){
	    		  responseSB.append(readLine);
	    	  }
	      }
	}	catch (Exception e) {
	      System.err.println(e);
	    } finally{
	    	
	    	method.releaseConnection();
	    	if(br != null) 
	    		try {
	    			br.close();
	    			} catch (Exception fe) {}
	    	
	    }
	
	System.out.println("Evidencer Web Server : "+responseSB.toString());
	method.releaseConnection();
	return responseSB.toString(); 
	
}
%>


<%
       String requestOrigin = request.getParameter("request"); 

       if(requestOrigin.equals("login")){
    	   
    	    String link = "login";
    	    String userName = request.getParameter("username");    
    	    String password = request.getParameter("password");
    	    
    	    MultiThreadedHttpConnectionManager connectionManager = new MultiThreadedHttpConnectionManager();    	    
    	    HttpClient client = new HttpClient(connectionManager);
    	    session.setMaxInactiveInterval(-1); 
    	    session.setAttribute("client",client);
    	    session.setAttribute("userName",userName);
    	    
    	    ArrayList<String> postData = new ArrayList<String>();
    	   	postData.add("userName");
    	   	postData.add(userName);
    	   	postData.add("password");
    	   	postData.add(password);
    	   	
    	   	String serverResponse = requestToAppServer(link,postData,client);
    	   	out.println(serverResponse);
    	   
       }
       
       
       
       if(requestOrigin.equals("getSpeechToken")){
    	   
   	    String link = "getSpeechToken";
   	    
   	    
   	    MultiThreadedHttpConnectionManager connectionManager = new MultiThreadedHttpConnectionManager();    	    
   	  HttpClient client=(HttpClient)session.getAttribute("client"); 
   	    session.setMaxInactiveInterval(-1); 
   	    session.setAttribute("client",client);
   	  
   	    
   	    ArrayList<String> postData = new ArrayList<String>();
   	   	
   	   	String serverResponse = requestToAppServer(link,postData,client);
   	   	out.println(serverResponse);
   	   
      }
       
       else if(requestOrigin.equals("register")){
    	   
   	     String link = "register";
	   	 String name = request.getParameter("name");    
	     String username = request.getParameter("username");
	     String npassword = request.getParameter("password");
	     String email = request.getParameter("email");
	     String mobile = request.getParameter("mobile");
	   	    
 	     MultiThreadedHttpConnectionManager connectionManager = new MultiThreadedHttpConnectionManager();    	    
 	     HttpClient client = new HttpClient(connectionManager);
 	     session.setMaxInactiveInterval(-1); 
 	     session.setAttribute("client",client);	    
	   	 ArrayList<String> postData = new ArrayList<String>();
	   		   	 
	   	 postData.add("userName");
	   	 postData.add(username);
	   	 postData.add("password");
	   	 postData.add(npassword);
	   	 postData.add("firstName");
	   	 postData.add(name);
	   	 postData.add("eMail");
	   	 postData.add(email);
	   	 postData.add("mobileNo");
	   	 postData.add(mobile);
	  
	   	   	String serverResponse = requestToAppServer(link,postData,client);
	   	   	out.println(serverResponse);
   	   
      }
       
       
       else if(requestOrigin.equals("regCode")){
    	   
      	    String link = "regCode";
      	    String emailCode = request.getParameter("emailCode");   
			String smsCode = request.getParameter("smsCode");
			
      	    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
      	    ArrayList<String> postData = new ArrayList<String>();
      		postData.add("smsCode");
     	   	postData.add(smsCode);
     	   	postData.add("emailCode");
    	   	postData.add(emailCode);
    
     
      	   	String serverResponse = requestToAppServer(link,postData,client);
      	   	out.println(serverResponse);
      	   
         }
       
       
       else if(requestOrigin.equals("regPro")){
    	   
     	    String link = "regPro";
     	    
     	    String fname = request.getParameter("fname");  
	   		String mname = request.getParameter("mname");  
	   		String lname = request.getParameter("lname");  
	   		
	   		String location = request.getParameter("location");
	   		String semail = request.getParameter("semail");
	   		String smobile = request.getParameter("smobile");
	   		
	   		
	   		String secq1 = request.getParameter("secq1");
	   		String seca1 = request.getParameter("seca1");
	   		
	   		String secq2 = request.getParameter("secq2");
	   		String seca2 = request.getParameter("seca2");
	   		
	   		String secq3 = request.getParameter("secq3");
	   		String seca3 = request.getParameter("seca3");
			
     	    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
     	    ArrayList<String> postData = new ArrayList<String>();
 
     	    postData.add("firstName");
     	   	postData.add(fname);
     	   	postData.add("middleName");
    	   	postData.add(mname);
    		postData.add("lastName");
    	   	postData.add(lname);
    		postData.add("secMail");
    	   	postData.add(semail);
    		postData.add("secMobile");
    	   	postData.add(smobile);
    		postData.add("questionOne");
    	   	postData.add(secq1);
    		postData.add("answerOne");
    	   	postData.add(seca1);
    		postData.add("questionTwo");
    	   	postData.add(secq2);
    		postData.add("answerTwo");
    	   	postData.add(seca2);
    	   	postData.add("questionThree");
    	   	postData.add(secq3);
    	   	postData.add("answerThree");
    	   	postData.add(seca3);
    
     	   	String serverResponse = requestToAppServer(link,postData,client);
     	   	out.println(serverResponse);
     	   
        }
       
       else if(requestOrigin.equals("getLiveSessions")){
    	   
    	    String link = "getLiveSessions";
    	    
    	    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
    	    ArrayList<String> postData = new ArrayList<String>();

    	   	String serverResponse = requestToAppServer(link,postData,client);
    	   	out.println(serverResponse);
    	   
       }
       
       
       else if(requestOrigin.equals("getLiveDetails")){
    	   
   	    String link = "getLiveDetails";
   	    
   	    String caseEventId = request.getParameter("caseEventId"); 
   	    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
   	    ArrayList<String> postData = new ArrayList<String>();
   	    
   		postData.add("caseEventId");
	   	postData.add(caseEventId);

   	   	String serverResponse = requestToAppServer(link,postData,client);
   	   	out.println(serverResponse);
   	   
      }
       
      else if(requestOrigin.equals("checkCase")){
    	   
      	    String link = "checkCase";
      	    
      	    String caseNo = request.getParameter("caseNo");   
            caseNo = caseNo.toUpperCase();
    
      	    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
      	    ArrayList<String> postData = new ArrayList<String>();
      	    
      		postData.add("caseNo");
   	     	postData.add(caseNo);

      	   	String serverResponse = requestToAppServer(link,postData,client);
      	   	out.println(serverResponse);
      	   
         }
       
      else if(requestOrigin.equals("getCaseTypes")){
   	   
    	    String link = "getCaseTypes";
    	  
    	    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
    	    ArrayList<String> postData = new ArrayList<String>();
    	   
    	   	String serverResponse = requestToAppServer(link,postData,client);
    	   	out.println(serverResponse);
    	   
       }
        
       else if(requestOrigin.equals("forceStartRecord")){
       	   
   	    String link = "forceStartRecord";
   	  
   	    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
   	    ArrayList<String> postData = new ArrayList<String>();
   	   
   	   	String serverResponse = requestToAppServer(link,postData,client);
   	   	out.println(serverResponse);
   	   
      }
       
       
       
       
       else if(requestOrigin.equals("saveAttachment")){
       	   
     	    System.out.println("saveAttachment");
     	   
        } 
       
       
       else if(requestOrigin.equals("stopRecord")){
       	   
    	   String link = "stopRecord";
     	    String lognotes= request.getParameter("finalJson");
     	   
     	    String toneAnalyze= request.getParameter("toneAnalyze");
     	    String sentimentalAnalyze= request.getParameter("sentimentalAnalyze");
     	    
     	    
     	    
     	    
     	  System.err.println("PtoneAnalyze :"+ toneAnalyze);
 		System.err.println("PsentimentalAnalyze : "+ sentimentalAnalyze);
     	    
     	    HttpClient client=(HttpClient)session.getAttribute("client");
     	    session.setMaxInactiveInterval(-1); 
     	    ArrayList<String> postData = new ArrayList<String>();
     	    
     	    postData.add("IDE");
	     	postData.add("portal");
	     	
	     	postData.add("toneAnalyze");
	     	postData.add(toneAnalyze);
	     	
	     	postData.add("sentimentalAnalyze");
	     	postData.add(sentimentalAnalyze);
	     	
	     	postData.add("initiatedFrom");
	     	postData.add("Smarter Judiciary");
	     	postData.add("stopRecordJson");
	     	postData.add(lognotes);
	     	
	     	System.out.println(lognotes);
      	   
      	   	String serverResponse = requestToAppServer(link,postData,client);
      	   	out.println(serverResponse);
      	   
         }
       
       
      else if(requestOrigin.equals("newCase")){
      	   
  	    String link = "newCase";
  	    
  	    String caseNo = request.getParameter("caseNo");   
		String caseTitle = request.getParameter("caseTitle");   
		String caseDescription = request.getParameter("caseDesc");   
		String sittingNo = request.getParameter("sittingNo");   
		String sessionNo = request.getParameter("sessionNo");   
		
		String confidential = request.getParameter("confidential"); 
		if(confidential != null && !confidential.isEmpty())
		{
			confidential = "true";
		} else{
			confidential = "false";
		}
		
		String caseType = request.getParameter("caseType");   
	
		String judges[]= request.getParameterValues("judges");
	
		if(judges.length>0)	{	
		for(int i=0;i<judges.length;i++)
		{
		
		}
		
    }	
		
		
		
		String lawyers[]= request.getParameterValues("lawyers");
		
		if(lawyers.length>0)	{	
		for(int i=0;i<lawyers.length;i++)
		{
		
		}
		
    }	
		
		
		String participants[]= request.getParameterValues("participants");
		
		if(participants.length>0)	{	
		for(int i=0;i<participants.length;i++)
		{
		
		}
		
    }	
		
		
		String others[]= request.getParameterValues("others");
		
		if(others.length>0)	{	
		for(int i=0;i<others.length;i++)
		{
		
		}
		
    }	
		
		JSONObject startRecordJson = new JSONObject();
		
		startRecordJson.put("caseNo", caseNo.trim());
		startRecordJson.put("caseTitle", caseTitle.trim());
		startRecordJson.put("caseDescription", caseDescription.trim());
		startRecordJson.put("sittingNo", sittingNo.trim());
		startRecordJson.put("sessionNo", sessionNo.trim());
		startRecordJson.put("confidential", confidential.trim());
		startRecordJson.put("statusFlag", "NewCase"); 
		startRecordJson.put("caseType", caseType.trim());
		startRecordJson.put("others", others);
		startRecordJson.put("participants", participants);
		startRecordJson.put("lawyers", lawyers);
		startRecordJson.put("judges", judges);
		
		
  	    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
  	    ArrayList<String> postData = new ArrayList<String>();
  	    
  	        postData.add("IDE");
	     	postData.add("portal");
	     	
	     	
	     	
	     	postData.add("initiatedFrom");
	     	postData.add("Smarter Immigration");
	     	
	     	
	     	
	     	postData.add("newCaseJson");
	     	
   	     	postData.add(startRecordJson.toString());
  	    
  	   
  	   	String serverResponse = requestToAppServer(link,postData,client);
  	   	out.println(serverResponse);
  	   
     }
       
       
      else if(requestOrigin.equals("privateNoteAuth")){
      	   
     	    String link = "privateNoteAuth";
     	    String user=request.getParameter("un");
     		String pass=request.getParameter("pw");
     	  
     	    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
     	    ArrayList<String> postData = new ArrayList<String>();
     	    
     	    postData.add("userName");
	     	postData.add(user);
	     	postData.add("password");
  	     	postData.add(pass);
     	    
  	     	session.setAttribute("privateNoteUserName",user);
  	     	
     	   	String serverResponse = requestToAppServer(link,postData,client);
     	   	out.println(serverResponse);
     	   
        }
       
      else if(requestOrigin.equals("enterPrivateNote")){
     	   
   	    String link = "enterPrivateNote";
   	   
   	    String privateNote=request.getParameter("notes");
   	    String privateNoteUserName = session.getAttribute("privateNoteUserName").toString();
   	  
   	    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
   	    ArrayList<String> postData = new ArrayList<String>();
   	    
   	        postData.add("privateNote");
	     	postData.add(privateNote);
	     	postData.add("privateNoteUserName");
	     	postData.add(privateNoteUserName);
   	   
   	   	String serverResponse = requestToAppServer(link,postData,client);
   	   	out.println(serverResponse);
   	   
      }
       
      else if(requestOrigin.equals("simpleSearch")){
    	   
     	    String link = "simpleSearch";
     	   
     	    String caseNo = request.getParameter("caseNo");   
     	  
     	    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
     	    ArrayList<String> postData = new ArrayList<String>();
     	    
     	    postData.add("caseNo");
  	     	postData.add(caseNo);
  	     	
     	   	String serverResponse = requestToAppServer(link,postData,client);
     	   	out.println(serverResponse);
     	   
        }
       
       
      else if(requestOrigin.equals("advancedSearch")){
      	   
     	    String link = "advancedSearch";
     	   
          String caseNo = request.getParameter("caseNo"); 
  		String caseDate = request.getParameter("caseDate");    
  		String caseType = request.getParameter("caseType");    
  		String caseTitle = request.getParameter("caseTitle"); 
  		
  		 if(caseType.equals("null")){
  			 caseType="";
  		 }
  		
  	   
     	    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
     	    ArrayList<String> postData = new ArrayList<String>();
     	    
     	    postData.add("caseNo");
	  	    postData.add(caseNo);
	  	    postData.add("caseDate");
	  	    postData.add(caseDate);
	  	    postData.add("caseType");
	  	    postData.add(caseType);
	  	    postData.add("caseTitle");
	  	    postData.add(caseTitle);
  	     	
  	    
  	    
     	   	String serverResponse = requestToAppServer(link,postData,client);
     	   	out.println(serverResponse);
     	   
        }


      else if(requestOrigin.equals("sessionSearch")){
   	   
   	    String link = "sessionSearch";
   	   
   	    String caseNo = request.getParameter("caseNo"); 
   	    String sittingNo = request.getParameter("sittingNo");    
   	  
   	    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
   	    ArrayList<String> postData = new ArrayList<String>();
   	    
   	    postData.add("caseNo");
	    postData.add(caseNo);
	    postData.add("sittingNo");
	    postData.add(sittingNo);
	     	
   	   	String serverResponse = requestToAppServer(link,postData,client);
   	   	out.println(serverResponse);
   	   
      }
       
       
      else if(requestOrigin.equals("getPlayerInfo")){
      	   
     	    String link = "getPlayerInfo";
     	   
     	    String caseNo = request.getParameter("caseNo"); 
     	    String sittingNo = request.getParameter("sittingNo");
     	   String sessionNo = request.getParameter("sessionNo"); 
     	  
     	    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
     	    ArrayList<String> postData = new ArrayList<String>();
     	    
     	    postData.add("caseNo");
	  	    postData.add(caseNo);
	  	    postData.add("sittingNo");
	  	    postData.add(sittingNo);
	  	    postData.add("sessionNo");
	  	    postData.add(sessionNo);
  	     	
     	   	String serverResponse = requestToAppServer(link,postData,client);
     	   	out.println(serverResponse);
     	   
        }
       
      else if(requestOrigin.equals("getAttachment")){
     	   
   	    String link = "getAttachment";
   	   
   	   
   	    String caseEventId = request.getParameter("caseEventId"); 
   	    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
   	    ArrayList<String> postData = new ArrayList<String>();
   	    
   	        postData.add("caseEventId");
	  	    postData.add(caseEventId);
	  	    
	     	
   	   	String serverResponse = requestToAppServer(link,postData,client);
   	   	out.println(serverResponse);
   	   
      }
       
      else if(requestOrigin.equals("getPrivateNote")){
     	   
   	    String link = "getPrivateNote";
   	   
   	   
   	    String caseEventId = request.getParameter("caseEventId"); 
   	    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
   	    ArrayList<String> postData = new ArrayList<String>();
   	    
   	      postData.add("caseEventId");
	      postData.add(caseEventId);
	     	
   	   	String serverResponse = requestToAppServer(link,postData,client);
   	   	out.println(serverResponse);
   	   
      }

      else if(requestOrigin.equals("getAllMobFiles")){
    	   
     	    String link = "getAllMobFiles";
     	   
     	   
     	    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
     	    ArrayList<String> postData = new ArrayList<String>();
     	    
     	   	String serverResponse = requestToAppServer(link,postData,client);
     	   	out.println(serverResponse);
     	   
        }
       
      else if(requestOrigin.equals("viewProfile")){
   	   
   	    String link = "viewProfile";
   	   
   	   
   	    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
   	    ArrayList<String> postData = new ArrayList<String>();
   	    
   	   	String serverResponse = requestToAppServer(link,postData,client);
   	   	out.println(serverResponse);
   	   
      }
       
       
      else if(requestOrigin.equals("updateProfile")){
      	   
     	    String link = "updateProfile";
     	   
     	    String fname = request.getParameter("fname"); 
   			String mname = request.getParameter("mname");  
   			String lname = request.getParameter("lname");  
   		
   			String semail = request.getParameter("semail");
   			String smobile = request.getParameter("smobile");
     	   
     	    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
     	    ArrayList<String> postData = new ArrayList<String>();
     	         	    
     	   	postData.add("firstName");
 	       	postData.add(fname);
 	      	postData.add("middleName");
	      	postData.add(mname);
	      	postData.add("lastName");
	      	postData.add(lname);
	      	postData.add("secMobile");
	      	postData.add(smobile);
	      	postData.add("secMail");
	      	postData.add(semail);
     	    
     	   	String serverResponse = requestToAppServer(link,postData,client);
     	   	out.println(serverResponse);
     	   
        }
       
       
      else if(requestOrigin.equals("deleteProPic")){
     	   
   	    String link = "deleteProPic";
   	   
   	    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
   	    ArrayList<String> postData = new ArrayList<String>();
   	         	    

   	   	String serverResponse = requestToAppServer(link,postData,client);
   	   	out.println(serverResponse);
   	   
      }
       
      else if(requestOrigin.equals("changePasswordPortal")){
    	   
     	    String link = "changePasswordPortal";
     	    
     	    String cpwd = request.getParameter("cpwd"); 
     	   
     	    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
     	    ArrayList<String> postData = new ArrayList<String>();
     	     
     	    postData.add("newPassword");
	       	postData.add(cpwd);

     	   	String serverResponse = requestToAppServer(link,postData,client);
     	   	out.println(serverResponse);
     	   
        }
       
       
      else if(requestOrigin.equals("viewProfile")){
      	   
     	    String link = "viewProfile";
     	   
     	   
     	    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
     	    ArrayList<String> postData = new ArrayList<String>();
     	    
     	   	String serverResponse = requestToAppServer(link,postData,client);
     	   	out.println(serverResponse);
     	   
        }
       
       
      else if(requestOrigin.equals("forgotPassword")){
     	   
   	     String link = "forgotPassword";
   	   
	   	 String username = request.getParameter("username");    
	     String email = request.getParameter("email");

   	   
	     MultiThreadedHttpConnectionManager connectionManager = new MultiThreadedHttpConnectionManager();    	    
 	     HttpClient client = new HttpClient(connectionManager);
 	     session.setMaxInactiveInterval(-1); 
	    session.setAttribute("client",client);
   	    ArrayList<String> postData = new ArrayList<String>();
   	    
   	    postData.add("userName");
    	postData.add(username);
    	postData.add("eMail");
	    postData.add(email);
   	    
   	    
   	   	String serverResponse = requestToAppServer(link,postData,client);
   	   	out.println(serverResponse);
   	   
      }
       
      else if(requestOrigin.equals("forgotPassAnswer")){
    	   
    	     String link = "forgotPassAnswer";
    	   
    	    String answer1 = request.getParameter("answer1");   
 			String answer2 = request.getParameter("answer2");   
 			String question1 = request.getParameter("question1");   
 			String question2 = request.getParameter("question2"); 

    	   
 			HttpClient client=(HttpClient)session.getAttribute("client"); 	    
    	    ArrayList<String> postData = new ArrayList<String>();
    	    
    	    postData.add("securityAnswer1");
	     	postData.add(answer1);
	     	postData.add("securityAnswer2");
	 	    postData.add(answer2);
	 	    postData.add("securityQuestion1");
	     	postData.add(question1);
	     	postData.add("securityQuestion2");
	 	    postData.add(question2);
    	 
	
    	   	String serverResponse = requestToAppServer(link,postData,client);
    	   	out.println(serverResponse);
    	   
       }

      else if(requestOrigin.equals("resetPassword")){
   	   
 	     String link = "resetPassword";
 	   
 	    String secretcode = request.getParameter("secretcode"); 
		String npassword = request.getParameter("npassword");  
		String cpassword = request.getParameter("cpassword");  
		

 	   
		HttpClient client=(HttpClient)session.getAttribute("client"); 	    
 	    ArrayList<String> postData = new ArrayList<String>();
 	    
 	        postData.add("token");
	     	postData.add(secretcode);
	     	postData.add("newPassword");
	 	    postData.add(npassword);

	
 	   	String serverResponse = requestToAppServer(link,postData,client);
 	   	out.println(serverResponse);
 	   
    }
       
       
      else if(requestOrigin.equals("logout")){
      	   
  	     String link = "logout";
  	   
  	   
 		HttpClient client=(HttpClient)session.getAttribute("client"); 	    
  	    ArrayList<String> postData = new ArrayList<String>();
  	    
 	
  	   	String serverResponse = requestToAppServer(link,postData,client);
  	   	out.println(serverResponse);
  	   
     }
       
      else if(requestOrigin.equals("getAllDetails")){
     	   
   	     String link = "getAllDetails";
   	   
   	   
  		HttpClient client=(HttpClient)session.getAttribute("client"); 	    
   	    ArrayList<String> postData = new ArrayList<String>();
   	    
  	
   	   	String serverResponse = requestToAppServer(link,postData,client);
   	   	out.println(serverResponse);
   	   
      }
  	
	
      else if(requestOrigin.equals("confirmReg")){
    	   
    	     String link = "confirmReg";
    	     
    	     String acceptOrReject = request.getParameter("acceptOrReject"); 
    	     String userName = request.getParameter("userName");  
    	   
   		    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
    	    ArrayList<String> postData = new ArrayList<String>();
    	    
    	    if(acceptOrReject.equals("false")) {
    	    	
    	    	    postData.add("userName");
    		     	postData.add(userName);
    		     	postData.add("userType");
    		 	    postData.add("");
    		 	   	postData.add("roleId");
	   		     	postData.add("");
	   		     	postData.add("acceptOrReject");
	   		 	    postData.add("false");
	   		 	    postData.add("privilegeIdJson");
	   		 	    postData.add("{privilageList:[]}");
    	    	
    	    }
    	    
    	    if(acceptOrReject.equals("true")) {
    	    	
    	    	   String role = request.getParameter("role"); 	
    	    	   String privJson = request.getParameter("privJson"); 	
    	    	
    	    	
	    	    postData.add("userName");
		     	postData.add(userName);
		     	postData.add("userType");
		 	    postData.add("1");
		 	   	postData.add("roleId");
   		     	postData.add(role);
   		     	postData.add("acceptOrReject");
   		 	    postData.add("true");
   		 	    postData.add("privilegeIdJson");
   		 	    postData.add(privJson);
	    	
	    }
    	    
   	
    	   	String serverResponse = requestToAppServer(link,postData,client);
    	   	out.println(serverResponse);
    	   
       }
       
       
      else if(requestOrigin.equals("setFileStatus")){
    	   
    	     String link = "setFileStatus";
    	     
    	     String randomCode = request.getParameter("randomCode"); 	
	    	  String status = request.getParameter("status"); 
    	   
    	   
   		    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
    	    ArrayList<String> postData = new ArrayList<String>();
    	    
    	    postData.add("randomCode");
	     	postData.add(randomCode);
	     	postData.add("status");
	 	    postData.add(status);
	 	    
	 	    
    	   	String serverResponse = requestToAppServer(link,postData,client);
    	   	out.println(serverResponse);
    	   
       }
       
      else if(requestOrigin.equals("getMobFile")){
   	   
 	     String link = "getMobFile";
 	     
 	          String randomCode = request.getParameter("randomCode"); 	
	 
 	   
 	   
		    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
 	        ArrayList<String> postData = new ArrayList<String>();
 	    
 	    	postData.add("randomCode");
	     	postData.add(randomCode);
	     
	 	    
	 	    
 	   	String serverResponse = requestToAppServer(link,postData,client);
 	   	out.println(serverResponse);
 	   
    }
       
       
      else if(requestOrigin.equals("updateLoc")){
      	   
  	     String link = "updateLoc";
  	     
  	          String locPath = request.getParameter("locPath"); 	
 	 
  	   
  	   
 		    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
  	        ArrayList<String> postData = new ArrayList<String>();
  	    
  	    	postData.add("locPath");
 	     	postData.add(locPath);
 	     
 	 	    
 	 	    
  	   	String serverResponse = requestToAppServer(link,postData,client);
  	   	out.println(serverResponse);
  	   
     }
       
       
      else if(requestOrigin.equals("insertLoc")){
     	   
   	     String link = "insertLoc";
   	     
   	          String locPath = request.getParameter("locPath"); 	
   	       String username = request.getParameter("username"); 	
  	 
   	   
   	   
  		    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
   	        ArrayList<String> postData = new ArrayList<String>();
   	    
   	    	postData.add("locPath");
  	     	postData.add(locPath);
  	     	postData.add("userName");
  	     	postData.add(username);
  	     
  	 	    
  	 	    
   	   	String serverResponse = requestToAppServer(link,postData,client);
   	   	out.println(serverResponse);
   	   
      }
       
      else if(requestOrigin.equals("registerMobFile")){
    	   
    	     String link = "registerMobFile";
    	     
    	          String randomCode = request.getParameter("randomCode"); 	
    	       String caseNumberForLink = request.getParameter("caseNumberForLink"); 	
   	 
    	   
    	   
   		    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
    	        ArrayList<String> postData = new ArrayList<String>();
    	    
    	    	postData.add("caseNo");
   	     	postData.add(caseNumberForLink);
   	     	postData.add("randomCode");
   	     	postData.add(randomCode);
   	     
   	 	    
   	 	    
    	   	String serverResponse = requestToAppServer(link,postData,client);
    	   	out.println(serverResponse);
    	   
       }
       
       
       
       
       
       
       
       
      else if(requestOrigin.equals("getLoc")){
      	   
  	     String link = "getLoc";
  	     
 		    HttpClient client=(HttpClient)session.getAttribute("client"); 	    
  	        ArrayList<String> postData = new ArrayList<String>();
  	      
 	 	    
 	 	    
  	   	String serverResponse = requestToAppServer(link,postData,client);
  	   	out.println(serverResponse);
  	   
     }
       
       
      else if(requestOrigin.equals("downloadFile")){
    	  
    	  String url = request.getParameter("url"); 
    	  String defLoc = request.getParameter("defLoc"); 
    	  String caseEventId = request.getParameter("caseEventId"); 
    	  System.out.println(defLoc);
    	  System.out.println(caseEventId);
    	  
    	  
    	  
    	  
    	  File theDir = new File(defLoc+"//CaseRecords");

    
    	if (!theDir.exists()) {
    	    System.out.println("creating directory: " + theDir);
    	    boolean result = false;

    	    try{
    	        theDir.mkdir();
    	        result = true;
    	    } 
    	    catch(SecurityException se){
    	    }        
    	    if(result) {    
    	        System.out.println("DIR created");  
    	    }
    	}
    	  
    	  
    	  
    	         File theDir1 = new File(defLoc+"//CaseRecords//"+caseEventId);
 theDir1.mkdir();
    	  
 		  URL link = new URL(url); 
 		
 		  File file = new File(theDir+"//"+caseEventId+"//vidch1.mp4");
 		  
 		 org.apache.commons.io.FileUtils.copyURLToFile(link, file);
  
 		
      	   
    	 
			
     }
       
       
       
      else if(requestOrigin.equals("changeProPic"))
      {
   	   
    	    String link = "changeProPic";
   	    String fileString = request.getParameter("fileString");
   	    
   	      	 
   	    MultiThreadedHttpConnectionManager connectionManager = new MultiThreadedHttpConnectionManager();    	    
   		HttpClient client=(HttpClient)session.getAttribute("client"); 	    
    	    ArrayList<String> postData = new ArrayList<String>();
    	        
    
   	   		postData.add("file");
   	   	 	postData.add(fileString);
   	   	 	

   	   	String serverResponse = requestToAppServer(link,postData,client);
    	   	out.println(serverResponse);
    	   
       }  
        
       

%>
       
   	
   	

