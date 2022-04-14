<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Clean .properties file</title>
    <script>
    
    function validateForm() {
       let location = document.forms["cleanProperties"]["locationP"].value;
         if(location == ""){
		 alert("File Location must be filled out");
		  return false;
       }
    }
    //go back
    function goBack() {
        window.history.back()
    }


</script>




  <style>
  
  h3{
      text-align: center;
       
    }
    
   .header {
      background-color: lightblue;
      padding: 40px;
       }
  
    .button{
       background-color: lightblue;
        padding: 10px 26px;
        cursor: pointer;
        color: white;
        font-size: 16px;
       }
       body{
        font-family: verdana;
        font-size: 15px;
        
        }
        
    
       
       
  </style>
</head>



<body>
<div class="header">
<h3>CLEAN .PROPERTIES FILE</h3>
</div><br>
<form  name="cleanProperties" action="CleanFile.jsp" onsubmit="return validateForm()" >



<label for="location">Enter File Location:</label>
<input type="text" name="locationP" size="80" /><br/><br/> 
<input type="button"  value="BACK" class="button" onclick="goBack()"> <input type="submit" value="CLEAN" class="button" > <br/><br/> <br/><br/> 
</form>







</body>
</html>