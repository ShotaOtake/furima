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
    // input要素を生成しフォームに加え、その値としてトークンをセット
    // valueは実際に送られる値、nameはその値を示すプロパティ名
    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden"> `;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }

      // クレカ情報削除
      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");

      // フォームの情報をサーバーサイドに送信
      // e.preventDefault();で通常のRuby on Railsにおけるフォーム送信処理はキャンセルされているためJavaScript側からフォームの送信処理を行う必要がある
      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);