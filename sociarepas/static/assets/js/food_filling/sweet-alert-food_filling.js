document.addEventListener("DOMContentLoaded", function () {
  const form = document.getElementById("food_filling-form");
  if (form) {
    form.addEventListener("submit", function (e) {
      e.preventDefault();

      const formData = new FormData(form);

      fetch(form.action, {
        method: "POST",
        body: formData,
        headers: {
          "X-Requested-With": "XMLHttpRequest",
          "X-CSRFToken": form.querySelector("[name=csrfmiddlewaretoken]").value,
        },
      })
        .then((response) => response.json())
        .then((data) => {
          if (data.status === "success") {
            Swal.fire({
              icon: "success",
              title: "¡Éxito!",
              text: data.message,
            }).then(() => {
              window.location.reload();
            });
          } else {
            Swal.fire({
              icon: "error",
              title: "Error",
              text: data.message,
            });
          }
        })
        .catch(() => {
          Swal.fire({
            icon: "error",
            title: "Error inesperado",
            text: "Ocurrió un error al procesar la solicitud.",
          });
        });
    });
  }
});

//Función para obtener el CSRF token
function getCookie(name) {
  let cookieValue = null;
  if (document.cookie && document.cookie !== "") {
    const cookies = document.cookie.split(";");
    for (let i = 0; i < cookies.length; i++) {
      const cookie = cookies[i].trim();
      // Does this cookie string begin with the name we want?
      if (cookie.substring(0, name.length + 1) === name + "=") {
        cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
        break;
      }
    }
  }
  return cookieValue;
}

//Editar

document.addEventListener("DOMContentLoaded", function () {
  const editForm = document.getElementById("edit_food_filling-form");

  document.querySelectorAll(".edit-food_filling-button").forEach((button) => {
    button.addEventListener("click", function () {
      const id = this.dataset.id;
      const name = this.dataset.name;
      const quantity = this.dataset.quantity;

      document.querySelector(
        '#edit_food_filling-form input[name="name"]'
      ).value = name;
      document.querySelector(
        '#edit_food_filling-form input[name="initial_quantity"]'
      ).value = quantity;
      document.querySelector(
        '#edit_food_filling-form select[name="fk_supplier"]'
      ).value = this.dataset.supplier || "";

      const originalAction = document
        .getElementById("edit_food_filling-form")
        .getAttribute("data-base-action");
      document
        .getElementById("edit_food_filling-form")
        .setAttribute("action", originalAction.replace("0", id));

      const modal = new bootstrap.Modal(
        document.getElementById("edit-food_filling-modal")
      );
      modal.show();
    });
  });

  if (editForm) {
    editForm.addEventListener("submit", function (e) {
      e.preventDefault();

      const formData = new FormData(this);
      fetch(this.action, {
        method: "POST",
        body: formData,
        headers: {
          "X-Requested-With": "XMLHttpRequest",
          "X-CSRFToken": this.querySelector("[name=csrfmiddlewaretoken]").value,
        },
      })
        .then((response) => response.json())
        .then((data) => {
          if (data.status === "success") {
            Swal.fire("¡Actualizado!", data.message, "success").then(() => {
              // Cierra la modal correctamente con Bootstrap 5
              const modalEl = document.getElementById('edit-food_filling-modal');
              const modalInstance = bootstrap.Modal.getInstance(modalEl);
              if (modalInstance) modalInstance.hide();
              // Ahora recarga la página
              window.location.reload();
            });
          } else {
            Swal.fire("Error", data.message, "error");
          }
        })
        .catch(() => {
          Swal.fire(
            "Error",
            "Ocurrió un error al procesar la solicitud.",
            "error"
          );
        });
    });
  }
});

