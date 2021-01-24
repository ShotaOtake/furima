// ＜実装手順＞
// ①　JSを動かす記述
window.addEventListener("load", function(){

  // ②　価格入力欄のID属性を手がかりに入力値を変数Aに入れる
 const priceInput = document.getElementById("item-price")
//  住所情報を取得

// ③　上記で入れた変数Aに対しての発火条件を書く
  priceInput.addEventListener("input", function(){
// ④　②の中で入力された値を取り出して変数Bに入れる
  const price = document.getElementById("item-price").value

// ⑤　変数Bに対して計算し変数C,Dに入れる（出品手数料Cと利益D）（小数点以下をどうするか？？）  
    const tax = price * 0.1
    const profit = price - tax

// ⑥　手数料部分には変数Cの値を入れる
    const taxForm = document.getElementById("add-tax-price")
    taxForm.textContent = Math.floor(tax)  
    // Math.floor()  小数点の切り捨て

// ⑦　利益部分に変数Dの値を入れる
    const profitForm = document.getElementById("profit")
    profitForm.textContent = Math.floor(profit)  


  })
});
