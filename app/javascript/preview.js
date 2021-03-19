$(document).on('turbolinks:load', function () {
  $(function () {
    // 画像が選択された時に発火します
    $(document).on('change', '.hidden_file', function () {
      // .file_filedからデータを取得して変数fileに代入します
      var file = this.files[0];
      // FileReaderオブジェクトを作成します
      var reader = new FileReader();
      // DataURIScheme文字列を取得します
      reader.readAsDataURL(file);
      // 読み込みが完了したら処理が実行されます
      reader.onload = function () {
        // 読み込んだファイルの内容を取得して変数imageに代入します
        var image = this.result;
        // 画像データのみを入れ替えます
        $('.user-profile-image').attr({ src: image });
        $('.background-image').attr({ src: image });
      }
    });
  });
});