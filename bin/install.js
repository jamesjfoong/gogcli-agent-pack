#!/usr/bin/env node
/**
 * gogcli-agent-pack installer
 *
 * Usage:
 *   npx @jamesjfoong/gogcli-agent-pack                # Install symlinks
 *   npx @jamesjfoong/gogcli-agent-pack --dry-run      # Preview
 *   npx @jamesjfoong/gogcli-agent-pack --help         # Show help
 *
 * Installs gogcli agent instructions into Pi, Claude Desktop,
 * Cursor, GitHub Copilot, OpenCode, Windsurf, and Cline.
 */
const fs = require('fs');
const path = require('path');

const PKG_ROOT = path.resolve(__dirname, '..');
const GUIDE_PATH = path.join(PKG_ROOT, 'AGENTS-GUIDE.md');
const SKILL_SRC = path.join(PKG_ROOT, 'skills', 'gogcli', 'SKILL.md');

const AGENTS = [
  {
    name: 'Pi',
    type: 'copy',
    dest: path.join(getHome(), '.pi', 'agent', 'skills', 'gogcli', 'SKILL.md'),
    file: SKILL_SRC,
  },
  {
    name: 'Claude Desktop',
    type: 'symlink',
    dest: path.join(getHome(), '.claude', 'instructions.md'),
  },
  {
    name: 'Cursor',
    type: 'symlink',
    dest: path.join(getHome(), '.cursorrules'),
  },
  {
    name: 'GitHub Copilot',
    type: 'symlink',
    dest: path.join(getHome(), '.github', 'copilot-instructions.md'),
  },
  {
    name: 'OpenCode',
    type: 'symlink',
    dest: path.join(getHome(), '.opencode.md'),
  },
  {
    name: 'Windsurf',
    type: 'symlink',
    dest: path.join(getHome(), '.windsurfrules'),
  },
  {
    name: 'Cline',
    type: 'symlink',
    dest: path.join(getHome(), '.clinerules'),
  },
];

function getHome() {
  return process.env.HOME || process.env.USERPROFILE || '~';
}

function log(icon, label, msg) {
  console.log(`${icon} ${label}: ${msg}`);
}

function install(dryRun) {
  if (!fs.existsSync(GUIDE_PATH)) {
    console.error('❌ AGENTS-GUIDE.md not found. Are you running from the package root?');
    process.exit(1);
  }

  console.log('\n🔌 Installing gogcli agent instructions...\n');

  for (const agent of AGENTS) {
    const destDir = path.dirname(agent.dest);

    if (agent.type === 'copy') {
      if (!fs.existsSync(agent.file)) {
        log('❌', agent.name, `Source not found: ${agent.file}`);
        continue;
      }
      if (dryRun) {
        log('📋', agent.name, `Would copy skill to ${agent.dest}`);
        continue;
      }
      fs.mkdirSync(destDir, { recursive: true });
      fs.copyFileSync(agent.file, agent.dest);
      log('✅', agent.name, `Skill → ${agent.dest}`);
    } else if (agent.type === 'symlink') {
      if (fs.existsSync(agent.dest) && !fs.lstatSync(agent.dest).isSymbolicLink()) {
        log('⚠️ ', agent.name, `${agent.dest} exists (not a symlink) — skipping`);
        continue;
      }
      if (dryRun) {
        log('📋', agent.name, `Would symlink → ${agent.dest}`);
        continue;
      }
      fs.mkdirSync(destDir, { recursive: true });
      try { fs.unlinkSync(agent.dest); } catch { /* ok */ }
      fs.symlinkSync(GUIDE_PATH, agent.dest);
      log('✅', agent.name, `→ ${agent.dest}`);
    }
  }

  if (!dryRun) {
    console.log('\n🎉 Done! All agents can now access gogcli instructions.');
    console.log('   Run this installer on any new machine to set things up.\n');
  }
}

function showHelp() {
  console.log(`
gogcli-agent-pack — Install gogcli agent instructions

USAGE:
  npx @jamesjfoong/gogcli-agent-pack          Install for all agents
  npx @jamesjfoong/gogcli-agent-pack --dry-run  Preview changes
  npx @jamesjfoong/gogcli-agent-pack --help     This help
  npx @jamesjfoong/gogcli-agent-pack --version  Show version
`);
}

// --- CLI ---
const args = process.argv.slice(2);
if (args.includes('--help') || args.includes('-h')) {
  showHelp();
} else if (args.includes('--version') || args.includes('-v')) {
  const pkg = JSON.parse(fs.readFileSync(path.join(PKG_ROOT, 'package.json'), 'utf-8'));
  console.log(pkg.version);
} else if (args.includes('--dry-run')) {
  install(true);
} else {
  install(false);
}
