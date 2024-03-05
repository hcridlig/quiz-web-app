document.getElementById('inscription').addEventListener('click', function(e) {
    e.preventDefault();
    document.getElementById('connexion').style.display = 'none';
    document.getElementById('inscription-form').style.display = 'block';
  });
  
  document.getElementById('connexion-link').addEventListener('click', function(e) {
    e.preventDefault();
    document.getElementById('connexion').style.display = 'block';
    document.getElementById('inscription-form').style.display = 'none';
  });
  