package com.smartphone.pschyo.model;

import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public abstract class AbstractDTO implements Serializable{

	public String toString()
	{
		StringBuilder sb=new StringBuilder(100);
		Method[] methods=this.getClass().getMethods();
		sb.append("[");
		sb.append("\n");
		for(Method method:methods)
		{
			if (method.getName().startsWith("get")
					&& (method.getReturnType() != null && (method
							.getReturnType() instanceof Object))
					&& method.getGenericParameterTypes().length == 0)
			{
				try {
					Object returnObj=method.invoke(this);
					sb.append(method.getName().replace("get","")+" "+returnObj);
					sb.append("\n");
				} catch (IllegalArgumentException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}	
		}
		sb.append("]");	
		return sb.toString();
	}
}
