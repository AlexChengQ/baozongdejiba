package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.List;

public class ReadBook implements Serializable{

	private static final long serialVersionUID = 3057961468447372457L;
	private int id;
	private String title;
	private String author;
	private String translator;
	private String context;
	private String image;
	private String publisher;
	private String submitted;
	private String joriginallyannounced;
	private String site;
	private String type;
	private List<String> authorList;
	private String version;
	public String getTranslator() {
		return translator;
	}
	public void setTranslator(String translator) {
		this.translator = translator;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getSubmitted() {
		return submitted;
	}
	public void setSubmitted(String submitted) {
		this.submitted = submitted;
	}
	public String getJoriginallyannounced() {
		return joriginallyannounced;
	}
	public void setJoriginallyannounced(String joriginallyannounced) {
		this.joriginallyannounced = joriginallyannounced;
	}
	public String getSite() {
		return site;
	}
	public void setSite(String site) {
		this.site = site;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getContext() {
		return context;
	}

	public void setContext(String context) {
		this.context = context;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public List<String> getAuthorList() {
		return authorList;
	}

	public void setAuthorList(List<String> authorList) {
		this.authorList = authorList;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}
}
