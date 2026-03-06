package com.bltu.generator.common;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.bltu.generator.entity.GeneratorContent;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 创建文件的 的工具
 * 
 * @author bolatu
 *
 */
public class CreateFileUtil {
	private static final Logger logger = LoggerFactory.getLogger(CreateFileUtil.class);

	private static SimpleDateFormat sdf_date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private static SimpleDateFormat sdf_year = new SimpleDateFormat("yyyy");
	/**
	 * 执行创建文件
	 * 
	 * @param content
	 *          模板所需要的上下文
	 * @param templeteName
	 *          模板的名字 示例:Entity.ftl
	 * @param projectPath
	 *          生成的项目路径 示例:D://create
	 * @param packageName
	 *          包名 示例:com.szmirren
	 * @param fileName
	 *          文件名 示例:Entity.java
	 * @param codeFormat
	 *          输出的字符编码格式 示例:UTF-8
	 * @throws Exception
	 */
	public static void createFile(GeneratorContent content, String templeteName, String projectPath, String packageName, String fileName,
                                  String codeFormat, boolean isOverride) throws Exception {
		String outputPath = projectPath + "/" + packageName.replace(".", "/") + "/";
		if (!isOverride) {
			if (Files.exists(Paths.get(outputPath + fileName))) {
				logger.debug("设置了文件存在不覆盖,文件已经存在,忽略本文件的创建");
				return;
			}
		}
		Configuration config = new Configuration(Configuration.VERSION_2_3_23);
		// 打包成jar包使用的路径
		String tempPath = Paths.get(Constant.TEMPLATE_DIR_NAME).toFile().getName();
		// 在项目运行的模板路径
		// String tempPath =
		// Thread.currentThread().getContextClassLoader().getResource(Constant.TEMPLATE_DIR_NAME).getFile();
		config.setDirectoryForTemplateLoading(new File(tempPath));
		config.setObjectWrapper(new DefaultObjectWrapper(Configuration.VERSION_2_3_23));
		config.setDefaultEncoding("utf-8");
		Template template = config.getTemplate(templeteName);
		Map<String, Object> item = new HashMap<>();
		item.put("content", content);
		Date date = new Date();
		item.put("year", sdf_year.format(date));
		item.put("date", sdf_date.format(date));
		if (!Files.exists(Paths.get(outputPath))) {
			Files.createDirectories(Paths.get(outputPath));
		}
		try (Writer writer = new OutputStreamWriter(new FileOutputStream(outputPath + fileName), codeFormat)) {
			template.process(item, writer);
		}
	}
}
