# aosp-builder

Android OS ビルド用の VM を構築します。

## Prerequisites

1. Terraform をインストールしてください。

   - https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

1. EC2 で`ec2-key`という名前のキーペアを作成してください。

   - https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/create-key-pairs.html

## Usage

1. 次のコマンドを実行し、EC2 を構築してください。

   ```sh
   terraform plan
   terraform apply -auto-approve
   ```

1. SSH で EC2 にアクセスしてください。
   ```sh
   ssh ubuntu@<IPアドレス>
   ```
1. 次のコマンドで Android のソースコードをダウンロードします。
   ```sh
   repo init -u https://android.googlesource.com/platform/manifest
   repo sync -j32
   ```
1. 次のコマンドでビルドに必要なツール（lunch 等）をセットアップします。
   ```sh
   source build/envsetup.sh
   ```
1. 次のコマンドを実行すると、ビルドのターゲットが列挙されるのでターゲットを決定してください。
   ```sh
   lunch
   ```
1. 次のコマンドでビルド開始します。
   ```sh
   m
   ```

## 参考

https://source.android.com/docs/setup/start?hl=ja

## Tips

### デスクトップ環境、XRDP の設定

```sh
sudo adduser user
sudo gpasswd -a user sudo
sudo apt install -y ubuntu-desktop
sudo apt install -y xrdp
sudo systemctl restart xrdp
sudo systemctl enable xrdp.service
sudo systemctl enable xrdp-sesman.service
```

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                     | Version |
| ------------------------------------------------------------------------ | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.0  |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | >= 5.00 |

## Providers

No providers.

## Modules

| Name                                                                       | Source | Version |
| -------------------------------------------------------------------------- | ------ | ------- |
| <a name="module_aws_resources"></a> [aws_resources](#module_aws_resources) | ./aws  | n/a     |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.

<!-- END_TF_DOCS -->
