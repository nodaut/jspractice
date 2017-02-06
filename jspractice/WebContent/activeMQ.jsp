<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.*" %>
<%@page import="javax.servlet.http.*" %>
<%@page import="javax.jms.Connection"%>
<%@page import="javax.jms.ConnectionFactory"%>
<%@page import="javax.jms.Destination"%>
<%@page import="javax.jms.JMSException"%>
<%@page import="javax.jms.Message"%>
<%@page import="javax.jms.MessageConsumer"%>
<%@page import="javax.jms.MessageListener"%>
<%@page import="javax.jms.MessageProducer"%>
<%@page import="javax.jms.TextMessage"%>
<%@page import="javax.jms.Session"%>
<%@page import="javax.jms.Topic"%>
<%@page import="javax.jms.MessageListener"%>
<%@page import="org.apache.activemq.ActiveMQConnectionFactory"%>
 <%
	String query= "mytestquery2";
	String messageQueueName = "process.response";
	String topicName = "LogProcessing";
	String messageBrokerUrl = "tcp://localhost:61616";
	Session activeMQSession = null;
	MessageProducer commandProducer = null;
	MessageProducer messageProducer = null;
	ActiveMQConnectionFactory connectionFactory = new ActiveMQConnectionFactory(messageBrokerUrl);
 	Connection connection = null;
 	TextMessage txtMsg = null;
 	String result = "";
	 try {
	     connection = connectionFactory.createConnection();
	     connection.start();
	     activeMQSession = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
	
	 	// consumer 
	     Destination resultQueue = activeMQSession.createQueue(messageQueueName);
	     MessageConsumer consumer = activeMQSession.createConsumer(resultQueue);
			
	     // producer
	     Topic topic = activeMQSession.createTopic(topicName);
	     messageProducer = activeMQSession.createProducer(topic);
	     
	     //merge될 쿼리를 구분하기 위한 ID 생성
	     String queryId = String.valueOf(System.currentTimeMillis());
	     TextMessage textMessage = activeMQSession.createTextMessage(queryId+"|"+query.trim());
	     messageProducer.send(textMessage);
		
	 } catch (JMSException e) {
	 } finally {
		    activeMQSession.close();
		    connection.close();
	 }

 %>