//Eliminar
$(document).on("click", ".delete-food_filling-button", function () {
  const food_fillingId = $(this).data("id");

  Swal.fire({
    title: "¿Eliminar relleno?",
    text: "Esta acción no se puede deshacer",
    icon: "warning",
    showCancelButton: true,
    confirmButtonText: "Sí, eliminar",
    cancelButtonText: "Cancelar",
  }).then((result) => {
    if (result.isConfirmed) {
      Swal.fire({
        title: "Eliminando...",
        allowOutsideClick: false,
        didOpen: () => {
          Swal.showLoading();
        },
      });

      fetch(`/food_filling/food_filling_delete/${food_fillingId}/`, {
        method: "POST",
        headers: {
          "X-CSRFToken": getCookie("csrftoken"),
          "Content-Type": "application/json",
        },
        body: "",
      })
        .then(async (response) => {
          Swal.close();
          let data;
          try {
            data = await response.json();
          } catch {
            data = {
              success: false,
              message: "Respuesta inválida del servidor",
            };
          }
          if (response.ok && data.success) {
            Swal.fire({
              icon: "success",
              title: "¡Eliminado!",
              text: "El relleno ha sido eliminado correctamente.",
            }).then(() => {
              window.location.reload();
            });
          } else {
            Swal.fire("Error", data.message || "Error al eliminar", "error");
          }
        })
        .catch((error) => {
          Swal.close();
          console.error("Error:", error);
          Swal.fire("Error", "No se pudo completar la eliminación", "error");
        });
    }
  });
});

//Solicitud de Stock
document.addEventListener("DOMContentLoaded", function () {
  const requestStockButtons = document.querySelectorAll(
    ".request-stock-button"
  );
  const foodFillingIdInput = document.getElementById(
    "request-stock-food-filling-id"
  );
  const foodFillingNameInput = document.getElementById(
    "request-stock-food-filling-name"
  );

  requestStockButtons.forEach((button) => {
    button.addEventListener("click", function () {
      const foodFillingId = this.dataset.id;
      const foodFillingName = this.dataset.name;

      foodFillingIdInput.value = foodFillingId;
      foodFillingNameInput.value = foodFillingName;
    });
  });
});

document.addEventListener("DOMContentLoaded", function () {
  const stockRequestForm = document.getElementById("request-stock-form");

  if (stockRequestForm) {
    stockRequestForm.addEventListener("submit", function (e) {
      e.preventDefault();

      const formData = new FormData(stockRequestForm);

      fetch(stockRequestForm.action, {
        method: "POST",
        body: formData,
        headers: {
          "X-Requested-With": "XMLHttpRequest",
          "X-CSRFToken": stockRequestForm.querySelector(
            "[name=csrfmiddlewaretoken]"
          ).value,
        },
      })
        .then((response) => response.json())
        .then((data) => {
          if (data.status === "success") {
            Swal.fire({
              icon: "success",
              title: "¡Éxito!",
              text: data.message,
            }).then(() => {
              window.location.reload();
            });
          } else {
            Swal.fire({
              icon: "error",
              title: "Error",
              text:
                data.message || "Ocurrió un error al procesar la solicitud.",
            });
          }
        })
        .catch(() => {
          Swal.fire({
            icon: "error",
            title: "Error inesperado",
            text: "Ocurrió un error al procesar la solicitud.",
          });
        });
    });
  }
});

//Datos faltantes para la modal de editar

$(document).on("click", ".edit-food_filling-button", function () {
  var id = $(this).data("id");
  var name = $(this).data("name");
  var quantity = $(this).data("quantity");
  var supplier = $(this).data("supplier");

  // Rellenar campos
  $('#edit-food_filling-modal input[name="name"]').val(name);
  $('#edit-food_filling-modal input[name="initial_quantity"]').val(quantity);
  $('#edit-food_filling-modal select[name="fk_supplier"]').val(supplier);

  // Cambiar la acción del formulario
  var baseAction = $("#edit_food_filling-form").data("base-action");
  var newAction = baseAction.replace(/0\/?$/, id + "/");
  $("#edit_food_filling-form").attr("action", newAction);
});


//Mensaje dado cuando un relleno se relaciona con una arepa 
then(async (response) => {
  Swal.close();
  let data;
  try {
    data = await response.json();
  } catch {
    data = {
      success: false,
      message: "Respuesta inválida del servidor",
    };
  }
  if (response.ok && data.success) {
    Swal.fire({
      icon: "success",
      title: "¡Eliminado!",
      text: "El relleno ha sido eliminado correctamente.",
    }).then(() => {
      window.location.reload();
    });
  } else {
    Swal.fire("Error", data.message || "Error al eliminar", "error");
  }
});
