document.addEventListener("DOMContentLoaded", function() {
  const addMemberBtn = document.getElementById("add-member-btn");
  const memberField = document.getElementById("member-field");
  const memberForm = document.querySelector(".member-form");

  addMemberBtn.addEventListener("click", function(e) {
    e.preventDefault();

    // Clona o formulário
    const newMemberForm = memberForm.cloneNode(true);

    // Atualiza os IDs/nomes dos novos elementos para nao gerar conflitos de repetição
    const newUserIdSelect = newMemberForm.querySelector(".user-id");
    const newUserTypeSelect = newMemberForm.querySelector(".user-type");

    if (newUserIdSelect && newUserTypeSelect) {
      // Gera um ID único para cada item criado
    const timestamp = new Date().getTime();

    newUserIdSelect.name = `project[project_members_attributes][${timestamp}][user_id]`;
    newUserTypeSelect.name = `project[project_members_attributes][${timestamp}][user_type]`;

    // Adiciona o clone do formulário
    memberField.appendChild(newMemberForm);

    // Botão de excluir do formulário clonado
    const removeBtn = newMemberForm.querySelector(".remove-member-btn");
    removeBtn.addEventListener("click", function() {
      newMemberForm.remove();
    });
  } else {
    console.error("User ID or User Type element not found in the cloned form.");
  }
});

// Botão de excluir inicial
const initialRemoveBtn = memberForm.querySelector(".remove-member-btn");
if (initialRemoveBtn) {
  initialRemoveBtn.addEventListener("click", function() {
    memberForm.remove();
  });
}
});
