<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Check unused keys</title>





<script >

function validateForm() {
  let directory = document.forms["UnusedKeys"]["directory"].value;
  
  if (directory == "") {
    alert("Directory must be filled out");
    return false;
  }


  
  let location = document.forms["UnusedKeys"]["location"].value;
  if(location == ""){
		 alert("File Location must be filled out");
		  return false;
 }


  
  let ext = document.forms["UnusedKeys"]["extensions"].value;
  if(ext == "" ){
		 alert("Choose file extension");
		  return false;
  }
}

</script>




    <style>
    
    h3{
      text-align: center;
     color: lightblue;
       }
       
       body{
        font-family: verdana;
        font-size: 15px;
        
        }
        /*
        .header {
        background-color: lightblue;
        padding: 40px;
        text-align: left;
       }
       */
       
       .button{
       background-color: lightblue;
        padding: 10px 26px;
        cursor: pointer;
        color: white;
        font-size: 16px;
       }
       
       /* Add a background color to the top navigation */
       .topnav {
          background-color: lightblue;
          overflow: hidden;
          }

/* Style the links inside the navigation bar */
        .topnav a {
             float: left;
             color: #f2f2f2;
             text-align: center;
             padding: 14px 16px;
             text-decoration: none;
             font-size: 17px;
           }

       /* Change the color of links on hover */
          .topnav a:hover {
         background-color: #ddd;
         color: black;
           }

       /* Add a color to the active/current link */
       .topnav a.active {
         background-color: blue;
        color: white;
        }
        
        
    </style>
    
    
</head>
<body>


<div class="topnav">
  
  <a class="active" href="#home">FIND KEYS</a>
  <a href="Clean.jsp">CLEAN .PROPERTIES FILE</a>
  
</div> <br>


<h3>FIND UNUSED KEYS IN .PROPERTIES FILE</h3> 



<form name="UnusedKeys" action="FindKeys.jsp" onsubmit="return validateForm()" >

<label for="location">Enter File Location:</label>
<input type="text" name="location" size="80" /><br/><br/> 

<label for="edirectory">Enter File Directory:</label>
<input type="text" name="directory" size="80" /><br/><br/> 

<label for="addExt">Choose file extension:</label><br>
<select multiple name="extensions" id="extensions">
  <option value="jsp">JSP</option>
  <option value="html">HTML</option>
  <option value="css">CSS</option>
  <option value="java">JAVA</option>
  <option value="js">JAVASCRIPT</option>
</select><br/><br/> 


<input type="submit" value="Submit" class="button" > <br/><br/> 


</form>



</body>
</html>