import { Knex } from 'knex';

export async function up(knex: Knex): Promise<void> {
  // Users table
  await knex.schema.createTable('users', (table) => {
    table.uuid('id').primary().defaultTo(knex.raw('gen_random_uuid()'));
    table.string('email').unique().notNullable();
    table.string('password').notNullable();
    table.string('name').notNullable();
    table.enum('role', ['admin', 'manager', 'cook', 'delivery', 'cleaner']).notNullable();
    table.timestamps(true, true);
  });

  // Orders table
  await knex.schema.createTable('orders', (table) => {
    table.uuid('id').primary().defaultTo(knex.raw('gen_random_uuid()'));
    table.jsonb('items').notNullable();
    table.enum('status', [
      'pending',
      'preparing',
      'ready',
      'delivering',
      'delivered',
      'cancelled'
    ]).notNullable();
    table.decimal('total_amount', 10, 2).notNullable();
    table.string('customer_id').notNullable();
    table.uuid('assigned_to').references('id').inTable('users');
    table.timestamps(true, true);
  });

  // Cleaning tasks table
  await knex.schema.createTable('cleaning_tasks', (table) => {
    table.uuid('id').primary().defaultTo(knex.raw('gen_random_uuid()'));
    table.string('title').notNullable();
    table.text('description');
    table.enum('status', ['pending', 'in-progress', 'completed']).notNullable();
    table.uuid('assigned_to').references('id').inTable('users');
    table.timestamp('due_date').notNullable();
    table.timestamps(true, true);
  });
}

export async function down(knex: Knex): Promise<void> {
  await knex.schema.dropTable('cleaning_tasks');
  await knex.schema.dropTable('orders');
  await knex.schema.dropTable('users');
}
