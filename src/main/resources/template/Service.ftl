/**
 * Copyright (c) Mianlong Wu. 2022-${year}. All rights reserved.
 */

package ${content.service.classPackage};

import ${content.assist.classPackage}.Response;
import ${content.entity.classPackage}.${content.entity.className};
import java.util.List;
/**
 * ${content.table.remarks}服务接口
 * 
 * @author bltu-generator
 * @date ${date}
 */
public interface ${content.service.className} {
	/**
	 * 获得${content.entity.className}数据集,可以通过辅助工具Assist进行条件查询,如果没有条件则传入null
	 * 
	 * @return
	 */
	List<${content.entity.className}> ${content.service.item.select.value!}(${content.entity.className} value);
	
	<#if content.entity.primaryKeyAttr??>
	/**
	 * 通过${content.entity.className}的id获得${content.entity.className}对象
	 * 
	 * @param id
	 * @return
	 */
	Response ${content.service.item.selectById.value!}(${content.entity.primaryKeyAttr.javaType} id);
	<#else>
	// TODO 你的表中没有找到主键属性,你可以修改模板使用Assist来作为条件值做一些操作,比如用Assist来做删除与修改
	</#if>
	
	/**
	 * 将${content.entity.className}中属性值不为null的数据到数据库
	 * 
	 * @param value
	 * @return
	 */
	Response ${content.service.item.insertNotNull.value!}(${content.entity.className} value);
	
	<#if content.entity.primaryKeyAttr??>
	/**
	 * 通过${content.entity.className}的id更新${content.entity.className}中属性不为null的数据
	 * 
	 * @param enti
	 * @return
	 */
	Response ${content.service.item.updateNotNull.value!}(${content.entity.className} enti);
	
	/**
	 * 通过${content.entity.className}的id删除${content.entity.className}
	 * 
	 * @param id
	 * @return
	 */
	Response ${content.service.item.deleteById.value!}(${content.entity.primaryKeyAttr.javaType} id);

    /**
	 * 通过${content.entity.className}的id数组批量删除${content.entity.className}
	 *
	 * @param ids
	 * @return
	 */
	Response ${content.service.item.deleteByIds.value!}(${content.entity.primaryKeyAttr.javaType}[] ids);
	</#if>
}
