helpers
def get_data_from_db(title)
  return run_sql(Movie.where(title: @title).first)
end