package com.example.access_snap;

import android.accessibilityservice.AccessibilityService;
import android.util.Log;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;

public class MyAccessibilityService extends AccessibilityService {
    private static final String TAG = "AccessSnapService";

    @Override
    public void onAccessibilityEvent(AccessibilityEvent event) {
        AccessibilityNodeInfo rootNode = getRootInActiveWindow();
        if (rootNode != null) {
            logNodeText(rootNode);
            rootNode.recycle();
        }
    }

    private void logNodeText(AccessibilityNodeInfo node) {
        if (node == null) {
            return;
        }
        if (node.getText() != null && !node.getText().toString().isEmpty()) {
            Log.d(TAG, "TEXT: " + node.getText());
        }
        for (int i = 0; i < node.getChildCount(); i++) {
            logNodeText(node.getChild(i));
        }
    }

    @Override
    public void onInterrupt() {
        Log.d(TAG, "Service interrupted");
    }

    @Override
    protected void onServiceConnected() {
        super.onServiceConnected();
        Log.d(TAG, "Service connected");
    }
}
