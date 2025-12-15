package client;

public final class ApiResponse {
    public final int status;
    public final String body;

    public ApiResponse(int status, String body) {
        this.status = status;
        this.body = body;
    }

    public boolean is2xx() {
        return status >= 200 && status < 300;
    }
}
