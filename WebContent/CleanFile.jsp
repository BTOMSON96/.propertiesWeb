<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <%@ page import= "java.io.* ,java.util.*, controller.FindKeysController, java.util.regex.* " %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Results</title>
 <style>
   
   .header {
        background-color: lightblue;
        padding: 20px;
        text-align: center;
       }
       
     body{
        font-family: verdana;
        font-size: 15px;
        }
        
         
         
          table, th, td {
         border: 1px solid;
      }
   
   
       th, td {
      padding: 8px;
       text-align: left;
    }
    
    
    
 
     tr:nth-child(even) {
     background-color: #D6EEEE;
       }
       
       
       
      .button{
       background-color: lightblue;
        padding: 10px 26px;
        cursor: pointer;
        color: white;
        font-size: 16px;
       }
      
 </style>
</head>
<body>


<div class="header">
  <h3>RESULTS</h3> 
</div> <br>

<%

//read app properties file
String location = request.getParameter("locationP");
File appProperties = new File(location);
FindKeysController controller = new FindKeysController();

//read file
if(appProperties.isFile()){
	 List<String> list = controller.readAppProperties(location);

	 Map<String, String> map = new HashMap<String, String>();
	    ArrayList<String> noValue = new ArrayList<String>();
	    HashSet<String> upper =new HashSet<String>();
	    HashSet<String> equalSign =new HashSet<String>();
	    ArrayList<String> whiteSpaceKey = new ArrayList<String>();
	    ArrayList<String> leadingWhiteSpace = new ArrayList<String>();
	    ArrayList<String> trailingWhiteSpace = new ArrayList<String>();
	    ArrayList<String> leadingWhiteSpaceOnValues = new ArrayList<String>();
	    HashSet<String> specialCharKeys =new HashSet<String>();
	    HashSet<String> fullStopNotBalancing =new HashSet<String>();
	    HashSet<String> compareValues =new HashSet<String>();
	    HashSet<String> compareKeys =new HashSet<String>();
	    HashSet<String> duplicateKeys =new HashSet<String>();
	    HashSet<String> duplicateValues = new  HashSet<String>();
	    HashSet<String> noKey =new HashSet<String>();
	    
	    Set<String> duplicates1 =new TreeSet<String>(String.CASE_INSENSITIVE_ORDER);
	    Set<String> duplicateKeysIgnoreCase =new TreeSet<String>(String.CASE_INSENSITIVE_ORDER);
	    
	    Set<String> duplicateV =new TreeSet<String>(String.CASE_INSENSITIVE_ORDER);
	    Set<String> duplicateValuesIgnoreCase =new TreeSet<String>(String.CASE_INSENSITIVE_ORDER);
	  
	    int emptyLines = 0;
	    int total = list.size(); 
	    
	    //duplicate entries match case 
	    HashSet<String> checkDuplicateEntriesMatchC =new HashSet<String>();
        HashSet<String> duplicatesMatchCase =new HashSet<String>();
	    //duplicate ignore case
	    Set<String> duplicateEntryIgnoreC = new TreeSet<String>(String.CASE_INSENSITIVE_ORDER);
	     Set<String> duplicatesIgnoreCase =new TreeSet<String>(String.CASE_INSENSITIVE_ORDER);
		  for(String splitFile : list) {
	        	
			  if(!splitFile.trim().isEmpty() && !splitFile.equalsIgnoreCase(",") ){
				  if(!splitFile.endsWith("=")) {
				  String[] parts = splitFile.split("[=:_]+"); 
				  
				  String keys = parts[0].trim();
		          String values = parts[1].trim();
		  
		          map.put(keys, values);

		     
		    //duplicate entry matchcase
		    if(!checkDuplicateEntriesMatchC.add(splitFile)) {
        		duplicatesMatchCase.add(splitFile);	
        	}
		    
		    //duplicate entry ignorecase
		     if(!duplicateEntryIgnoreC.add(splitFile)) {
				 duplicatesIgnoreCase.add(splitFile);
			 }
		    
		          
		  //Duplicate values match case
		   if(!compareValues.add(values)) {
			   duplicateValues.add(values);
			
		   }
		   
		   //Duplicate values IgnoreCase
		     if(!duplicateV.add(values)) {
		    	 duplicateValuesIgnoreCase.add(values);
		    }
		   
	        
		//Duplicate keys matchCase 
	     if(!compareKeys.add(keys)) {
	    	 duplicateKeys.add(keys);
				
		}
		         
	     //Duplicate keys IgnoreCase
	     if(!duplicates1.add(keys)){
	    	 duplicateKeysIgnoreCase.add(keys);
	     }
	     
	     
	     
	     
		  //white space key trailing
		 if(parts[0].toString().endsWith(" ")) {
		   	   trailingWhiteSpace.add(keys);
		   }
		   		 
		          
		 
		//Check UpperCase keys
		for(int i=0;i<keys.length();i++) {
			if(Character.isUpperCase(keys.charAt(i))) {
				upper.add(keys);
				}
			}
		
		
		
		//white space key
		if(keys.trim().contains(" ")) {
     	whiteSpaceKey.add(keys);
     }
		
		
		
		//white space key leading
    if(splitFile.startsWith(" ")) {
			leadingWhiteSpace.add(keys);
		}
		
    
 
    
    
  //white space value leading
    if(splitFile.substring(splitFile.lastIndexOf("=")+ 1).startsWith(" ")) {
			leadingWhiteSpaceOnValues.add(keys);
		}
    
    
    
  
    //full stops not balancing
    if(keys.contains("..") || keys.startsWith(".") || keys.endsWith(".")) {
 	   fullStopNotBalancing.add(keys);
    }
    
    
    
  //Check for special characters
    Pattern pattern = Pattern.compile("[^a-zA-Z.]");
	   Matcher matcherKeys = pattern.matcher(keys);
		 boolean keyContainChar = matcherKeys.find();
		 if( keyContainChar) {
			 specialCharKeys.add(keys);
		 }
    
		//equal signs not balancing
     if(!splitFile.contains("=") || splitFile.contains("==") ) {
     	equalSign.add(splitFile);
     	}
     
     
     
     //No key
     if(splitFile.startsWith("=")) {
     	noKey.add(values);
     }
     
   
	   //add to no value if file ends with equal sign        
	   }else {
			noValue.add(splitFile);
			}	  
       }
			  
	     //Empty line(white space)
		 if(splitFile.trim().isEmpty()) {
		    	   emptyLines++;
		    	   total--;
		  }
}      

%>

<table style="width:50%" >
<tbody>


  <tr>
    <th>DUPLICATE ENTRIES(MATCHCASE):</th>
    <td><%=duplicatesMatchCase.size() %></td>
  </tr>
  
  <tr>
    <th>DUPLICATE ENTRIES(IGNORECASE):</th>
    <td><%= duplicatesIgnoreCase.size() %></td>
  </tr>
  
  <tr>
    <th>DUPLICATE KEYS(MATCHCASE):</th>
    <td><%=duplicateKeys.size() %> </td>
  </tr>
  
  <tr>
    <th>DUPLICATE KEYS(IGNORECASE):</th>
    <td> <%=duplicateKeysIgnoreCase.size()%></td>
  </tr>
  
  <tr>
    <th>DUPLICATE VALUES(MATCHCASE):</th>
    <td><%=duplicateValues.size()%> </td>
  </tr>
  
  <tr>
    <th>DUPLICATE VALUES(IGNORECASE):</th>
    <td><%=duplicateValuesIgnoreCase.size()%> </td>
  </tr>
  
  <tr>
    <th>KEYS WITH NO VALUES:</th>
    <td><%=noValue.size()%> </td>
  </tr>
  
  <tr>
    <th>UPPERCASES ON KEYS:</th>
    <td><%=upper.size()%> </td>
  </tr>
  
  <tr>
    <th>EQUAL SIGN NOT BALANCING:</th>
    <td><%= equalSign.size()%> </td>
  </tr>
  
  <tr>
    <th>WHITE SPACE KEYS:</th>
    <td><%= whiteSpaceKey.size()%> </td>
  </tr>
  
  <tr>
    <th>LEADING WHITE SPACE ON KEYS:</th>
    <td><%=leadingWhiteSpace.size()%> </td>
  </tr>
  
  <tr>
    <th>TRAILING WHITE SPACE ON KEYS:</th>
    <td><%=trailingWhiteSpace.size()%> </td>
  </tr>
  
  <tr>
    <th>LEADING WHITE SPACE ON VALUES:</th>
    <td><%=leadingWhiteSpaceOnValues.size()%> </td>
  </tr>
  
  <tr>
    <th>EMPTY LINES:</th>
    <td><%=emptyLines%> </td>
  </tr>
  
  <tr>
    <th>SPECIAL CHARACTERS ON KEYS:</th>
    <td><%=specialCharKeys.size() %> </td>
  </tr>
  
  <tr>
    <th>NO KEY:</th>
    <td><%= noKey.size() %> </td>
  </tr>
  
  <tr>
    <th>FULL STOPS NOT BALANCING:</th>
    <td><%= fullStopNotBalancing.size() %> </td>
  </tr>
  
  <tr>
    <th>TOTAL ENTRIES:</th>
    <td><%=total %> </td>
  </tr>
  
  </tbody>
</table><br></br>

<input type="submit" value="BACK" class="button" onclick="goBack()"> 




 <script>

   
   //go back
    function goBack() {
        window.history.back()
    }

    
    
</script> 

<% 
}else{
	
	out.println("File doesnt exist");
}
%> 
</body>
</html>