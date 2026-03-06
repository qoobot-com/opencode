/**
 * Copyright (c) Mianlong Wu. 2022-${year}. All rights reserved.
 */

package ${content.serviceImpl.classPackage};

import ${content.assist.classPackage}.Response;
import ${content.service.classPackage}.${content.service.className};
import ${content.dao.classPackage}.${content.dao.className};
import ${content.entity.classPackage}.${content.entity.className};

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * ${content.table.remarks}服务接口的实现类
 * 
 * @author bltu-generator
 * @date ${date}
 */
@Service
public class ${content.serviceImpl.className} implements ${content.service.className} {
	private final Logger logger = LogManager.getLogger(this.getClass());

	@Autowired
	private ${content.dao.className} ${content.dao.className?uncap_first};

	@Override
	public List<${content.entity.className}> ${content.service.item.select.value!}(${content.entity.className} value) {
		//TODO这里可以做通过Assist做添加查询
		List<${content.entity.className}> result = ${content.dao.className?uncap_first}.${content.dao.item.selectByObj.value!}(value);
		if (logger.isDebugEnabled()) {
			logger.debug("执行获取${content.entity.className}数据集-->结果:", result);
		}
		return result;
	}
	<#if content.entity.primaryKeyAttr??>
	@Override
	public Response ${content.service.item.selectById.value!}(${content.entity.primaryKeyAttr.javaType} id) {
		if (id == null) {
			if (logger.isDebugEnabled()) {
				logger.debug("执行通过${content.entity.className}的id获得${content.entity.className}对象-->失败:id不能为空");
			}
			return Response.error();
		}
		${content.entity.className} result = ${content.dao.className?uncap_first}.${content.dao.item.selectById.value!}(id);
		if (logger.isDebugEnabled()) {
			logger.debug("执行通过${content.entity.className}的id获得${content.entity.className}对象-->结果:", result);
		}
		return Response.success(result);
	}
	</#if>

	@Override
	public Response ${content.service.item.insertNotNull.value!}(${content.entity.className} value) {
		if (value == null) {
			if (logger.isDebugEnabled()) {
				logger.debug("执行将${content.entity.className}中属性值不为null的数据保存到数据库-->失败:对象不能为空");
			}
			return Response.error();
		}
		<#if content.entity.cantNullAttrs?exists>
		if(<#list content.entity.cantNullAttrs as item>value.${item.fget}() == null <#if item?has_next>||</#if> </#list>){
			if (logger.isDebugEnabled()) {
				logger.debug("执行将${content.entity.className}中属性值不为null的数据保存到数据库-->失败:存在不能为空的空值");
			}
			return Response.error();
		}
		</#if>
		int result = ${content.dao.className?uncap_first}.${content.dao.item.insertNotNull.value!}(value);
		if (logger.isDebugEnabled()) {
			logger.debug("执行将${content.entity.className}中属性值不为null的数据保存到数据库-->结果:", result);
		}
		return Response.success(result);
	}
	<#if content.entity.primaryKeyAttr??>
	@Override
	public Response ${content.service.item.updateNotNull.value!}(${content.entity.className} value) {
		if (value == null) {
			if (logger.isDebugEnabled()) {
				logger.debug("执行通过${content.entity.className}的id更新${content.entity.className}中属性不为null的数据-->失败:对象为null");
			}
			return Response.error();
		}
		int result = ${content.dao.className?uncap_first}.${content.dao.item.updateNotNullById.value!}(value);
		if (logger.isDebugEnabled()) {
			logger.debug("执行通过${content.entity.className}的id更新${content.entity.className}中属性不为null的数据-->结果:", result);
		}
		return Response.success(result);
	}

	@Override
	public Response ${content.service.item.deleteById.value!}(${content.entity.primaryKeyAttr.javaType} id) {
		if (id == null) {
			if (logger.isDebugEnabled()) {
				logger.debug("执行通过${content.entity.className}的id删除${content.entity.className}-->失败:id不能为空");
			}
			return Response.error();
		}
		int result = ${content.dao.className?uncap_first}.${content.dao.item.deleteById.value!}(id);
		if (logger.isDebugEnabled()) {
			logger.debug("执行通过${content.entity.className}的id删除${content.entity.className}-->结果:", result);
		}
		return Response.success(result);
	}

	@Override
	public Response ${content.service.item.deleteByIds.value!}(${content.entity.primaryKeyAttr.javaType}[] ids) {
		if (ids == null || ids.length == 0) {
			if (logger.isDebugEnabled()) {
				logger.debug("执行通过${content.entity.className}的id删除${content.entity.className}-->失败:id不能为空");
			}
			return Response.error();
		}
		int result = ${content.dao.className?uncap_first}.${content.dao.item.deleteByIds.value!}(ids);
		if (logger.isDebugEnabled()) {
			logger.debug("执行通过${content.entity.className}的id删除${content.entity.className}-->结果:", result);
		}
		return Response.success(result);
	}
	</#if>


}