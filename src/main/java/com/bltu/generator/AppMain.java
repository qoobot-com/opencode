package com.bltu.generator;

import java.net.URL;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;

import com.bltu.generator.controller.IndexController;
import com.bltu.generator.common.ConfigUtil;
import com.bltu.generator.common.SpringGenerator;
import com.bltu.generator.common.TemplateUtil;

import javafx.application.Application;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.stage.Stage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 程序的入口
 * 
 * @author bolatu
 *
 */
public class AppMain extends Application {
	private static Logger logger = LoggerFactory.getLogger(AppMain.class.getName());
	/** 国际化控件的文字 */
	public static Map<String, StringProperty> LANGUAGE = new HashMap<>();

	@Override
	public void start(Stage primaryStage) throws Exception {
		ConfigUtil.existsConfigDB();// 创建配置文件
		// LanguageUtil.existsTemplate();// 国际化文件夹创建
		TemplateUtil.existsTemplate();// 创建模板
		loadLanguage(Locale.getDefault());// 加载本地语言资源
		// loadLanguage(Locale.ENGLISH);// 加载英语资源

		URL url = Thread.currentThread().getContextClassLoader().getResource("FXML/Index.fxml");
		FXMLLoader fxmlLoader = new FXMLLoader(url);
		Parent root = fxmlLoader.load();
		primaryStage.setResizable(true);
		primaryStage.setTitle(SpringGenerator.NAME_VERSION);
		primaryStage.getIcons().add(new Image("image/icon.png"));
		primaryStage.setScene(new Scene(root));
		primaryStage.show();
		IndexController controller = fxmlLoader.getController();
		controller.setPrimaryStage(primaryStage);
	}


	/**
	 * 根据Locale加载控件文本
	 * 
	 * @param locale
	 */
	public static void loadLanguage(Locale locale) {
		ResourceBundle resourceBundle = ResourceBundle.getBundle("config/language/language",locale);
		Enumeration<String> keys = resourceBundle.getKeys();
		while (keys.hasMoreElements()) {
			String key = keys.nextElement();
			if (LANGUAGE.get(key) == null) {
				LANGUAGE.put(key, new SimpleStringProperty(resourceBundle.getString(key)));
			} else {
				LANGUAGE.get(key).set(resourceBundle.getString(key));
			}
		}
	}

	public static void main(String[] args) {
		try {
			logger.debug("运行Spring-Generator...");
			launch(args);
			logger.debug("关闭Spring-Generator!!!");
		} catch (Exception e) {
			logger.error("运行Spring-Generator-->失败:", e);
		}
	}
}