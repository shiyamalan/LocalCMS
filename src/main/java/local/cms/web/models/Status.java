package local.cms.web.models;

public enum Status {

    Draft,
    ReadyPublish,
    Reject,
    Published,
    Archived;

    private static Status[] vals = values();
    public Status next(){
        return vals[(this.ordinal()+1) % vals.length];
    }
}
