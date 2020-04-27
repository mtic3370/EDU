<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//공통으로 사용할 변수 혹은 메소드를 정의
	SimpleDateFormat simple = new SimpleDateFormat("yyyy-MM-dd");
	String todayStr = simple.format(new Date());
%>