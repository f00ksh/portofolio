'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"manifest.json": "afbad595473125d9919e55440bb9d114",
"main.dart.mjs": "fe8d670abb9e7b1bf8fc7642120a8956",
"index.html": "314e8714791d7225ba2459ee2081c0c3",
"/": "314e8714791d7225ba2459ee2081c0c3",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "5686d58ad76a864c6fd6f941a05a1df3",
"assets/assets/svg/tech/kotlin.svg": "f304fb118d5c38fe1766179160017000",
"assets/assets/svg/tech/supabase.svg": "6f813c1935d484890a2b7e231edd9c83",
"assets/assets/svg/tech/postman.svg": "1530f27e37e67f53f969ff805b870568",
"assets/assets/svg/tech/dart.svg": "5b8e5fc72d27e2cf08d32a7d4898421a",
"assets/assets/svg/tech/gcloud.svg": "62ee6d912d446d8419003cfd3ea8510f",
"assets/assets/svg/tech/rust.svg": "771f146869bc0a37d48d8a2780e723d7",
"assets/assets/svg/tech/linux.svg": "62b23b2d9440e3ae0b399b87a3e2e7c9",
"assets/assets/svg/tech/github.svg": "f4b404a64abcad3ecef70db84457d7fa",
"assets/assets/svg/tech/flutter.svg": "3d3d4d45f2f4c76cdc273ad62ea4d732",
"assets/assets/svg/tech/vscode.svg": "eb2179b390a93109dc35fa14ed7b2a5c",
"assets/assets/svg/tech/jirra.svg": "29e75375cc153ca4c0b3c548efed0b63",
"assets/assets/svg/tech/figma.svg": "29d32f3dc34eec1ec71988e5a549d737",
"assets/assets/svg/tech/git.svg": "191f2aba8aeeae8943af3b59234ff0e7",
"assets/assets/svg/tech/postgress.svg": "1141ff0694e64af788ee95cba3286b0a",
"assets/assets/svg/tech/docker.svg": "9c0c9a2f583ce35b2edb1e6fae755973",
"assets/assets/svg/tech/mysql.svg": "f11e3fa3b05b9220e1229767ac0a74db",
"assets/assets/svg/tech/graphQl.svg": "281f51f218ede689416c1126b5bba907",
"assets/assets/svg/tech/firebase.svg": "1b582dddbe55c8bfa39ec46e59546dee",
"assets/assets/svg/plus.svg": "f7acb0c069b7a4a1300fa630dd4f06bf",
"assets/assets/cursors/default.png": "ce093ef0320250347aed744a5e0d7d7d",
"assets/assets/cursors/pointer.png": "97094313c9e43038715ce5308e75707a",
"assets/assets/cursors/text.png": "f28f70243d1a07c310eda9f61615e295",
"assets/assets/fonts/carton.ttf": "03053290fe3acfda8f5ccd9581abda2e",
"assets/assets/fonts/Satoshi.ttf": "bc0207192e408b721fa14151690c6a66",
"assets/assets/animations/ciao.riv": "710d10ff826bf0eae58ce8631c92cf14",
"assets/assets/animations/messagesent3.riv": "f5667ad029dfb6ab777a9f626d19fac0",
"assets/assets/animations/Avatar.riv": "6cb091ba28e96bda8e58f88c4fc75934",
"assets/assets/animations/award.json": "c5f6852f42b32a1a630725ba033f7536",
"assets/assets/animations/messagesent.json": "4119a92032bb221a28922e327dbabb51",
"assets/assets/animations/greenplane.json": "708edfd91cf341e23403e6214044a83b",
"assets/assets/animations/Hello.json": "1104cd17850b615ecbf79bd2bde37b82",
"assets/assets/animations/ciao.json": "a8e405ca74a37b480aba82dbd46e29b5",
"assets/assets/animations/scroll_down.json": "757bfb6c3a5bcd3247fbdb05666a914f",
"assets/assets/animations/pinkpaperplane.json": "fbe1e6c1cff85a0214bc3cf729bf640e",
"assets/assets/animations/Avatar.json": "079f241748abedcce787f830f91f9bbd",
"assets/fonts/MaterialIcons-Regular.otf": "c0ad29d56cfe3890223c02da3c6e0448",
"assets/NOTICES": "62aa4e246749cccb0353a4eb8aa622b0",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "1f5a2f9ad771db1d18c34040be2af899",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "262525e2081311609d1fdab966c82bfc",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "269f971cec0d5dc864fe9ae080b19e23",
"assets/FontManifest.json": "3377818b9e59edd344c6d2d73768557b",
"assets/AssetManifest.bin": "d234f8404e15b28c1c23dc6a202ef919",
"assets/AssetManifest.json": "3c75d913072233ae81d59b8cc8a9d07d",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"main.dart.wasm": "a42fc86bb83fecf8674bc5f294c4eebc",
"flutter_bootstrap.js": "daeb563018490d0dbf0f722be4e0d6da",
"version.json": "cc132570d6d238130e38adc59e1f998d",
"main.dart.js": "fe657c378ef1a9fa23c40f1cd283ddad"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"main.dart.wasm",
"main.dart.mjs",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
