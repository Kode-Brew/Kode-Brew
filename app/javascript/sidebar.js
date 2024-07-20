const closeMenu = document.querySelector(".toggle");

closeMenu.addEventListener("click", function () {
  document.querySelector("#sidebar").classList.toggle("expand");
});
