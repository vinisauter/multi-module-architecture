// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package com.example.structural.flutter;

import android.app.Activity;
import android.content.Context;
import android.content.pm.ActivityInfo;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.content.res.XmlResourceParser;
import android.os.Bundle;

import androidx.annotation.NonNull;

import org.json.JSONArray;
import org.xmlpull.v1.XmlPullParserException;

import java.io.IOException;

import io.flutter.embedding.engine.loader.FlutterApplicationInfo;

/** Loads application information given a Context. */
public final class CustomApplicationInfoLoader {
    // XML Attribute keys supported in AndroidManifest.xml
    public static final String PUBLIC_AOT_SHARED_LIBRARY_NAME =
            CustomFlutterLoader.class.getName() + '.' + CustomFlutterLoader.AOT_SHARED_LIBRARY_NAME;
    public static final String PUBLIC_VM_SNAPSHOT_DATA_KEY =
            CustomFlutterLoader.class.getName() + '.' + CustomFlutterLoader.VM_SNAPSHOT_DATA_KEY;
    public static final String PUBLIC_ISOLATE_SNAPSHOT_DATA_KEY =
            CustomFlutterLoader.class.getName() + '.' + CustomFlutterLoader.ISOLATE_SNAPSHOT_DATA_KEY;
    public static final String PUBLIC_FLUTTER_ASSETS_DIR_KEY =
            CustomFlutterLoader.class.getName() + '.' + CustomFlutterLoader.FLUTTER_ASSETS_DIR_KEY;
    public static final String NETWORK_POLICY_METADATA_KEY = "io.flutter.network-policy";
    public static final String PUBLIC_AUTOMATICALLY_REGISTER_PLUGINS_METADATA_KEY =
            "io.flutter." + CustomFlutterLoader.AUTOMATICALLY_REGISTER_PLUGINS_KEY;

