const pay = () => {
  // ”charge-form”というidを指定しフォーム全体の要素を取得
  const form = document.getElementById("charge-form");
  // そのフォームが送信（submit）されたときにイベントが発火
  form.addEventListener("submit", (e) => {
    // 通常のRuby on Railsにおけるフォーム送信処理はキャンセル(サーバーサイドへリクエストは送られない)
    e.preventDefault();
    console.log("フォーム送信時にイベント発火")
  });
};

window.addEventListener("load", pay);