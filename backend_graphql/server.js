const express = require('express');
const {graphqlHTTP} = require('express-graphql');
const app = express();
const {GraphQLSchema, GraphQLObjectType, GraphQLString, GraphQLInt,GraphQLNonNull, GraphQLList} = require('graphql');


const authors = [
	{ id: 1, name: 'J. K. Rowling' },
	{ id: 2, name: 'J. R. R. Tolkien' },
	{ id: 3, name: 'Brent Weeks' }
]

const books = [
	{ id: 1, name: 'Harry Potter and the Chamber of Secrets', authorId: 1 },
	{ id: 2, name: 'Harry Potter and the Prisoner of Azkaban', authorId: 1 },
	{ id: 3, name: 'Harry Potter and the Goblet of Fire', authorId: 1 },
	{ id: 4, name: 'The Fellowship of the Ring', authorId: 2 },
	{ id: 5, name: 'The Two Towers', authorId: 2 },
	{ id: 6, name: 'The Return of the King', authorId: 2 },
	{ id: 7, name: 'The Way of Shadows', authorId: 3 },
	{ id: 8, name: 'Beyond the Shadows', authorId: 3 }
]


//create author types

const AuthorType = new GraphQLObjectType({
    name: "AuthorType",
    description: "Describe the author types",
    fields:()=>({
        id: {type: GraphQLNonNull(GraphQLInt)},
        name: {type: GraphQLNonNull(GraphQLString)},
        books: {
            type: GraphQLList(BookType),
            resolve:(author)=>{
                return books.filter(book=>book.authorId === author.id)
            }
        }
    })
})
// set my book types
const BookType = new GraphQLObjectType ({
    name: "BookType",
    description: "Describe my book types",
    fields: () =>({
        id: {type: GraphQLNonNull(GraphQLInt)},
        name: {type: GraphQLNonNull(GraphQLString)},
        authorId: {type: GraphQLNonNull(GraphQLInt)},
        author: {
            type: AuthorType,
            resolve: (book)=>{
                return authors.find(author=> author.id === book.authorId);
            }
        }
    })
})

//set my root query
const RootQueryType = new GraphQLObjectType({
    name: "RootQuery",
    description: "Describe our root query",
    fields: ()=>({
        books: {
            type: GraphQLList(BookType),
            description: "List of Books",
            resolve: () => {
                return books.sort((a,b)=>b.id - a.id);
            }
        },
        book:{
            type: BookType,
            description: "Get a single book",
            args: {
                id: {type: GraphQLNonNull(GraphQLInt)}
            },
            resolve: (parent, args)=>{
                return books.find(book => book.id === args.id)
            }
        },
        authors:{
            type: GraphQLList(AuthorType),
            description: "Get all authors",
            resolve: ()=>{
                return authors.sort((a,b)=> b.id - a.id);
            }
        },
        author:{
            type: AuthorType,
            description:"Get a single author",
            args:{
                id: {type: GraphQLNonNull(GraphQLInt)}
            },
            resolve:(parent, args)=>{
                return authors.find(author=>author.id === args.id);
            }
        }
    })
})

const RootMutationType = new GraphQLObjectType({
    name: "Mutation",
    description:"Crud to our application",
    fields:()=>({
        addBook:{
            type: GraphQLList(BookType),
            args:{
                name: {type: GraphQLNonNull(GraphQLString)},
                authorId: {type: GraphQLNonNull(GraphQLInt)}
            },
            resolve:(parent, args)=>{
                const book = {
                    id: books.length + 1,
                    name: args.name,
                    authorId: args.authorId
                }
                books.push(book);
                return books.sort((a,b) => b.id - a.id);
            }
        },
        addAuthor:{
            type: GraphQLList(AuthorType),
            args:{
                name: {type: GraphQLNonNull(GraphQLString)}
            },
            resolve:(parent, args)=>{
                const author = {
                    id: authors.length + 1,
                    name: args.name
                }
                authors.push(author);
                return authors.sort((a,b) => b.id - a.id);
            }
        },
        updateBook:{
            type: GraphQLList(BookType),
            args:{
                name: {type: GraphQLNonNull(GraphQLString)},
                id: {type: GraphQLNonNull(GraphQLInt)}
            },
            resolve:(parent, args)=>{
                const bookIndex = books.findIndex(book => book.id == args.id);
                books[bookIndex].name = args.name;
                return books.sort((a,b)=> b.id - a.id);
            }
        },
        updateAuthor:{
            type: GraphQLList(AuthorType),
            args:{
                name: {type: GraphQLNonNull(GraphQLString)},
                id: {type: GraphQLNonNull(GraphQLInt)}
            },
            resolve:(parent, args)=>{
                const authorIndex = authors.findIndex(author => author.id == args.id);
                authors[authorIndex].name = args.name;
                return authors.sort((a,b)=> b.id - a.id);
            }
        },
        deleteBook:{
            type: GraphQLList(BookType),
            args:{
                id: {type: GraphQLNonNull(GraphQLInt)}
            },
            resolve: (parent, args)=>{
                const bookIndex = books.findIndex(book => book.id == args.id);
               
                if(bookIndex > -1){
                    books.splice(bookIndex, 1);
                }

                return books.sort((a,b)=> b.id - a.id);
            }

        },
        deleteAuthor:{
            type: GraphQLList(AuthorType),
            args:{
                id: {type: GraphQLNonNull(GraphQLInt)}
            },
            resolve: (parent, args)=>{
                const authorIndex = authors.findIndex(author => author.id == args.id);
                if(authorIndex > -1){
                    authors.splice(authorIndex,1);
                    const authorBooks = books.filter(book=>book.authorId == args.id);
                   
                    authorBooks.forEach((newbook)=>{
                        var bookIndex = books.findIndex(book=>book.id == newbook.id);
                        books.splice(bookIndex, 1);
                    })
                }
                return authors.sort((a,b)=> b.id - a.id);
            }

        }
    })
})

const schema = new GraphQLSchema({
    query: RootQueryType,
    mutation: RootMutationType
})


app.use('/graphql', graphqlHTTP({
    schema: schema,
    graphiql: true
}))
app.listen(5000,()=>console.log('Server is running'));