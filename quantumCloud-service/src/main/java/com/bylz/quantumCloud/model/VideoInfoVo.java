package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.List;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/3/11
 */
public class VideoInfoVo implements Serializable {

    private static final long serialVersionUID = -2322130320575875370L;

    private int vid;//视频id

    private String img;//

    private String brief;

    private String title;

    private String url;//超清视频url

    private int view;

    private String lectureurl;//讲义url
    
    private int block;

    private String video_url;

    private List<ExamQuestionSet> examQuestionSetList;

    private String video_time;

    private int toplevel;

    private int free;

    private String HDUrl;//高清视频URL

    public int getVid() {
        return vid;
    }

    public void setVid(int vid) {
        this.vid = vid;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getBrief() {
        return brief;
    }

    public void setBrief(String brief) {
        this.brief = brief;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getView() {
        return view;
    }

    public void setView(int view) {
        this.view = view;
    }

    public String getLectureurl() {
        return lectureurl;
    }

    public void setLectureurl(String lectureurl) {
        this.lectureurl = lectureurl;
    }

	public int getBlock() {
		return block;
	}

	public void setBlock(int block) {
		this.block = block;
	}

    public String getVideo_url() {
        return video_url;
    }

    public void setVideo_url(String video_url) {
        this.video_url = video_url;
    }

    public List<ExamQuestionSet> getExamQuestionSetList() {
        return examQuestionSetList;
    }

    public void setExamQuestionSetList(List<ExamQuestionSet> examQuestionSetList) {
        this.examQuestionSetList = examQuestionSetList;
    }

    public String getVideo_time() {
        return video_time;
    }

    public void setVideo_time(String video_time) {
        this.video_time = video_time;
    }

    public int getToplevel() {
        return toplevel;
    }

    public void setToplevel(int toplevel) {
        this.toplevel = toplevel;
    }

    public int getFree() {
        return free;
    }

    public void setFree(int free) {
        this.free = free;
    }

    public String getHDUrl() {
        return HDUrl;
    }

    public void setHDUrl(String HDUrl) {
        this.HDUrl = HDUrl;
    }
}
