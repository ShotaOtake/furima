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
      number: formData.get("pay_form[number]"),
      cvc: formData.get("pay_form[cvc]"),
      exp_month: formData.get("pay_form[exp_month]"),
      exp_year: `20${formData.get("pay_form[exp_year]")}`,
    };

    // カードの情報をトークン化
    // 第一引数のcardは、PAY.JP側に送るカードの情報で直前で定義したカード情報のオブジェクト
    // 第二引数のcallbackには、PAY.JP側からトークンが送付された後に実行する処理を記述
    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        console.log(token)
      }
    });
  });
};

window.addEventListener("load", pay);