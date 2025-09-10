function price () {
  const price = document.getElementById("item-price")
  const tax = document.getElementById('add-tax-price')
  const profit =document.getElementById('profit')
  if (!price) return;
  price.addEventListener("input", () => {
    const p = parseInt(price.value,10)
    if (!isNaN(p)){
      const t = Math.floor(p / 10);
      const f = p - t ;
      tax.textContent = t;
      profit.textContent = f;
    }else{
      tax.textContent = "";
      profit.textContent = "";
    }
  });
};

window.addEventListener('turbo:load',price)