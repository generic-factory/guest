/*
 * Copyright (c) 2008-2015 Travis Geiselbrecht
 *
 * Use of this source code is governed by a MIT-style
 * license that can be found in the LICENSE file or at
 * https://opensource.org/licenses/MIT
 */
#include <lib/io.h>

#include <kern/err.h>
#include <ctype.h>
#include <kern/debug.h>
#include <assert.h>

ssize_t io_write(io_handle_t *io, const char *buf, size_t len) {
    DEBUG_ASSERT(io->magic == IO_HANDLE_MAGIC);

    if (!io->hooks->write)
        return ERR_NOT_SUPPORTED;

    return io->hooks->write(io, buf, len);
}

ssize_t io_read(io_handle_t *io, char *buf, size_t len) {
    DEBUG_ASSERT(io->magic == IO_HANDLE_MAGIC);

    if (!io->hooks->read)
        return ERR_NOT_SUPPORTED;

    return io->hooks->read(io, buf, len);
}

void io_write_commit(io_handle_t *io)
{
    DEBUG_ASSERT(io->magic == IO_HANDLE_MAGIC);

    if (io->hooks->write_commit)
        io->hooks->write_commit(io);
}

void io_lock(io_handle_t *io)
{
    DEBUG_ASSERT(io->magic == IO_HANDLE_MAGIC);

    if (io->hooks->lock)
        io->hooks->lock(io);
}

void io_unlock(io_handle_t *io)
{
    DEBUG_ASSERT(io->magic == IO_HANDLE_MAGIC);

    if (io->hooks->unlock)
        io->hooks->unlock(io);
}