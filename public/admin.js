const input = document.getElementById('search-input');
const container = document.getElementById('posts-container');

input.addEventListener('input', () => {
  const query = input.value.trim();

  // Se o campo estiver vazio, você pode querer recarregar a página
  // ou buscar todos novamente para restaurar o estado original
  fetch(`/search?q=${encodeURIComponent(query)}`)
    .then(response => response.text())
    .then(html => {
      // Como agora só existe um "posts-container", 
      // o innerHTML substituirá apenas o que está dentro dele.
      container.innerHTML = html;
    })
    .catch(error => console.error('Erro na busca:', error));
});