package com.wnJava.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;

import javax.tools.Diagnostic;
import javax.tools.DiagnosticCollector;
import javax.tools.JavaCompiler;
import javax.tools.JavaFileObject;
import javax.tools.StandardJavaFileManager;
import javax.tools.ToolProvider;

public class CodeUtil {
	
	 public static void main(String[] args) {  
	        compiler1();  
	        compiler2();  
	    }  
	  
	    /** 
	     * 使用ToolProvider类来获得JavaCompiler接口的一个默认实现。ToolProvider类提供一个getSystemJavaCompiler()方法，返回JavaCompiler接口的一个实例 
	     * 使用JavaCompiler最简单的方法是直接调用run()方法，run()方法是在Tool接口中实现的 
	     */  
	    public static void compiler1() {  
	        JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();  
	        int results = compiler.run(null, null, null, "d://MBeanDemo.java");  
	        System.out.println("Result code: " + results);  
	    }  
	  
	    /** 
	     * 这个方法利用了 StandardJavaFileManager类的优点。这个文件管理器提供了一种方法来完成普通文件的输入输出工作。 
	     * 同时在一个 DiagnosticListener实例的帮助下报告编译的诊断信息。后面将要用到的DiagnosticCollector类只是前面那个 listener的一个实现。 
	                    在确定什么东西是需要编译的之前，你需要一个文件管理器。创建一个文件管理器需要两个基本的步骤： 
	                    创建一个DiagnosticCollector然后使用getStandardFileManager()方法向JavaCompiler申请文件管理器。 
	                    传递 DiagnosticListener实例作为getStandardFileManager()方法的参数。 
	                    这个listener报告非致命性的错误，你也可以选择通过将它传递给getTask()方法与编译器共享这个listener 
	     */  
	    public static void compiler2() {  
	        JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();  
	        DiagnosticCollector<JavaFileObject> diagnostics = new DiagnosticCollector<JavaFileObject>();  
	        StandardJavaFileManager fileManager = compiler.getStandardFileManager(diagnostics, null, null);  
	        Iterable<? extends JavaFileObject> compilationUnits = fileManager.getJavaFileObjectsFromStrings(Arrays.asList("dd://MBeanDemo.java"));  
	        JavaCompiler.CompilationTask task = compiler.getTask(null, fileManager, diagnostics, null, null,  
	                                                             compilationUnits);  
	        Boolean success = task.call();  
	        for (Diagnostic diagnostic : diagnostics.getDiagnostics()) {  
	            System.out.printf("Code: %s%n" + "Kind: %s%n" + "Position: %s%n" + "Start Position: %s%n"  
	                                            + "End Position: %s%n" + "Source: %s%n" + "Message:   %s%n",  
	                                    diagnostic.getCode(), diagnostic.getKind(), diagnostic.getPosition(),  
	                                    diagnostic.getStartPosition(), diagnostic.getEndPosition(), diagnostic.getSource(),  
	                                    diagnostic.getMessage(null));  
	        }  
	        try {  
	            fileManager.close();  
	        } catch (IOException e) {  
	            e.printStackTrace();  
	        }  
	        System.out.println("Success: " + success);  
	    }  
	  
}
