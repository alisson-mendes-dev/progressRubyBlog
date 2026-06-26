const input = document.getElementById('search-input');
const container = document.getElementById('posts-container');

input.addEventListener('input', () => {
  const query = input.value.trim(); // .trim() remove espaços vazios acidentais

  // Se o campo estiver vazio, busca por todos os posts (string vazia)
  // Isso garante que ele "volte a exibir todos"
  fetch(`/search?q=${encodeURIComponent(query)}`)
    .then(response => response.text())
    .then(html => {
      // O "=" substitui todo o conteúdo antigo pelo novo,
      // eliminando a duplicação dos cards.
      container.innerHTML = html;
    })
    .catch(error => console.error('Erro na busca:', error));
});