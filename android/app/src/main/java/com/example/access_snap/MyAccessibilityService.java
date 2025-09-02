package com.example.access_snap;

import android.accessibilityservice.AccessibilityService;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.util.Log;

public class MyAccessibilityService extends AccessibilityService {

    @Override
    public void onAccessibilityEvent(AccessibilityEvent event) {
        AccessibilityNodeInfo source = event.getSource();
        if (source != null) {
            traverseNode(source);
        }
    }

    private void traverseNode(AccessibilityNodeInfo node) {
        if (node == null) return;

        if (node.getText() != null) {
            Log.d("AccessSnap", "Node text: " + node.getText().toString());
        }

        for (int i = 0; i < node.getChildCount(); i++) {
            traverseNode(node.getChild(i));
        }
    }

    @Override
    public void onInterrupt() {
        Log.d("AccessSnap", "Accessibility Service Interrupted");
    }
}
