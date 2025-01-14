using System;
using System.Collections.Generic;
using System.Linq;
using Library.Api.Entities;
using Microsoft.EntityFrameworkCore;

namespace Library.Api.Services
{
    public class AuthorRepository : IAuthorRepository
    {
        private readonly ApplicationContext _context;

        public AuthorRepository(ApplicationContext context)
        {
            _context = context;
        }

        public IEnumerable<Author> GetAuthors()
        {
            return _context.Authors;
        }

        public Author GetAuthor(Guid authorId)
        {
            return _context.Authors.FirstOrDefault(it => it.Id == authorId);
        }

        public void UpdateAuthor(Author author)
        {

        }

        public bool AuthorExists(Guid authorId)
        {
            return _context.Authors.Any(it => it.Id == authorId);
        }

        public void CreateBook(Guid authorId, Book book)
        {
            book.AuthorId = authorId;

            _context.Books.Add(book);
        }

        public IEnumerable<Book> GetBooks(Guid authorId)
        {
            return _context.Books.Include(it => it.Author).Where(it => it.AuthorId == authorId);
        }

        public Book GetBook(Guid authorId, Guid bookId)
        {
            return _context.Books.Include(it => it.Author).FirstOrDefault(it => it.AuthorId == authorId && it.Id == bookId);
        }

        public void SaveChanges()
        {
            _context.SaveChanges();
        }
    }
}
