# S3静的ウェブサイトIaC

## 概要
Terraformを使い、AWS S3バケットを**新方式（aws_s3_bucket_website_configuration）**で静的ウェブサイトホスティング＆パブリック公開まで全自動化したサンプルプロジェクトです。

---

```
## ディレクトリ構成

aws-s3-static-site/
├── environments/ # 環境ごとの設定を格納（dev, prodなど分けられる）
│ └── dev/
│ ├── backend.tf # Terraform state（状態管理ファイル）をS3バケットで管理する設定
│ ├── main.tf # モジュール呼び出し・環境ごとメイン定義
│ ├── outputs.tf # apply後に出力したい値（バケット名/エンドポイントなど）を定義
│ └── variables.tf # main.tfで使う変数（今回は空でもOK）
├── modules/ # 再利用可能なモジュール群
│ └── s3_static_site/
│ ├── main.tf # S3・公開設定・ポリシー等をIaCで全管理
│ ├── outputs.tf # website_endpoint等の出力定義
│ └── variables.tf # バケット名などの変数定義
├── site/ # 静的Webサイト本体（バケットにアップする中身）
│ ├── index.html # メインページ（アップロードして公開）
│ └── error.html # エラーページ（アップロードして公開）
├── .github/
│ └── workflows/
│ └── terraform.yml # CI/CD自動化用（例）
├── .gitignore # Git除外ファイル
└── README.md # このファイル

yaml
コピーする
編集する

---
```

## 初期化・実行手順

```bash
cd environments/dev
terraform init
terraform validate   # (推奨・構文チェック)
terraform plan
terraform apply
破棄（コスト削減のため忘れずに！）

bash
コピーする
編集する
terraform destroy
バックエンド（状態管理）
Terraform stateファイルは、yoshitaka-terraform-state-bucket（S3）で一元管理

静的Webサイト公開の流れ
site/配下に index.html, error.html を作成

terraform applyでS3バケット・パブリックアクセス・バケットポリシー・Webサイト設定まで全自動化

静的ファイルはAWS CLIやコンソールでバケットにアップロード

bash
コピーする
編集する
aws s3 cp site/index.html s3://[バケット名]/index.html
aws s3 cp site/error.html s3://[バケット名]/error.html
terraform outputでエンドポイントURLが表示される
　→ ブラウザでアクセスして公開状態を確認

サンプルHTML
site/index.html
html
コピーする
編集する
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>terraform(IaC)でS3バケットに静的webサイトをホスティングしメインページとエラーページの2個をおいています。</title>
</head>
<body>
  <h1>ようこそ</h1>
  <p>このページはTerraformで自動作成したS3バケットにデプロイされています。</p>
  <footer>
    <small>練習</small>
  </footer>
</body>
</html>
site/error.html
html
コピーする
編集する
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>ページが見つかりません</title>
</head>
<body>
  <h1>404 Not Found</h1>
  <p>申し訳ありません。ページが見つかりませんでした。</p>
</body>
</html>
補足
バケットのパブリック公開/バケットポリシー/アクセスブロック解除もIaCで全自動

<<<<<<< HEAD
Terraformの状態管理（tfstate）はS3 backendで一元化
=======
状態管理もS3 backendで堅牢化

terraform outputでウェブサイトエンドポイントURLも即確認可能