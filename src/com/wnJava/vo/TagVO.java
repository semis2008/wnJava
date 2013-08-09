package com.wnJava.vo;

/**
 * Tag的VO，用于热门标签的显示
 * @author Administrator
 *
 */
public class TagVO {
	private String name;
	private String weight;
	
	public TagVO(String name,String weight){
		this.name = name;
		this.weight = weight;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getWeight() {
		return weight;
	}
	public void setWeight(String weight) {
		this.weight = weight;
	}
}
