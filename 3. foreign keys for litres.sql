ALTER TABLE libraries_users 
  ADD CONSTRAINT libraries_users_library_id_fk
    FOREIGN KEY (library_id) REFERENCES libraries(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT libraries_users_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;
      
ALTER TABLE operations_users 
  ADD CONSTRAINT operations_users_operation_id_fk
    FOREIGN KEY (operation_id) REFERENCES operations(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT operations_users_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;
      
ALTER TABLE payments
	ADD CONSTRAINT payments_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON DELETE CASCADE,
    ADD CONSTRAINT payments_payment_type_id_fk
		FOREIGN KEY (payment_type_id) REFERENCES payment_typeS(id)
			ON DELETE CASCADE;
            
ALTER TABLE mailing_users 
  ADD CONSTRAINT mailing_users_mailing_id_fk
    FOREIGN KEY (mailing_id) REFERENCES mailing(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT mailing_users_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;
      
ALTER TABLE books
	ADD CONSTRAINT books_author_id_fk
		FOREIGN KEY (author_id) REFERENCES authors(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT books_series_id_fk
		FOREIGN KEY (series_id) REFERENCES series(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT books_genre_id_fk
		FOREIGN KEY (genre_id) REFERENCES genres(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT books_book_type_id_fk
		FOREIGN KEY (book_type_id) REFERENCES book_types(id)
			ON DELETE CASCADE; /* не создался ключ жанров*/
            
ALTER TABLE genres
	ADD CONSTRAINT genres_genre_group_id_fk
		FOREIGN KEY (genre_group_id) REFERENCES genre_groups(id)
			ON DELETE CASCADE;
            
ALTER TABLE litres_ratings
	ADD CONSTRAINT litres_ratings_book_id_fk
		FOREIGN KEY (book_id) REFERENCES books(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT litres_ratings_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON DELETE CASCADE;
            
ALTER TABLE tags_books
	ADD CONSTRAINT tags_books_book_id_fk
		FOREIGN KEY (book_id) REFERENCES books(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT tags_books_tag_id_fk
		FOREIGN KEY (tag_id) REFERENCES tags(id)
			ON DELETE CASCADE;
 
ALTER TABLE reviews
	ADD CONSTRAINT reviews_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT reviews_review_type_id_fk
		FOREIGN KEY (review_type_id) REFERENCES review_types(id)
			ON DELETE CASCADE; 
            
ALTER TABLE books_users
	ADD CONSTRAINT books_users_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT books_users_book_id_fk
		FOREIGN KEY (book_id) REFERENCES books(id)
			ON DELETE CASCADE;

ALTER TABLE users
	ADD CONSTRAINT users_bonus_card_id_fk
		FOREIGN KEY (bonus_card_id) REFERENCES bonus_cards(id)
			ON DELETE CASCADE;
