<%@page contentType="text/html;charset=UTF-8" %>
<%@page pageEncoding="UTF-8" %>
<%@ page session="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
    <head>
        <META http-equiv="Content-Type" content="text/html;charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <form:form modelAttribute="uploadItem" method="post" >
            <fieldset>
                <legend>Upload Fields</legend>

                <p>
                    <form:label for="name" path="name">User Name</form:label><br/>
                    <form:input path="name"/>
                </p>
				 <p>
                    <form:label for="password" path="password">Password</form:label><br/>
                    <form:input path="password" type="password"/>
                </p>
                <p>
                    <input type="submit" />
                </p>

            </fieldset>
        </form:form>
    </body>
</html>