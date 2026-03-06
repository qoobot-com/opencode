/**
 * Copyright (c) Mianlong Wu. 2022-${year}. All rights reserved.
 */

package ${content.controller.classPackage};

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import ${content.assist.classPackage}.Response;
import ${content.service.classPackage}.${content.service.className};
import ${content.entity.classPackage}.${content.entity.className};
import java.util.List;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
/**
 * ${content.table.remarks}API接口服务
 * 
 * @author bltu-generator
 * @date ${date}
 */
@RestController
@RequestMapping("${content.controller.item.r_rest_full.value}")
public class ${content.controller.className} {

	/** ${content.entity.className}Service服务 */
	@Autowired
	private ${content.service.className} ${content.service.className?uncap_first};
	
	/**
	 * ${content.controller.item.f_find.describe!}
	 *
	 * @param value
	 * @return Response
	 */
	@GetMapping(name = "${content.controller.item.f_find.describe!}" , value = "${content.controller.item.r_find.value}{pageNum}/{pageSize}", produces = {"application/json;charset=UTF-8"})
	public Response ${content.controller.item.f_find.value}(@PathVariable("pageNum") Integer pageNum,@PathVariable("pageSize") Integer pageSize, ${content.entity.className} value) {
	        PageHelper.startPage(pageNum, pageSize);
    		List<${content.entity.className}> list = ${content.service.className?uncap_first}.${content.service.item.select.value}(value);
    		PageInfo<${content.entity.className}> pageInfo = new PageInfo<>(list);
		return Response.success(pageInfo);
	}
	
	<#if content.entity.primaryKeyAttr??>
	/**
	 * ${content.controller.item.f_getById.describe!}
	 *
	 * @param id
	 * @return Response
	 */
	@GetMapping(name = "${content.controller.item.f_getById.describe!}" ,value = "${content.controller.item.r_getById.value}", produces = {"application/json;charset=UTF-8"})
	public Response ${content.controller.item.f_getById.value}(@PathVariable(name="id") ${content.entity.primaryKeyAttr.javaType} id) {
		return ${content.service.className?uncap_first}.${content.service.item.selectById.value!}(id);
	}
	</#if>
	
	/**
	 * ${content.controller.item.f_saveNotNull.describe!}
	 *
	 * @param value
	 * @return Response
	 */
	@PostMapping(name = "${content.controller.item.f_saveNotNull.describe!}" ,value = "${content.controller.item.r_saveNotNull.value!}", produces = {"application/json;charset=UTF-8"})
	public Response ${content.controller.item.f_saveNotNull.value!}(@RequestBody ${content.entity.className} value) {
		return ${content.service.className?uncap_first}.${content.service.item.insertNotNull.value!}(value);
	}
	
	<#if content.entity.primaryKeyAttr??>
	/**
	 * ${content.controller.item.f_updateNotNull.describe!}
	 *
	 * @param value
	 * @return Response
	 */
	@PutMapping(name = "${content.controller.item.f_updateNotNull.describe!}" ,value = "${content.controller.item.r_updateNotNull.value!}", produces = {"application/json;charset=UTF-8"})
	public Response ${content.controller.item.f_updateNotNull.value!}(@RequestBody ${content.entity.className} value) {
		return ${content.service.className?uncap_first}.${content.service.item.updateNotNull.value!}(value);
	}

	/**
	 * ${content.controller.item.f_deleteById.describe!}
	 *
	 * @param id
	 * @return Response
	 */
	@DeleteMapping(name = "${content.controller.item.f_deleteById.describe!}" ,value = "${content.controller.item.r_deleteById.value!}", produces = {"application/json;charset=UTF-8"})
	public Response ${content.controller.item.f_deleteById.value!}(@PathVariable(name="id") ${content.entity.primaryKeyAttr.javaType} id) {
		return ${content.service.className?uncap_first}.${content.service.item.deleteById.value!}(id);
	}

	/**
	 * ${content.controller.item.f_deleteByIds.describe!}
	 *
	 * @param ids
	 * @return Response
	 */
	@DeleteMapping(name = "${content.controller.item.f_deleteByIds.describe!}" ,value = "${content.controller.item.r_deleteByIds.value!}", produces = {"application/json;charset=UTF-8"})
	public Response ${content.controller.item.f_deleteByIds.value!}(${content.entity.primaryKeyAttr.javaType}[] ids) {
		return ${content.service.className?uncap_first}.${content.service.item.deleteByIds.value!}(ids);
	}

	</#if>
}
