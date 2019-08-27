package com.bylz.quantumCloud.education.controller;

/**
 * JSON 数据请求返回内容
 *
 */
public class ResponseData {
	public static final ResponseData SUCCESS_NO_DATA = new ResponseDataWarpper(true,"操作成功");
	public static final ResponseData FAILED_NO_DATA = new ResponseDataWarpper(false,"操作失败");
	
	private boolean success;
	private Object message;
	private String requestURI;
	private String execptionTrace;
	private Object obj;
	private int code;
	private String memo;
	public ResponseData(boolean success) {
		this(success, null, null);
	}
	
	public ResponseData(boolean success, Object message) {
		this(success, null, message);
	}
	
	public ResponseData(boolean success, String type, Object message) {
		this.success = success;
		this.message = message;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public Object getMessage() {
		return message;
	}

	public void setMessage(Object message) {
		this.message = message;
	}


	public String getRequestURI() {
		return requestURI;
	}

	public void setRequestURI(String requestURI) {
		this.requestURI = requestURI;
	}

	public String getExecptionTrace() {
		return execptionTrace;
	}

	public void setExecptionTrace(String execptionTrace) {
		this.execptionTrace = execptionTrace;
	}

    public Object getObj()
    {
        return obj;
    }

    public void setObj(Object obj)
    {
        this.obj = obj;
    }
    
    public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	static class ResponseDataWarpper extends ResponseData{

        public ResponseDataWarpper(boolean success)
        {
            super(success);
        }

        public ResponseDataWarpper(boolean success, String message)
        {
            super(success,message);
        }
        
        public void setMessage(Object message) {
            throw new RuntimeException();
        }

        public void setRequestURI(String requestURI) {
            throw new RuntimeException();
        }

        public void setExecptionTrace(String execptionTrace) {
            throw new RuntimeException();
        }

        public void setObj(Object obj)
        {
            throw new RuntimeException();
        }

    }
}
