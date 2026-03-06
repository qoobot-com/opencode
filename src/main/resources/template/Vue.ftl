<template>
	<div class="body">
		<div class="body-head">
			<h4>${content.table.remarks}</h4>
		</div>
		<div class="body-search">
			<el-form :model="searchForm" class="form-search">
                <#list content.entity.attrs as item>
                <#if item.javaType  == "String">
                <el-form-item label="${item.remarks!}" prop="${item.field}">
                	<el-input v-model="searchForm.${item.field}" />
                </el-form-item>
                <#elseif item.javaType  ==  "Integer" || item.javaType  ==  "int" || item.javaType  ==  "Long" || item.javaType  ==  "long">
                  <#if item.field  != content.entity.primaryKeyAttr.field>
                    <el-form-item label="${item.remarks!}" prop="${item.field}">
                         <el-input-number v-model="searchForm.${item.field}" :controls="false"/>
                     </el-form-item>
                  </#if>
                 <#elseif item.javaType  ==  "Double" || item.javaType  ==  "double" || item.javaType  ==  "Float" || item.javaType  ==  "float">
                 <el-form-item label="${item.remarks!}" prop="${item.field}">
                     <el-input-number v-model="searchForm.${item.field}" :precision="2" :controls="false"/>
                 </el-form-item>
                 <#elseif item.javaType  ==  "java.util.Date">
                 <el-form-item label="${item.remarks!}" prop="${item.field}">
                      <el-date-picker v-model="searchForm.${item.field}Start" type="datetime" placeholder="起始日期" value-format='YYYY-MM-DD HH:mm:ss' style="width: 50%;"/>
                      <el-date-picker v-model="searchForm.${item.field}End" type="datetime" placeholder="截止日期"  value-format='YYYY-MM-DD HH:mm:ss' style="width: 50%;"/>
                 </el-form-item>
                 <#else>
                  <el-form-item label="${item.remarks!}" prop="${item.field}">
                         <el-select v-model="value" clearable placeholder="Select">
                            <el-option v-for="item in [{value:'Option1',label:'Option1',},{value:'Option2',label:'Option2',}]" :key="item.value" :label="item.label" :value="item.value" />
                          </el-select>
                  </el-form-item>
                  </#if>
                </#list>
				<el-form-item class="search-submit" style="width: 90%;">
					<el-button type="primary" @click="search${content.entity.className}(1, pageSize)">查询</el-button>
					<el-button @click="resetSearch()">重置</el-button>
				</el-form-item>
			</el-form>
		</div>
		<div class="body-content">
			<div class="content-head">
				<div>
					<el-button type="primary" @click="showDom('.body-add')">新增</el-button>
					<el-button type="danger" @click="batchDelete()">批量删除</el-button>
				</div>
				<el-pagination v-model:currentPage="pageNum" v-model:page-size="pageSize"
					:page-sizes="[10, 20, 50, 100]" layout="total, sizes, prev, pager, next, jumper" :total="total"
					@size-change="handlePageSizeChange" @current-change="handleCurrentPageChange" />
			</div>
			<el-table :data="table${content.entity.className}" ref="multipleTableRef" @selection-change="handleSelectionChange"
				@current-change="handleCurrentChange" v-loading="loading">
				<el-table-column type="selection" />
				<el-table-column type="index" :index="indexMethod" width="80" label="行号" />
				 <#list content.entity.attrs as item>
                 <#if item.javaType  == "java.util.Date">
                 <el-table-column prop="${item.field}" label="${item.remarks!}" :formatter='dateFormat' />
                 <#else>
                  <#if item.field  != content.entity.primaryKeyAttr.field>
                 <el-table-column prop="${item.field}" label="${item.remarks!}" show-overflow-tooltip />
                  </#if>
                 </#if>
				 </#list>
				<el-table-column fixed="right" label="操作">
					<template #default="scope">
						<el-button link type="primary" @click.prevent="showDetailRow(scope.$index)">详情
						</el-button>
						<el-button link type="primary" @click.prevent="showEditRow(scope.$index)">修改
						</el-button>
						<el-button link type="danger" @click.prevent="deleteRow(scope.$index)">删除
						</el-button>
					</template>
				</el-table-column>
			</el-table>
		</div>
		<div class="body-add">
			<el-form ref="addFormRef" :model="addForm" :rules="rules" label-width="10vw" status-icon class="form-add">
                <#list content.entity.attrs as item>
                <#if item.javaType  == "String">
                <el-form-item label="${item.remarks!}" prop="${item.field}">
                	<el-input v-model="addForm.${item.field}" />
                </el-form-item>
                <#elseif item.javaType  ==  "Integer" || item.javaType  ==  "int" || item.javaType  ==  "Long" || item.javaType  ==  "long">
                 <#if item.field  != content.entity.primaryKeyAttr.field>
                     <el-form-item label="${item.remarks!}" prop="${item.field}">
                      <el-input-number v-model="addForm.${item.field}" :controls="false"/>
                     </el-form-item>
                 </#if>
                 <#elseif item.javaType  ==  "Double" || item.javaType  ==  "double" || item.javaType  ==  "Float" || item.javaType  ==  "float">
                 <el-form-item label="${item.remarks!}" prop="${item.field}">
                     <el-input-number v-model="addForm.${item.field}" :precision="2" :controls="false"/>
                 </el-form-item>
                 <#elseif item.javaType  ==  "java.util.Date" && item.field != 'createDate' && item.field != 'updateDate'>
                 <el-form-item label="${item.remarks!}" prop="${item.field}">
                      <el-date-picker type="datetime" placeholder="${item.remarks!}" v-model="addForm.${item.field}"  value-format='YYYY-MM-DD HH:mm:ss'/>
                 </el-form-item>
                 <#elseif item.field != 'createDate' && item.field != 'updateDate'>
                  <el-form-item label="${item.remarks!}" prop="${item.field}">
                         <el-select v-model="value" clearable placeholder="Select">
                            <el-option v-for="item in [{value:'Option1',label:'Option1',},{value:'Option2',label:'Option2',}]" :key="item.value" :label="item.label" :value="item.value" />
                          </el-select>
                  </el-form-item>
                  </#if>
                </#list>
				<el-form-item class="add-submit">
					<el-button type="primary" @click="submitAdd(addFormRef)">提交</el-button>
					<el-button @click="resetForm(addFormRef)">重置</el-button>
					<el-button @click="hideDom('.body-add')">取消</el-button>
				</el-form-item>
			</el-form>
		</div>
		<div class="body-edit">
			<el-form ref="editFormRef" :model="editForm" :rules="rules" label-width="10vw" status-icon class="form-edit">
                <#list content.entity.attrs as item>
                <#if item.javaType  == "String">
                <el-form-item label="${item.remarks!}" prop="${item.field}">
                	<el-input v-model="editForm.${item.field}" />
                </el-form-item>
                <#elseif item.javaType  ==  "Integer" || item.javaType  ==  "int" || item.javaType  ==  "Long" || item.javaType  ==  "long">
                 <#if item.field  != content.entity.primaryKeyAttr.field>
                    <el-form-item label="${item.remarks!}" prop="${item.field}">
                        <el-input-number v-model="editForm.${item.field}" :controls="false"/>
                    </el-form-item>
                 </#if>
                 <#elseif item.javaType  ==  "Double" || item.javaType  ==  "double" || item.javaType  ==  "Float" || item.javaType  ==  "float">
                 <el-form-item label="${item.remarks!}" prop="${item.field}">
                     <el-input-number v-model="editForm.${item.field}" :precision="2" :controls="false"/>
                 </el-form-item>
                 <#elseif item.javaType  ==  "java.util.Date"  && item.field != 'createDate' && item.field != 'updateDate'>
                 <el-form-item label="${item.remarks!}" prop="${item.field}">
                      <el-date-picker type="datetime" placeholder="${item.remarks!}" v-model="editForm.${item.field}"  value-format='YYYY-MM-DD HH:mm:ss'/>
                 </el-form-item>
                 <#elseif item.field != 'createDate' && item.field != 'updateDate'>
                  <el-form-item label="${item.remarks!}" prop="${item.field}">
                         <el-select v-model="value" clearable placeholder="Select">
                            <el-option v-for="item in [{value:'Option1',label:'Option1',},{value:'Option2',label:'Option2',}]" :key="item.value" :label="item.label" :value="item.value" />
                          </el-select>
                  </el-form-item>
                  </#if>
                </#list>

				<el-form-item class="edit-submit">
					<el-button type="primary" @click="submitEdit(editFormRef)">提交</el-button>
					<el-button @click="resetForm(editFormRef)">重置</el-button>
					<el-button @click="hideEditRow(editFormRef)">取消</el-button>
				</el-form-item>
			</el-form>
		</div>
		<div class="body-detail">
			<el-form ref="detailFormRef" :model="editForm" label-width="10vw" class="form-detail">
                <#list content.entity.attrs as item>
                <#if item.javaType  == "String">
                <el-form-item label="${item.remarks!}" prop="${item.field}">
                	<el-input v-model="editForm.${item.field}"  disabled/>
                </el-form-item>
                <#elseif item.javaType  ==  "Integer" || item.javaType  ==  "int" || item.javaType  ==  "Long" || item.javaType  ==  "long">
                     <#if item.field  != content.entity.primaryKeyAttr.field>
                        <el-form-item label="${item.remarks!}" prop="${item.field}">
                            <el-input-number v-model="editForm.${item.field}"  disabled :controls="false"/>
                        </el-form-item>
                     </#if>
                 <#elseif item.javaType  ==  "Double" || item.javaType  ==  "double" || item.javaType  ==  "Float" || item.javaType  ==  "float">
                 <el-form-item label="${item.remarks!}" prop="${item.field}">
                     <el-input-number v-model="editForm.${item.field}" :precision="2"  disabled :controls="false"/>
                 </el-form-item>
                 <#elseif item.javaType  ==  "java.util.Date" >
                 <el-form-item label="${item.remarks!}" prop="${item.field}">
                      <el-date-picker type="datetime"  v-model="editForm.${item.field}"  disabled />
                 </el-form-item>
                 <#else>
                  <el-form-item label="${item.remarks!}" prop="${item.field}">
                         <el-select v-model="value" clearable   disabled>
                            <el-option v-for="item in [{value:'Option1',label:'Option1',},{value:'Option2',label:'Option2',}]" :key="item.value" :label="item.label" :value="item.value" />
                          </el-select>
                  </el-form-item>
                  </#if>
                </#list>
				<el-form-item class="detail-submit">
					<el-button @click="hideDetailRow(detailFormRef)">关闭</el-button>
				</el-form-item>
			</el-form>
		</div>
	</div>
