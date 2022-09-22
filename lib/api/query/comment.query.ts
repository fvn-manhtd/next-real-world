import { extendType, intArg, nonNull, stringArg } from 'nexus';
import { Context } from '../context';
import { checkArticleById } from '../mutation/article.mutation';

const CommentQuery = extendType({
  type: 'Query',
  definition(t) {
    t.nonNull.list.nonNull.field('comments', {
      type: 'Comment',
      args: {
        articleId: nonNull(stringArg()),
        limit: intArg({ default: 20 }),
        offset: intArg({ default: 0 }),
        cursor: stringArg(),
      },
      validate: ({ number, string }) => ({
        articleId: string().required(),
        limit: number().integer().positive().max(100),
        offset: number().integer(),
        cursor: string(),
      }),
      resolve: async (_, { articleId, limit, offset, cursor }, context: Context) => {
        const article = await checkArticleById(context, articleId);
        let skip, take;
        if (cursor && limit && offset) {
          skip = 1;
          take = offset > 0 ? limit : -limit;
        } else {
          skip = offset || undefined;
          take = limit || undefined;
        }
        return context.prisma.comment.findMany({
          where: { del: false, articleId: article.id },
          skip,
          take,
          cursor: cursor ? { id: cursor } : undefined,
          orderBy: { createdAt: 'asc' },
        });
      },
    });
  },
});

export default CommentQuery;
