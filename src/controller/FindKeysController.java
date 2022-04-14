package controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class FindKeysController {

	
	  //read file
		public List<String> readAppProperties(String fileName) {
			List<String> lines = Collections.emptyList();
		    try
		    {
		      lines = Files.readAllLines(Paths.get(fileName), StandardCharsets.UTF_8);
		    }
		 
		    catch (IOException e)
		    {
		      e.printStackTrace();
		    }
		    return lines;
		}
		
		public  ArrayList<File>searchFiles(File file[],  String[] extension,  ArrayList<File> listExtension)  {


			  
			   if(file != null) {
			   for (File splitFiles : file) {
			        	
			        String parts = splitFiles.getName();
			        	
			          for(String ext: extension) {
			        	   if(parts.endsWith(ext)) {
			        	  listExtension.add(splitFiles);
			        	  
			        	 }
			          }
		     searchFiles(splitFiles.listFiles(), extension, listExtension);
			  }
			   
			   }
			return listExtension;
		}
}
