package africa.shulesoft.attendance.models;

import org.jetbrains.annotations.NotNull;

import java.util.Arrays;

public class Finger {
    public Finger() {
    }

    public String userId;
    public byte[] finger;

    public String getUserId() {
        return this.userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public byte[] getFinger() {
        return this.finger;
    }

    public void setFinger(byte[] finger) {
        this.finger = finger;
    }

    @NotNull
    @Override
    public String toString() {
        return "{\"userId\": " + getUserId() + ",\"finger\": \"" + Arrays.toString(getFinger()) + "\"}";
    }
}
