import cf from "cloudfront";

async function handler(event) {
  let build_id =
    event.request.cookies.build_id && event.request.cookies.build_id.value;

  const build_id_kvs_key = "prod_build_id";

  if (!build_id) {
    try {
      const kvsId = "5ad9022a-1dcb-4407-92e7-e7687c3fbada";
      // This fails if the key value store is not associated with the function
      const kvsHandle = cf.kvs(kvsId);
      build_id = await kvsHandle.get(build_id_kvs_key);
    } catch (err) {
      console.log(`Kvs key lookup failed for ${build_id_kvs_key} ${err}`);
    }
  }

  var request = event.request;
  var uri = request.uri;

  if (!uri.match(/\.(js|css|svg)$/)) {
    request.uri = "/" + build_id + "/index.html";
  }

  console.log(request);
  return request;
}
