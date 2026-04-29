/**
 * Migration script: Add new Primary subjects to live database
 * - Adds: Phonics, Quantitative Reasoning, Verbal Reasoning,
 *         Religious Studies, Vocational Aptitude, Literature
 *
 * Run from project root: node update-primary-subjects.js
 */

require('dotenv').config({ path: './backend/.env' });

const { Sequelize, DataTypes } = require('sequelize');

const sequelize = new Sequelize(process.env.DATABASE_URL, {
  dialect: 'postgres',
  logging: false,
  dialectOptions: {
    ssl: { require: true, rejectUnauthorized: false },
  },
});

const Subject = sequelize.define('Subject', {
  id:       { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
  name:     { type: DataTypes.STRING,  allowNull: false },
  category: { type: DataTypes.STRING,  allowNull: false },
  level:    { type: DataTypes.STRING,  allowNull: false },
  section:  { type: DataTypes.STRING,  allowNull: true },
});

const NEW_PRIMARY_SUBJECTS = [
  { name: 'Phonics',                category: 'Primary', level: 'General', section: null },
  { name: 'Quantitative Reasoning', category: 'Primary', level: 'General', section: null },
  { name: 'Verbal Reasoning',       category: 'Primary', level: 'General', section: null },
  { name: 'Religious Studies',      category: 'Primary', level: 'General', section: null },
  { name: 'Vocational Aptitude',    category: 'Primary', level: 'General', section: null },
  { name: 'Literature',             category: 'Primary', level: 'General', section: null },
];

async function run() {
  try {
    await sequelize.authenticate();
    console.log('\n✅ Database connected\n');

    console.log('── Adding new Primary subjects ───────────────────');
    for (const sub of NEW_PRIMARY_SUBJECTS) {
      const exists = await Subject.findOne({
        where: { name: sub.name, category: 'Primary', level: 'General' },
      });
      if (exists) {
        console.log(`  ⏭  Already exists: ${sub.name}`);
      } else {
        await Subject.create(sub);
        console.log(`  ✅ Added: ${sub.name}`);
      }
    }

    console.log('\n🎉 Primary subjects updated successfully!\n');
    process.exit(0);
  } catch (err) {
    console.error('\n❌ Migration failed:', err.message);
    process.exit(1);
  }
}

run();
