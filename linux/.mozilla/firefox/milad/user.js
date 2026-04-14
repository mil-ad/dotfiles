user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("full-screen-api.warning.timeout", -1);
user_pref("full-screen-api.transition-duration.leave", "0 0");
user_pref("full-screen-api.transition-duration.enter", "0 0");
user_pref("services.sync.prefs.sync.browser.uiCustomization.state", true);
user_pref("ui.popup.disable_autohide", false);
user_pref("privacy.webrtc.hideGlobalIndicator", true);
user_pref("privacy.webrtc.legacyGlobalIndicator", false);
user_pref("newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.urlbar.maxRichResults", 2);
user_pref("browser.urlbar.maxHistoricalSearchSuggestions", 2);
user_pref("browser.urlbar.suggest.quickactions", false);
user_pref("browser.urlbar.suggest.openpage", false);
user_pref("browser.urlbar.suggest.topsites", false);
user_pref("browser.urlbar.suggest.trending", false);
user_pref("browser.urlbar.suggest.weather", false);
user_pref("browser.urlbar.suggest.wikipedia", false);
user_pref("browser.urlbar.suggest.yelp", false);
user_pref("browser.fullscreen.autohide", false);
user_pref("browser.aboutConfig.showWarning", false);
user_pref("browser.toolbars.bookmarks.visibility", "never");
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.startup.homepage", "chrome://browser/content/blanktab.html");
user_pref("browser.fixup.domainwhitelist.go", true);
user_pref("browser.tabs.hoverPreview.enabled", false);
user_pref("browser.translations.neverTranslateLanguages", "fa");
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.creditCards.enabled", false);
user_pref("sidebar.verticalTabs", true);
user_pref("sidebar.revamp", true);
user_pref("sidebar.animation.enabled", false);
user_pref("sidebar.position_start", false);
user_pref("sidebar.animation.expand-on-hover.duration-ms", 0);
user_pref("sidebar.animation.expand-on-hover.delay-duration-ms", 0);
user_pref("signon.rememberSignons", false);

/** Experimenting with some settings from BetterBox: ***/

/** DISK AVOIDANCE ***/
user_pref("browser.cache.disk.enable", false);
user_pref("browser.privatebrowsing.forceMediaMemoryCache", true);
user_pref("media.memory_cache_max_size", 65536);
user_pref("browser.sessionstore.interval", 60000);

/** SHUTDOWN & SANITIZING ***/
user_pref("privacy.history.custom", true);
user_pref("browser.privatebrowsing.resetPBM.enabled", true);

/** SPECULATIVE LOADING ***/
user_pref("network.http.speculative-parallel-limit", 0);
user_pref("network.dns.disablePrefetch", true);
user_pref("network.dns.disablePrefetchFromHTTPS", true);
user_pref("browser.urlbar.speculativeConnect.enabled", false);
user_pref("browser.places.speculativeConnect.enabled", false);
user_pref("network.prefetch-next", false);

/** TELEMETRY ***/
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.coverage.opt-out", true);
user_pref("toolkit.coverage.opt-out", true);
user_pref("toolkit.coverage.endpoint.base", "");
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("datareporting.usage.uploadEnabled", false);
