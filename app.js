const inp = document.querySelector("input");
const p = document.querySelector(".output");

inp.addEventListener("input", () => {
  if (inp.value.trim() === "") {
    p.innerText = "Your text will appear here";
    p.style.color = "#94a3b8";
  } else {
    p.innerText = inp.value;
    p.style.color = "#e5e7eb";
  }
});

