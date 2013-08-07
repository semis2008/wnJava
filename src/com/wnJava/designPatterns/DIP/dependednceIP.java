package com.wnJava.designPatterns.DIP;

import com.wnJava.designPatterns.common.commonDP;

/**
 * 依赖倒置原则
 * @author kalor
 *
 */
public class dependednceIP extends commonDP{
	
	/*
	 * 构造函数
	 */
	dependednceIP() {
		setDp_name("DependenceInversionPrinciple_依赖倒置原则");
		setDp_info("Highlevelmodules should not depend upon low level modules.Both should depend upon" +
				" abstractions.Abstractions should not depend upon details.Details should depend upon abstractions._1.高层" +
				"模块不应该依赖于低层模块，两者都应该依赖于其抽象。2.抽象不应该依赖于细节，细节应该依赖于抽象。");
	}
}
