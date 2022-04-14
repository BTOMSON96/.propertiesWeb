<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import= "java.io.* ,java.util.*, controller.FindKeysController, java.util.regex.* " %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Find Keys</title>

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
  <h3>Unused Keys</h3> 
</div> <br>

<%

//read app properties file
String location = request.getParameter("location");
File appProperties = new File(location);
FindKeysController controller = new FindKeysController();
Map<String, String> map = new HashMap<String, String>();


//read files in directory
String directory = request.getParameter("directory");
File directoryPath = new File(directory);
ArrayList<File> files  = new ArrayList<File>();
String[] extension = request.getParameterValues("extensions");


ArrayList<String> dkeysInDir= new ArrayList<String>();
ArrayList<String> skeysInDir = new ArrayList<String>();
ArrayList<String> merge = new ArrayList<String>();

ArrayList<String> unusedKeys = new ArrayList<String>();
int results = 0;
//String content =null;
//read file
if(appProperties.isFile()){
	 List<String> list = controller.readAppProperties(location);
	 
	 
	 for(String splitFile : list) {
		
			  String[] parts = splitFile.split("[=:_]+"); 
			  
			  String keys = parts[0].trim();
	          String values = parts[1].trim();
	  
	          map.put(keys, values);
	          
	   }
 if(directoryPath.exists() && directoryPath.isDirectory() && extension !=null){
	 File allFilesInDir[] = directoryPath.listFiles();
	 
	 files = controller.searchFiles(allFilesInDir, extension,  files);
	 
	
	 

 
	
   

%>


<table style="width:100%; table-layout:fixed">
<tbody>
     <tr>
        <th>Keys</th>
     </tr>
     
<%
for (int i =0; i < files.size(); i++)
{

 StringBuilder stringBuilder = new StringBuilder();
 
 // Reading  files on local directory
 FileReader fr = new FileReader(files.get(i).getAbsoluteFile());
	 try {
		 
       
         BufferedReader br = new BufferedReader(fr);

         String line;

         // Reading the file till we get the null
         while ((line = br.readLine()) != null) {
        	 stringBuilder.append(line);
         }

         // AtLast converting into the string
         String result =  stringBuilder.toString();
         br.close();
         
         
  
         //get any string with double quotes on the results
         String strContent = result;
         
         String strPattern =  "\"([^\"]*)\"";
         
         Pattern pattern = Pattern.compile(strPattern);
         Matcher matcher = pattern.matcher(strContent);
         
         while( matcher.find()) {
          
             dkeysInDir.add(matcher.group(1));
         }
         
         
         

         //get any string with single quotes from the results
         String singlePattern = "'([^']*)'";
         
         Pattern spattern = Pattern.compile(singlePattern );
         Matcher smatcher = spattern.matcher(strContent );
         
         while( smatcher.find() ) {
            
             skeysInDir.add(smatcher.group(1));
         }
     
         
         //merge both List to one arrayList
         merge.addAll(dkeysInDir);
         merge.addAll(skeysInDir);
         
       
         
	 }// Catch block to handle exceptions
     catch (Exception ex) {
         out.println(ex.getMessage());
     }
}
%>  
<%
//System.out.println("INFO: Getting unused keys..");
for (int i =0; i < map.keySet().size(); i++)
{    
	 
	if(!merge.contains(map.keySet().toArray()[i])){
		
		unusedKeys.add(map.keySet().toArray()[i].toString());
	}
	
}	
	
%> 
<%


for (int i =0; i < unusedKeys.size(); i++)
{    
	results++;
	
%> 
	<tr>
        <td><%=unusedKeys.get(i)%></td>
     </tr>



<%
	
}

%>
</tbody>
</table><br>

<label >Number of unused keys: <%=results%></label><br></br>
<input type="submit" value="BACK" class="button" onclick="goBack()"> <input type="submit" value="SAVE" class="button" onclick="save()"> <br/><br/> 





   <script>

   
   //go back
    function goBack() {
        window.history.back()
    }

   
    function save(){     
<%
FileWriter writer = new FileWriter("unused.txt"); 
for(String str: unusedKeys) {
  writer.write(str + System.lineSeparator());
}
%>
alert("Keys saved succesfully");
<%
writer.close();
%>

        }

    
    </script>
    
    
 
<%
//file doesnt exist
 }else{
	 out.println("Directory doesnt exist");
 }
}else{
	
	out.println("File doesnt exist");
}
%>   
</body>
</html>