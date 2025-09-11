function price () {
  const price = document.getElementById("item-price")
  const tax = document.getElementById('add-tax-price')
  const profit =document.getElementById('profit')

  if (!price) return;
  price.addEventListener("input", () => {
    
    const p = Number(price.value)
    if (Number.isNaN(p)){
      tax.textContent = "NaN";
      profit.textContent = "NaN";
    }else if (Number.isInteger(p)){
      const t = Math.floor(p / 10);
      const f = p - t ;
      tax.textContent = t;
      profit.textContent = f;
    }else{
      tax.textContent = "Integer";
      profit.textContent = "Integer";
    }
  });
};

window.addEventListener('turbo:load', price);
window.addEventListener("turbo:render", price);