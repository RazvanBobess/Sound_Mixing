function recoms = recommendations(path, liked_theme, num_recoms, min_reviews, num_features)
  mat = read_mat(path);
  mat = preprocess(mat, min_reviews);
  [~, ~, V] = svds(mat, num_features);

  similarities = zeros(1, length(V));
  for i = 1:length(V)
    similarities(i) = cosine_similarity(V(i, :), V(liked_theme, :));
  endfor

  [~, indices] = sort(similarities, 'descend');
  recoms = indices(2:num_recoms+1);
end

