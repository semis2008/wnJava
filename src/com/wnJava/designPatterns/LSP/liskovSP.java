package com.wnJava.designPatterns.LSP;

import com.wnJava.designPatterns.common.commonDP;

/**
 * 里氏替换原则
 * @author kalor
 *
 */
public class liskovSP extends commonDP{
	/*
	 * 构造函数
	 */
	liskovSP() {
		setDp_name("里氏替换原则_LiskovSubstitutionPrinciple");
		setDp_info("Functions that user pointers or references to base classes must be able to " +
				"user objects of derived classes without knowing it._所有使用基类的地方必须能够透明的是同其子类的对象。");
	}
}
