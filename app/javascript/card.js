const pay = () => {
  // 公開鍵を設定(Payjp.setPublicKeyというオブジェクトとメソッドはpayjp.jsの中で定義されているもの)
  Payjp.setPublicKey("pk_test_******************");
  // ”charge-form”というidを指定しフォーム全体の要素を取得
  const form = document.getElementById("charge-form");
  // そのフォームが送信（submit）されたときにイベントが発火
  form.addEventListener("submit", (e) => {
    // 通常のRuby on Railsにおけるフォーム送信処理はキャンセル(サーバーサイドへリクエストは送られない)
    e.preventDefault();
    
    // "charge-form"というidでフォームの情報を取得し、それをFormDataオブジェクトとして生成
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    // 生成したFormDataオブジェクトから、クレジットカードに関する情報を取得し、変数cardに代入するオブジェクトとして定義
    const card = {
      number: formData.get("order[number]"),
      cvc: formData.get("order[cvc]"),
      exp_month: formData.get("order[exp_month]"),
      exp_year: `20${formData.get("order[exp_year]")}`,
    };
  });
};

window.addEventListener("load", pay);