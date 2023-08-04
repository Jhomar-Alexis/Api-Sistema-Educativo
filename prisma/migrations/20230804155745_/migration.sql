-- CreateTable
CREATE TABLE `Usuarios` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `provider` VARCHAR(255) NOT NULL DEFAULT 'local',
    `password` VARCHAR(255) NOT NULL,
    `reset_password_token` VARCHAR(255) NOT NULL,
    `blocked` BOOLEAN NULL DEFAULT false,
    `role_id` INTEGER UNSIGNED NOT NULL,
    `created_at` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL,
    `school_levels_id` INTEGER UNSIGNED NULL,

    UNIQUE INDEX `Usuarios_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Roles` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `type` VARCHAR(255) NOT NULL,
    `created_at` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `Roles_name_key`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Nivel Escolar` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `gradeId` INTEGER UNSIGNED NULL,

    UNIQUE INDEX `Nivel Escolar_name_key`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Grados` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `school_Level_id` INTEGER UNSIGNED NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Secciones` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `gradeId` INTEGER UNSIGNED NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Estudiantes` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `fullName` VARCHAR(255) NOT NULL,
    `DNI` INTEGER NOT NULL,
    `studentCode` INTEGER NOT NULL,
    `grade_id` INTEGER UNSIGNED NOT NULL,
    `section_id` INTEGER UNSIGNED NULL,
    `created_at` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Cursos` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `Competence_1` VARCHAR(255) NULL,
    `Competence_2` VARCHAR(255) NULL,
    `studentId` INTEGER UNSIGNED NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Notas Escolares` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `note_1` VARCHAR(255) NOT NULL,
    `note_2` VARCHAR(255) NOT NULL,
    `note_3` VARCHAR(255) NOT NULL,
    `Final_Note` VARCHAR(255) NOT NULL,
    `courses_id` INTEGER UNSIGNED NULL,
    `students_id` INTEGER UNSIGNED NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Usuarios` ADD CONSTRAINT `Usuarios_role_id_fkey` FOREIGN KEY (`role_id`) REFERENCES `Roles`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Usuarios` ADD CONSTRAINT `Usuarios_school_levels_id_fkey` FOREIGN KEY (`school_levels_id`) REFERENCES `Nivel Escolar`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Grados` ADD CONSTRAINT `Grados_school_Level_id_fkey` FOREIGN KEY (`school_Level_id`) REFERENCES `Nivel Escolar`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Secciones` ADD CONSTRAINT `Secciones_gradeId_fkey` FOREIGN KEY (`gradeId`) REFERENCES `Grados`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Estudiantes` ADD CONSTRAINT `Estudiantes_section_id_fkey` FOREIGN KEY (`section_id`) REFERENCES `Secciones`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Cursos` ADD CONSTRAINT `Cursos_studentId_fkey` FOREIGN KEY (`studentId`) REFERENCES `Estudiantes`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Notas Escolares` ADD CONSTRAINT `Notas Escolares_courses_id_fkey` FOREIGN KEY (`courses_id`) REFERENCES `Cursos`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Notas Escolares` ADD CONSTRAINT `Notas Escolares_students_id_fkey` FOREIGN KEY (`students_id`) REFERENCES `Estudiantes`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