</template>

<script lang="ts" setup>
import { ref, reactive } from 'template/Vue'
import { ElTable, ElMessage, ElMessageBox } from 'element-plus'
import type { FormInstance, FormRules } from 'element-plus'
import http from "@/utils/http";

/** 后端请求地址 */
const url = "/api/${content.vue.item.r_rest_full.value}/";
/** 表格 */
const table${content.entity.className} = ref();
/** 搜索表单 */
const searchForm = reactive({ <#list content.entity.attrs as item><#if item.javaType == "java.util.Date">${item.field}Start: '',${item.field}End: '',<#else>${item.field}: '',</#if></#list> });
/** 新增表单 */
const addForm = reactive({ <#list content.entity.attrs as item>${item.field}: '',</#list> });
/** 修改和详情表单 */
const editForm = reactive({ <#list content.entity.attrs as item>${item.field}: '',</#list> });
/** 当前第几页 */
const pageNum = ref(1)
/** 每页数据条数 */
const pageSize = ref(10)
/** 数据总条数 */
const total = ref(0)
/** 当前行 */
const currentRow = ref()
/** 表格数据加载 */
const loading = ref(false)
/** 传输数据对象 */
interface ${content.entity.className} {<#list content.entity.attrs as item>${item.field}: string,</#list>}

/** 新增表单组件实例 */
const addFormRef = ref<FormInstance>();
/** 修改表单组件实例 */
const editFormRef = ref<FormInstance>();
/** 详情表单组件实例 */
const detailFormRef = ref<FormInstance>();
/** 表单校验规则 */
const rules = reactive<FormRules>({
    <#list content.entity.attrs as item>
    <#if item.field  != content.entity.primaryKeyAttr.field>
    ${item.field}: [{ required: true, message: '', trigger: 'blur', },],
    </#if>
    </#list>
})
/** 表格多选实例 */
const multipleTableRef = ref<InstanceType<typeof ElTable>>()
/** 表格中被选中的行，它们的主键集合 */
const ids: Array<number> = [];

/**
 * 条件查询
 *
 * @param pageNum 当前第几页
 * @param pageSize 每页数据条数
 */
const search${content.entity.className} = async (pageNum: number, pageSize: number) => {
	http.get(url + pageNum + "/" + pageSize, searchForm)
		.then((res) => {
            if (res.data.code === 200) {
				table${content.entity.className}.value = res.data.data.list;
                total.value = res.data.data.total;
			} else {
				console.log(res);
			}
			loading.value = false;
		})
		.catch((err) => {
			console.log(err);
			loading.value = false;
		});
}

/**
 * 删除当前行
 *
 * @param index 从0开始，从上到下，当前行的序号
 */
const deleteRow = (index: number) => {
	ElMessageBox.confirm('确定删除吗？').then(() => {
		http.delete(url + table${content.entity.className}.value[index].${content.entity.primaryKeyAttr.field}, false)
			.then((res) => {
				if (res.data.code === 200) {
					ElMessage({ showClose: true, message: '删除成功', type: 'success', })
					search${content.entity.className}(1, pageSize.value);
				} else {
					ElMessage({ showClose: true, message: '删除失败', type: 'warning', })
					console.log(res);
				}
			})
			.catch((err) => {
				ElMessage({ showClose: true, message: '操作错误', type: 'error', })
				console.log(err);
			});
	})
}

/**
 * 删除选中行
 */
const batchDelete = () => {
	ElMessageBox.confirm('确定删除吗？').then(() => {
		http.delete(url, { ids: ids + '' })
			.then((res) => {
				if (res.data.code === 200) {
					ElMessage({ showClose: true, message: '删除成功', type: 'success', })
					search${content.entity.className}(1, pageSize.value);
				} else {
					ElMessage({ showClose: true, message: '删除失败', type: 'warning', })
					console.log(res);
				}
			})
			.catch((err) => {
				ElMessage({ showClose: true, message: '操作错误', type: 'error', })
				console.log(err);
			});
	})
}

/**
 * 提交新增表单
 *
 * @param formEl 新增表单实例
 */
const submitAdd = async (formEl: FormInstance | undefined) => {
	if (!formEl) return
	await formEl.validate((valid, fields) => {
		if (valid) {
			http.post(url, addForm)
				.then((res) => {
					if (res.data.code === 200) {
						hideDom('.body-add');
						resetForm(formEl);
						search${content.entity.className}(1, pageSize.value);
						ElMessage({ showClose: true, message: '新增成功', type: 'success', })
					} else {
						ElMessage({ showClose: true, message: res.data.msg, type: 'warning', })
					}
				})
				.catch((err) => {
					console.log(err);
					ElMessage({ showClose: true, message: '新增失败', type: 'error', })
				});
		} else {
			console.log('提交错误。', fields)
		}
	})
}
/**
 * 提交编辑表单
 *
 * @param formEl 编辑表单实例
 */
const submitEdit = async (formEl: FormInstance | undefined) => {
	if (!formEl) return
	await formEl.validate((valid, fields) => {
		if (valid) {
			http.put(url, editForm)
				.then((res) => {
					if (res.data.code === 200) {
						hideDom('.body-edit');
						resetForm(formEl);
						search${content.entity.className}(pageNum.value, pageSize.value);
						ElMessage({ showClose: true, message: '修改成功', type: 'success', })
					} else {
						ElMessage({ showClose: true, message: res.data.msg, type: 'warning', })
					}
				})
				.catch((err) => {
					console.log(err);
					ElMessage({ showClose: true, message: '修改失败', type: 'error', })
				});
		} else {
			console.log('error submit!', fields)
		}
	})
}
/** 加载页面时，初始化数据 */
search${content.entity.className}(pageNum.value, pageSize.value);

/** 重置搜索表单 */
const resetSearch = () => {
	Object.keys(searchForm).map(key => ((searchForm[key] = '')));
}

/** 显示编辑页面 */
const showEditRow = (index: number) => {
	Object.keys(table${content.entity.className}.value[index]).map(key =>{
    		if(key!='createDate'&&key!='updateDate'){(editForm[key] = table${content.entity.className}.value[index][key])}
    	});
	showDom('.body-edit');
}

/** 隐藏编辑页面 */
const hideEditRow = async (formEl: FormInstance | undefined) => {
	resetForm(formEl);
	hideDom('.body-edit');
}

/** 显示详情页面 */
const showDetailRow = (index: number) => {
	Object.keys(table${content.entity.className}.value[index]).map(key => ((editForm[key] = table${content.entity.className}.value[index][key])));
	showDom('.body-detail');
}

/** 隐藏详情页面 */
const hideDetailRow = async (formEl: FormInstance | undefined) => {
	resetForm(formEl);
	hideDom('.body-detail');
}

/** 处理当前表格变化事件 */
const handleCurrentChange = (val: ${content.entity.className} | undefined) => { currentRow.value = val }

/** 显示指定dom */
const showDom = (classdom) => { document.querySelector(classdom).style.display = 'flex'; }

/** 隐藏指定dom */
const hideDom = (classdom) => { document.querySelector(classdom).style.display = 'none'; }

/** 重置指定表单 */
const resetForm = (formEl: FormInstance | undefined) => {
	if (!formEl) return
	formEl.resetFields()
}

/** 当前行号 */
const indexMethod = (index: number) => { return index + 1 }

/** 处理表格选中事件 */
const handleSelectionChange = (val: ${content.entity.className}[]) => {
	ids.splice(0, ids.length); // 先清空主键数组
	val.forEach(item => { ids.push(Number(item['${content.entity.primaryKeyAttr.field}'])); }); // 然后将选中行的主键添加到ids数组中
}

/** 处理每页行数下拉框事件，10、20、50、100 */
const handlePageSizeChange = (val: number) => {
	pageSize.value = val; // 每页行数
	pageNum.value = 1; // 当前行数初始化为1
	search${content.entity.className}(pageNum.value, pageSize.value); // 刷新当前表格数据
}

/** 处理页面跳转事件*/
const handleCurrentPageChange = (val: number) => {
	pageNum.value = val; // 跳转到第几页
	search${content.entity.className}(pageNum.value, pageSize.value); // 刷新当前表格数据
}

/**  格式化表格日期类型数据 */
const dateFormat = (row, column) => {
	let data = row[column.property]
	let dtime = new Date(data)
	const year = dtime.getFullYear()
	let month = dtime.getMonth() + 1 < 10 ? '0' + (dtime.getMonth() + 1) : dtime.getMonth() + 1;
	let day = dtime.getDate() < 10 ? '0' + dtime.getDate() : dtime.getDate();
	let hour = dtime.getHours() < 10 ? '0' + dtime.getHours() : dtime.getHours();
	let minute = dtime.getMinutes() < 10 ? '0' + dtime.getMinutes() : dtime.getMinutes();
	let second = dtime.getSeconds() < 10 ? '0' + dtime.getSeconds() : dtime.getSeconds();
	return year + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second
}
</script>

<style lang="scss">
.body {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	text-decoration: none;
	margin-top: 10px;
	width: 90%;

	.form-search {
		display: flex;
		flex-flow: row wrap;
		flex-direction: row;
		align-items: center;
		justify-content: flex-start;
		text-decoration: none;
		width: 100%;

		.el-form-item {
			width: 33.3%;
			.el-form-item__label {
				width: 30%;
			}
		}

		.search-submit {
			display: flex;
			flex-direction: column;
			align-items: center;
			justify-content: center;
			text-decoration: none;
		}
	}

	.body-search,
	.body-content {
		width: 100%;
	}

	.body-add,
	.body-edit,
	.body-detail {
		position: fixed;
		background-color: rgba(0, 0, 0, 0.19);
		z-index: 10;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		display: none;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		overflow:scroll;
	}

	.form-add,
	.form-edit,
	.form-detail {
		padding: 2vw;
		background-color: #FFF;
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: flex-start;
		width: 40%;
		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	}

	.form-add>.el-form-item,
	.form-edit>.el-form-item,
	.form-detail>.el-form-item {
		width: 100%;
	}

	.content-head {
		display: flex;
		flex-direction: row;
		align-items: center;
		justify-content: space-between;
	}

	.content-head>div {
		display: flex;
		flex-direction: row;
		align-items: center;
		justify-content: space-between;
	}
}
</style>