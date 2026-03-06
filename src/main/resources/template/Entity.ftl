/**
 * Copyright (c) Mianlong Wu. 2022-${year}. All rights reserved.
 */

package ${content.entity.classPackage};

import com.alibaba.fastjson2.JSONObject;
import com.alibaba.fastjson2.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;
/**
 * ${content.table.remarks}实体类
 * 
 * @author bltu-generator
 * @date ${date}
 */
public class ${content.entity.className} {
	<#list content.entity.attrs as item>
	<#if item.javaType == "java.util.Date">

    /**${item.remarks!}*/
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd HH:mm:ss")
    private ${item.javaType} ${item.field};

     /**${item.remarks!}起*/
     @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	 @JSONField(format = "yyyy-MM-dd HH:mm:ss")
	 @JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd HH:mm:ss")
     private ${item.javaType} ${item.field}Start;

     /**${item.remarks!}止*/
     @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	 @JSONField(format = "yyyy-MM-dd HH:mm:ss")
	 @JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd HH:mm:ss")
     private ${item.javaType} ${item.field}End;
    <#else>
	/**${item.remarks!}*/
	private ${item.javaType} ${item.field};
	</#if>
	</#list>
	/**
	 * 实例化
	 */
	public ${content.entity.className!}() {
		super();
	}

	/**
	 * 将当前对象转换为JSONObject
	 * 
	 * @return
	 */
	public JSONObject toJson() {
		JSONObject result = new JSONObject();
		<#list content.entity.attrs as item> 
		<#if item.javaType == "int" || item.javaType == "double" || item.javaType == "char" || item.javaType == "long"  || item.javaType == "boolean" >
		result.put("${item.field}",this.${item.fget}());
		<#else>
		if (this.${item.fget}() != null) {
			result.put("${item.field}",this.${item.fget}());
		}
		</#if>
		</#list>
		return result;
	}
	
	<#list content.entity.attrs as item> 
	<#if item.javaType == "java.util.Date">
	/**
	 * 获取${item.field}起
	 *
	 * @return
	 */
	public ${item.javaType} ${item.fget}() {
		return ${item.field};
	}

	/**
	 * 设置${item.field}起
	 *
	 * @param ${item.field}
	 */
	public void ${item.fset}(${item.javaType} ${item.field}) {
		this.${item.field} = ${item.field};
	}

	/**
	 * 获取${item.field}起
	 *
	 * @return
	 */
	public ${item.javaType} ${item.fget}Start() {
		return ${item.field}Start;
	}

	/**
	 * 设置${item.field}起
	 *
	 * @param ${item.field}Start
	 */
	public void ${item.fset}Start(${item.javaType} ${item.field}Start) {
		this.${item.field}Start = ${item.field}Start;
	}

    /**
	 * 获取${item.field}止
	 *
	 * @return
	 */
	public ${item.javaType} ${item.fget}End() {
		return ${item.field}End;
	}

	/**
	 * 设置${item.field}止
	 *
	 * @param ${item.field}End
	 */
	public void ${item.fset}End(${item.javaType} ${item.field}End) {
		this.${item.field}End = ${item.field}End;
	}
    <#else>
	/**
	 * 获取${item.field}
	 *
	 * @return
	 */
	public ${item.javaType} ${item.fget}() {
		return ${item.field};
	}

	/**
	 * 设置${item.field}
	 * 
	 * @param ${item.field}
	 */
	public void ${item.fset}(${item.javaType} ${item.field}) {
		this.${item.field} = ${item.field};
	}
	</#if>
	</#list>

}