    @NonNull
    private static ApplicationInfo getApplicationInfo(@NonNull Context applicationContext) {
        try {
            return applicationContext
                    .getPackageManager()
                    .getApplicationInfo(applicationContext.getPackageName(), PackageManager.GET_META_DATA);
        } catch (PackageManager.NameNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    @NonNull
    private static ActivityInfo getActivityInfo(@NonNull Context applicationContext) {
        try {
            return applicationContext
                    .getPackageManager()
                    .getActivityInfo(((Activity)applicationContext).getComponentName(), PackageManager.GET_META_DATA);
        } catch (PackageManager.NameNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    private static String getString(Bundle metadata, String key) {
        if (metadata == null) {
            return null;
        }
        return metadata.getString(key, null);
    }

    private static boolean getBoolean(Bundle metadata, String key, boolean defaultValue) {
        if (metadata == null) {
            return defaultValue;
        }
        return metadata.getBoolean(key, defaultValue);
    }

    private static String getNetworkPolicy(ApplicationInfo appInfo, Context context) {
        // We cannot use reflection to look at networkSecurityConfigRes because
        // Android throws an error when we try to access fields marked as This member is not intended
        // for public use, and is only visible for testing..
        // Instead we rely on metadata.
        Bundle metadata = appInfo.metaData;
        if (metadata == null) {
            return null;
        }

        int networkSecurityConfigRes = metadata.getInt(NETWORK_POLICY_METADATA_KEY, 0);
        if (networkSecurityConfigRes <= 0) {
            return null;
        }

        JSONArray output = new JSONArray();
        try {
            XmlResourceParser xrp = context.getResources().getXml(networkSecurityConfigRes);
            xrp.next();
            int eventType = xrp.getEventType();
            while (eventType != XmlResourceParser.END_DOCUMENT) {
                if (eventType == XmlResourceParser.START_TAG) {
                    if (xrp.getName().equals("domain-config")) {
                        parseDomainConfig(xrp, output, false);
                    }
                }
                eventType = xrp.next();
            }
        } catch (IOException | XmlPullParserException e) {
            return null;
        }
        return output.toString();
    }

    private static void parseDomainConfig(
            XmlResourceParser xrp, JSONArray output, boolean inheritedCleartextPermitted)
            throws IOException, XmlPullParserException {
        boolean cleartextTrafficPermitted =
                xrp.getAttributeBooleanValue(
                        null, "cleartextTrafficPermitted", inheritedCleartextPermitted);
        while (true) {
            int eventType = xrp.next();
            if (eventType == XmlResourceParser.START_TAG) {
                if (xrp.getName().equals("domain")) {
                    // There can be multiple domains.
                    parseDomain(xrp, output, cleartextTrafficPermitted);
                } else if (xrp.getName().equals("domain-config")) {
                    parseDomainConfig(xrp, output, cleartextTrafficPermitted);
                } else {
                    skipTag(xrp);
                }
            } else if (eventType == XmlResourceParser.END_TAG) {
                break;
            }
        }
    }

    private static void skipTag(XmlResourceParser xrp) throws IOException, XmlPullParserException {
        String name = xrp.getName();
        int eventType = xrp.getEventType();
        while (eventType != XmlResourceParser.END_TAG || xrp.getName() != name) {
            eventType = xrp.next();
        }
    }

    private static void parseDomain(
            XmlResourceParser xrp, JSONArray output, boolean cleartextPermitted)
            throws IOException, XmlPullParserException {
        boolean includeSubDomains = xrp.getAttributeBooleanValue(null, "includeSubdomains", false);
        xrp.next();
        if (xrp.getEventType() != XmlResourceParser.TEXT) {
            throw new IllegalStateException("Expected text");
        }
        String domain = xrp.getText().trim();
        JSONArray outputArray = new JSONArray();
        outputArray.put(domain);
        outputArray.put(includeSubDomains);
        outputArray.put(cleartextPermitted);
        output.put(outputArray);
        xrp.next();
        if (xrp.getEventType() != XmlResourceParser.END_TAG) {
            throw new IllegalStateException("Expected end of domain tag");
        }
    }

    /**
     * Initialize our Flutter config values by obtaining them from the manifest XML file, falling back
     * to default values.
     */
    @NonNull
    public static FlutterApplicationInfo load(@NonNull Context applicationContext) {
        ApplicationInfo appInfo = getApplicationInfo(applicationContext);
        if (applicationContext instanceof Activity) {
            ActivityInfo activityInfo = getActivityInfo(applicationContext);

            return new FlutterApplicationInfo(
                    getString(activityInfo.metaData, PUBLIC_AOT_SHARED_LIBRARY_NAME),
                    getString(appInfo.metaData, PUBLIC_VM_SNAPSHOT_DATA_KEY),
                    getString(appInfo.metaData, PUBLIC_ISOLATE_SNAPSHOT_DATA_KEY),
                    getString(activityInfo.metaData, PUBLIC_FLUTTER_ASSETS_DIR_KEY),
                    getNetworkPolicy(appInfo, applicationContext),
                    appInfo.nativeLibraryDir,
                    getBoolean(appInfo.metaData, PUBLIC_AUTOMATICALLY_REGISTER_PLUGINS_METADATA_KEY, true));
        }

        return new FlutterApplicationInfo(
                getString(appInfo.metaData, PUBLIC_AOT_SHARED_LIBRARY_NAME),
                getString(appInfo.metaData, PUBLIC_VM_SNAPSHOT_DATA_KEY),
                getString(appInfo.metaData, PUBLIC_ISOLATE_SNAPSHOT_DATA_KEY),
                getString(appInfo.metaData, PUBLIC_FLUTTER_ASSETS_DIR_KEY),
                getNetworkPolicy(appInfo, applicationContext),
                appInfo.nativeLibraryDir,
                getBoolean(appInfo.metaData, PUBLIC_AUTOMATICALLY_REGISTER_PLUGINS_METADATA_KEY, true));
    }
}