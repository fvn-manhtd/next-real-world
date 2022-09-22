/*
  Warnings:

  - The primary key for the `blog_article` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `blog_articles_tags` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `blog_comment` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `blog_favorites` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `blog_follows` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `blog_tag` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `blog_user` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - A unique constraint covering the columns `[id]` on the table `blog_article` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[id]` on the table `blog_comment` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[id]` on the table `blog_tag` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[id]` on the table `blog_user` will be added. If there are existing duplicate values, this will fail.

*/
-- DropForeignKey
ALTER TABLE `blog_article` DROP FOREIGN KEY `blog_article_author_id_fkey`;

-- DropForeignKey
ALTER TABLE `blog_articles_tags` DROP FOREIGN KEY `blog_articles_tags_article_id_fkey`;

-- DropForeignKey
ALTER TABLE `blog_articles_tags` DROP FOREIGN KEY `blog_articles_tags_tag_id_fkey`;

-- DropForeignKey
ALTER TABLE `blog_comment` DROP FOREIGN KEY `blog_comment_article_id_fkey`;

-- DropForeignKey
ALTER TABLE `blog_comment` DROP FOREIGN KEY `blog_comment_author_id_fkey`;

-- DropForeignKey
ALTER TABLE `blog_favorites` DROP FOREIGN KEY `blog_favorites_article_id_fkey`;

-- DropForeignKey
ALTER TABLE `blog_favorites` DROP FOREIGN KEY `blog_favorites_user_id_fkey`;

-- DropForeignKey
ALTER TABLE `blog_follows` DROP FOREIGN KEY `blog_follows_follower_id_fkey`;

-- DropForeignKey
ALTER TABLE `blog_follows` DROP FOREIGN KEY `blog_follows_following_id_fkey`;

-- AlterTable
ALTER TABLE `blog_article` DROP PRIMARY KEY,
    MODIFY `id` VARCHAR(191) NOT NULL,
    MODIFY `author_id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `blog_articles_tags` DROP PRIMARY KEY,
    MODIFY `article_id` VARCHAR(191) NOT NULL,
    MODIFY `tag_id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`article_id`, `tag_id`);

-- AlterTable
ALTER TABLE `blog_comment` DROP PRIMARY KEY,
    MODIFY `id` VARCHAR(191) NOT NULL,
    MODIFY `article_id` VARCHAR(191) NOT NULL,
    MODIFY `author_id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `blog_favorites` DROP PRIMARY KEY,
    MODIFY `article_id` VARCHAR(191) NOT NULL,
    MODIFY `user_id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`article_id`, `user_id`);

-- AlterTable
ALTER TABLE `blog_follows` DROP PRIMARY KEY,
    MODIFY `follower_id` VARCHAR(191) NOT NULL,
    MODIFY `following_id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`follower_id`, `following_id`);

-- AlterTable
ALTER TABLE `blog_tag` DROP PRIMARY KEY,
    MODIFY `id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `blog_user` DROP PRIMARY KEY,
    MODIFY `id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- CreateIndex
CREATE UNIQUE INDEX `blog_article_id_key` ON `blog_article`(`id`);

-- CreateIndex
CREATE UNIQUE INDEX `blog_comment_id_key` ON `blog_comment`(`id`);

-- CreateIndex
CREATE UNIQUE INDEX `blog_tag_id_key` ON `blog_tag`(`id`);

-- CreateIndex
CREATE UNIQUE INDEX `blog_user_id_key` ON `blog_user`(`id`);

-- AddForeignKey
ALTER TABLE `blog_follows` ADD CONSTRAINT `blog_follows_follower_id_fkey` FOREIGN KEY (`follower_id`) REFERENCES `blog_user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `blog_follows` ADD CONSTRAINT `blog_follows_following_id_fkey` FOREIGN KEY (`following_id`) REFERENCES `blog_user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `blog_article` ADD CONSTRAINT `blog_article_author_id_fkey` FOREIGN KEY (`author_id`) REFERENCES `blog_user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `blog_favorites` ADD CONSTRAINT `blog_favorites_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `blog_user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `blog_favorites` ADD CONSTRAINT `blog_favorites_article_id_fkey` FOREIGN KEY (`article_id`) REFERENCES `blog_article`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `blog_comment` ADD CONSTRAINT `blog_comment_author_id_fkey` FOREIGN KEY (`author_id`) REFERENCES `blog_user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `blog_comment` ADD CONSTRAINT `blog_comment_article_id_fkey` FOREIGN KEY (`article_id`) REFERENCES `blog_article`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `blog_articles_tags` ADD CONSTRAINT `blog_articles_tags_article_id_fkey` FOREIGN KEY (`article_id`) REFERENCES `blog_article`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `blog_articles_tags` ADD CONSTRAINT `blog_articles_tags_tag_id_fkey` FOREIGN KEY (`tag_id`) REFERENCES `blog_tag`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
