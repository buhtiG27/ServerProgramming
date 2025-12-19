# 電大生のQ&A

## servletでのgo-apiの呼び出し方

```java
            getServletContext().log("[rid=" + rid + "] Login calling API /api/login"); // API呼び出しをログに書き込む（任意）
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY); // この行は基本固定
            ApiResponse apires = api.postJson(request, "/login", json.toString()); // api.getかapi.postJsonを入れる
            // requestはdoGetやdoPostの引数名に合わせる
            // api.getは/apiを除くパスとあればパラメータを入れる
            // api.postJsonは第二引数にjsonをStringで入れる
            int status = apires.status
            String jsonString = apires.body
            // または
            JSONObject jsonObj = new JSONObject(apires.body);
            // ステータスコードによる条件分岐は
            if(apires.is2xx()){
                // 成功時処理...
            } else {
                // 失敗時処理...
            }
```

ログを書き込むときは関数の先頭に以下の行を追加する

```java
String rid = (String) request.getAttribute("rid");
```

## サーバーの連携，実行のやり方

0. コンテナアプリケーションをインストールする

    - Docker
    - Podman

    どちらかをインストールする  
    既にインストール済みのDockerを久々に使う場合，アップデートを忘れずに  
    以下のdockerコマンドはインストールされていればpodmanでも同様に動く  
    ~~というかpodmanでしか起動確認してない~~  

1. .envと/env/をルートディレクトリに配置する  
.env.exampleに.envファイルや他のenvファイルに入れるものが書いてあるから読んで.envファイルと/env/ディレクトリ、それぞれのenvファイルを作成し適切にコピーする
空欄の値はローカルでは自分で決めた適当な値でよい（起動後に変更するとバグるから注意）  

2. コンテナの作成と起動  
`docker compose up -d --build`  
ルートディレクトリにcompose.ymlがあるのを確認して上記のコマンドを打つ  
シェルに`nginx Started`と表示されたらサーバーが起動している  
これで <http://localhost:8000/> (.envでNGINX_PORT=8000にした場合)にアクセスするとページが表示される  

3. 実行中にソースコードを変更し反映させたい場合  
以下のコマンドを実行する  
`docker compose up -d --build java-web && docker compose restart nginx`  

4. 終了するとき  
`docker compose down`  
そこそこ重いので片付け忘れに注意  
もう一度起動するときは2へ

### コンテナでのログの見方

1. java，tomcat
`docker logs java_web`

2. go
`docker logs go_api`

3. nginx
`docker logs nginx`
アクセスログではなくシステムログ

4. postgres
`docker logs pgsql_db`
同じくシステムログ

### データベースのデータの確認の仕方（暫定）

`docker exec -it pgsql_db psql -U $db.env内のPOSTGRES_USER -d $db.env内のPOSTGRES_DB`
これでデータベースの中に入れるからSQL等で操作できる
