function reduced_mat = preprocess(mat, min_reviews)
  # TODO: Remove all user rows from `mat` that have strictly less then `min_reviews` reviews.
  count_reviews = sum(mat != 0, 2);

  valid_users = count_reviews >= min_reviews;

  reduced_mat = mat(valid_users, :);
end
