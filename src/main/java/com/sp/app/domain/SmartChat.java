package com.sp.app.domain;

public class SmartChat {
    private long chatSeq;
    private long userSeq;
    private String sender;   // "user" or "bot"
    private String message;
    private String regDate;

    public long getChatSeq() { return chatSeq; }
    public void setChatSeq(long chatSeq) { this.chatSeq = chatSeq; }

    public long getUserSeq() { return userSeq; }
    public void setUserSeq(long userSeq) { this.userSeq = userSeq; }

    public String getSender() { return sender; }
    public void setSender(String sender) { this.sender = sender; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getRegDate() { return regDate; }
    public void setRegDate(String regDate) { this.regDate = regDate; }
}
