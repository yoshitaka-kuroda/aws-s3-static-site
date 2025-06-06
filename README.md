# S3静的ウェブサイトIaC

## 概要
TerraformでAWS S3バケットを作成し、静的ウェブサイトホスティングを設定するサンプルプロジェクトです。

”””
## ディレクトリ構成
aws-s3-static-site/
├── environments/                        # 環境ごとの設定を格納（dev, prodなど分けられる）
│   └── dev/                             # 今回はdev環境のみ
│       ├── backend.tf                   # Terraform state（状態管理ファイル）をS3バケットで管理する設定
│       ├── main.tf                      # 環境ごとに使うモジュール（例：S3）を呼び出すメイン定義ファイル
│       ├── outputs.tf                   # apply後に出力したい値（例：バケット名など）を定義
│       └── variables.tf                 # main.tfで使う変数があれば定義（今回は空でもOK）
├── modules/                             # 再利用可能なモジュール群（今回はS3静的サイト専用）
│   └── s3_static_site/
│       ├── main.tf                      # S3バケット（静的Webサイト用）を作成するリソース定義
│       ├── outputs.tf                   # モジュールから出力したい値（例：バケット名）を定義
│       └── variables.tf                 # モジュール内で使う変数（例：バケット名）を定義
├── site/                                # 静的Webサイトの実ファイル置き場（バケットにアップする中身）
│   ├── index.html                       # メインページ（手動でS3バケットにアップ）
│   └── error.html                       # エラーページ（手動でS3バケットにアップ）
├── .github/
│   └── workflows/
│       └── terraform.yml                # GitHub Actions用のワークフローファイル（CI/CD自動化例）
├── .gitignore                           # Git管理対象から除外するファイル/ディレクトリ一覧
└── README.md                            # プロジェクトの説明、構成、実行手順などをまとめたドキュメント

---
”””

## 初期化・実行手順

```bash
cd environments/dev
terraform init
terraform validate   # (オプション・構文チェック)
terraform plan
terraform apply
破棄（コスト削減のため忘れずに！）

bash
コピーする
編集する
terraform destroy
Backend
stateファイルはS3バケット（yoshitaka-terraform-state-bucket）で一元管理

静的Webサイトのサンプル中身
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
静的ファイル（index.html, error.html）はsite/ディレクトリで管理し、AWS CLIやコンソールからS3バケットへ手動アップロード

Terraformの状態管理（tfstate）はS3 backendで一元化
